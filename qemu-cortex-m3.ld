/******************************************************************************
	Memory Layout Linker File

	Device : Cortex-M3 for Qemu
	- Flash   64kB
	- RAM     16kB

******************************************************************************/

MEMORY{
	/*RAM    (xrw)  : ORIGIN = 0x00020000, LENGTH = 16K*/
	/*FLASH  (rx)   : ORIGIN = 0x00000000, LENGTH = 64K*/
	/*RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 64K*/
	/*FLASH  (rx)   : ORIGIN = 0x00000000, LENGTH = 256K*/
  RAM    (xrw)  : ORIGIN = 0x00010000, LENGTH = 16K
	FLASH  (rx)   : ORIGIN = 0x00000000, LENGTH = 16K
}
