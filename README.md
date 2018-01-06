# STM32-ldscripts

In this repo all of the linker scripts are stored.

I made a `simple.ld` Linker script which contains only the necessary stuff for linking with the llvm linker (ld.lld).
It also contains several controller specific linker scripts. The idea behind it is that you tell the compiler to use
one microcontroller dependent linker file and the `simple.ld` linker file.

    ... in meson.build ...
    # Add linker files
    linkfiles = files(['STM32-ldscripts/STM32F3/STM32F303VC6.ld', 'STM32-ldscripts/simple.ld'])

    foreach linkfile : linkfiles
     linkArgs += ['-Wl,-T,@0@/@1@'.format(meson.current_source_dir(), linkfile)]
    endforeach

The benefit of this is that I only have to maintain one linker script and can use it in all projects.
You can define more specialized linker scripts if needed and use the simple script as a prototype.

## microcontroller dependend linker file
In the microcontroller dependent linker file is just the memory layout defined.

    MEMORY{
    	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 20K
    	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 192K
    	EEPROM (xrw)  : ORIGIN = 0x08080000, LENGTH = 6K
    }

These variables are used in the `simple.ld` linker file.

## simple.ld

For simplicity this linker file does not include a heap definition.

For all Cortex-M microcontroller we have to put the `Interrupt Vector Table` first into the flash region.

    SECTIONS
    {
    .isr_vector : {
        . = ALIGN(4);         /* align */
        _sisr_vector = .;     /* define start symbol */
        KEEP(*(.isr_vector))  /* Interrupt vectors */
        . = ALIGN(4);         /* align */
        _eisr_vector = .;     /* define end symbol */
    } > FLASH
    ...

After that we want to store all the program data. Which is called the `.text` section.
We also store some `glue` to it. It defines a code region where some `stubs` are stored to translate ARM and Thumb code.
(We could omit this, the linker would include it anyway. But so we decide a specific region for it)

    /* program data goes into FLASH */
    .text : {
        . = ALIGN(4);         /* align */
        _stext = .;           /* define start symbol */
        *(.text)              /* insert program code .text */
        *(.text*)             /* .text* sections */

        *(.glue_7)            /* glue arm to thumb code */
        *(.glue_7t)           /* glue thumb to arm code */
        *(.eh_frame)

        . = ALIGN(4);         /* align */
        _etext = .;           /* define end symbol */
    } > FLASH

Also we define a section, where all read only data is stored. As example all `const` variables.

    /* constant data goes into FLASH */
    .rodata : {
       *(.rodata)            /* .rodata sections (constants, strings, etc.) */
       *(.rodata*)           /* .rodata* sections (constants, strings, etc.) */
       . = ALIGN(4);         /* align */
        _erodata = .;
    } > FLASH

And after that we define specific ARM debug sections. I don't really know how that works, but its needed for gdb to `unwind` the stack.

    /* ARM stack unwinding section (GDB uses this) */
    .ARM.extab : {
         __extab_start__ = .;/* define start symbol */
         *(.ARM.extab* .gnu.linkonce.armextab.*)
         __extab_end__ = .;  /* define end symbol */
    } > FLASH

    .ARM : {
         __exidx_start__ = .;/* define start symbol */
         *(.ARM.exidx* .gnu.linkonce.armexidx.*)
         __exidx_end__ = .;  /* define end symbol */
    } > FLASH

Now it gets interesting. I burned a lot time to figure this out.
The llvm linker doesn't implement the same behavior as the GCC here.
I first had to define the current allocation Address manually with this command.

    . = ORIGIN(RAM);

Otherwise the .data section was not set up properly.

The .data section contains all initialization data of all global variables.
A global variable is stored in RAM but it needs to be initialized to its `start` value from somewhere.
We have to tell the linker to point all references to the variables to RAM but copy the initialization data in flash.

    .data : AT(__exidx_end__) {
        _sdata = .;            /* create a global symbol at data start */
        *(.data)              /* .data sections */
        *(.data*)             /* .data* sections */

        . = ALIGN(4);         /* align */
        _edata = .;           /* define a global symbol at data end */
     } > RAM

     _sidata = LOADADDR(.data); /* get the start adress of the .data section */

The `> RAM` copies all references to RAM and also reserve the RAM space for the variables.
Ant the `AT(__exidx_end__)` command tells the compiler to store the values in Flash after the `__exidx_end__` symbol.
With the `_sidata = LOADADDR(.data);` we create a hook-symbol so we know where the values are stored in flash.
In the startup code we now have to copy the initialization values *by hand*.

At last we define the .bss section.

    /* zero initialized data goes to RAM and has to be cleared at startup */
    .bss :
     {
       _sbss = .;            /* define a global symbol at bss start */
       __bss_start__ = .;    /* symbolname defined by newlib*/
       *(.bss)               /* .bss sections */
       *(.bss*)              /* .bss* sections */
       *(COMMON)             /* common sections */

       . = ALIGN(4);         /* align */
       _ebss = .;            /* define a global symbol at bss end */
       __bss_end__ = .;      /* symbolname defined by newlib*/
     } > RAM

In this section all (global) variables which are not initialized are stored here.
To be C-Standard compliant we have to delete all entries *by hand* in the startup code.

And the last command of `simple.ld` script

    .ARM.attributes 0 : { *(.ARM.attributes) }

that should minimize some arm specific section names. So that the obj dump is more readable.

# links

-   [http://salbut.net/public/gcc-pdf/ld.pdf](http://salbut.net/public/gcc-pdf/ld.pdf)
-   [https://sourceware.org/binutils/docs-2.29/ld/index.html](https://sourceware.org/binutils/docs-2.29/ld/index.html)

-   [http://infocenter.arm.com/help/topic/com.arm.doc.ihi0044f/IHI0044F_aaelf.pdf](http://infocenter.arm.com/help/topic/com.arm.doc.ihi0044f/IHI0044F_aaelf.pdf)
