/******************************************************************************
	Memory Layout Linker File

	Device : STM32F303ZD
	- Flash       384kB
	- RAM          64kB
	- CCRAM        16kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 64K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 384K
	CCMRAM (xrw)  : ORIGIN = 0x10000000, LENGTH = 16K
}