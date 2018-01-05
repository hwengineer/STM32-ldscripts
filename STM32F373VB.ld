/******************************************************************************
	Memory Layout Linker File

	Device : STM32F373VB
	- Flash       128kB
	- RAM          24kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 24K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 128K
}