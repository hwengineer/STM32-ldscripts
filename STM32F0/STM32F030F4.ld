/******************************************************************************
	Memory Layout Linker File

	Device : STM32F030F4
	- Flash       16kB
	- RAM          4kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 4K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 16K
}