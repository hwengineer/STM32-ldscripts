/******************************************************************************
	Memory Layout Linker File

	Device : STM32F302RE
	- Flash       512kB
	- RAM          64kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 64K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 512K
}