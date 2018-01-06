/******************************************************************************
	Memory Layout Linker File

	Device : STM32L011D3
	- Flash       8kB
	- RAM          2kB
	- Data EEPROM   512B
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 2K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 8K
	EEPROM (rw)   : ORIGIN = 0x08080000, LENGTH = 512
}