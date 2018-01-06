/******************************************************************************
	Memory Layout Linker File

	Device : STM32F358CC
	- Flash       256kB
	- RAM          40kB
	- CCRAM        8kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 40K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 256K
	CCMRAM (xrw)  : ORIGIN = 0x10000000, LENGTH = 8K
}