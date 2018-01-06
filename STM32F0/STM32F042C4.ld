/******************************************************************************
	Memory Layout Linker File

	Device : STM32F042C4
	- Flash       16kB
	- RAM          6kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 6K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 16K
}