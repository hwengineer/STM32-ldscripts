/******************************************************************************
	Memory Layout Linker File

	Device : STM32F058T8
	- Flash       64kB
	- RAM          8kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 8K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 64K
}