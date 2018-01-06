/******************************************************************************
	Memory Layout Linker File

	Device : STM32L051T6
	- Flash       32kB
	- RAM          8kB
	- Data EEPROM   2048B
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 8K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 32K
	EEPROM (rw)   : ORIGIN = 0x08080000, LENGTH = 2048
}