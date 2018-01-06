/******************************************************************************
	Memory Layout Linker File

	Device : STM32L073CZ
	- Flash       192kB
	- RAM          20kB
	- Data EEPROM   6144B
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 20K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 192K
	EEPROM (rw)   : ORIGIN = 0x08080000, LENGTH = 6144
}