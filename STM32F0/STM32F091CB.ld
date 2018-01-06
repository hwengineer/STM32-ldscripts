/******************************************************************************
	Memory Layout Linker File

	Device : STM32F091CB
	- Flash       128kB
	- RAM          32kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 32K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 128K
}