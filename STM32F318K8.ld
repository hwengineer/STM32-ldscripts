/******************************************************************************
	Memory Layout Linker File

	Device : STM32F318K8
	- Flash       64kB
	- RAM          16kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 16K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 64K
}