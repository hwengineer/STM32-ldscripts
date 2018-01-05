/******************************************************************************
	Memory Layout Linker File

	Device : STM32F303VB
	- Flash       128kB
	- RAM          32kB
	- CCRAM        8kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 32K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 128K
	CCMRAM (xrw)  : ORIGIN = 0x10000000, LENGTH = 8K
}