/******************************************************************************
	Memory Layout Linker File

	Device : STM32F301K6
	- Flash       32kB
	- RAM          16kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 16K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 32K
}