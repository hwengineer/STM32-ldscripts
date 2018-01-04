/******************************************************************************
	Simple Linker File

	.text     program code;
	.rodata   read-only data;
	.bss      read-write zero initialized data.
	.data     read-write initialized data;

  for simplicity : no heap defined.
******************************************************************************/
OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")

/* define entry point */
ENTRY(Reset_Handler)

/* calculate the Last RAM address*/
 _estack = ORIGIN(RAM) + LENGTH(RAM) - 1;

/* --- Sections --- */
SECTIONS
{
	/*--------------------------------------------------------------------------*/
  /* interrupt vector goes at the beginning of FLASH */
	.isr_vector : {
			. = ALIGN(4);					/* align */
			_sisr_vector = .;     /* define start symbol */
			KEEP(*(.isr_vector))  /* Interrupt vectors */
			. = ALIGN(4);					/* align */
			_eisr_vector = .;			/* define end symbol */
  } > FLASH
	/*--------------------------------------------------------------------------*/
  /* program data goes into FLASH */
	.text : {
			. = ALIGN(4);					/* align */
			_stext = .;           /* define start symbol */
			*(.text)						  /* insert program code .text */
			*(.text*)             /* .text* sections */

			*(.glue_7)            /* glue arm to thumb code */
			*(.glue_7t)           /* glue thumb to arm code */
			*(.eh_frame)

			. = ALIGN(4);				  /* align */
			_etext = .;           /* define end symbol */
	} > FLASH

  /*--------------------------------------------------------------------------*/
  /* constant data goes into FLASH */
  .rodata : {
     *(.rodata)            /* .rodata sections (constants, strings, etc.) */
     *(.rodata*)           /* .rodata* sections (constants, strings, etc.) */
     . = ALIGN(4);         /* align */
      _erodata = .;
  } > FLASH

  /*--------------------------------------------------------------------------*/
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

  /*--------------------------------------------------------------------------*/
  /* Define RAM Section : only sections who goes to ram after this point */
 . = ORIGIN(RAM); /* for ld.lld it seems to be necessary to define the ram section this way.*/
                  /* otherwise, the .data sectin will not defined properly.*/
                  /* to be precise : the variable are in RAM but the initialization data would not be defined in flash */

 /*--------------------------------------------------------------------------*/
 /* initialized data goes to ram, but must be loaded from flash */
 /*has to be behind bss. otherwise it strangly not working properly*/

 .data : AT(__exidx_end__) {
     _sdata = .;            /* create a global symbol at data start */
     *(.data)              /* .data sections */
     *(.data*)             /* .data* sections */

     . = ALIGN(4);         /* align */
     _edata = .;           /* define a global symbol at data end */
  } > RAM

  _sidata = LOADADDR(.data); /* get the start address of the .data section */

  /*--------------------------------------------------------------------------*/
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

  /*--------------------------------------------------------------------------*/
  .ARM.attributes 0 : { *(.ARM.attributes) }

}
