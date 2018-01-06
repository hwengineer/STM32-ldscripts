/******************************************************************************
	Memory Layout Linker File

	Device : STM32F303K8
	- Flash       64kB
	- RAM          12kB
	- CCRAM        4kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 12K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 64K
	CCMRAM (xrw)  : ORIGIN = 0x10000000, LENGTH = 4K
}