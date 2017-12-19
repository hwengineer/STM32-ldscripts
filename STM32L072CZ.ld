/******************************************************************************
	Memory Layout Linker File

	Device : STM32L072CZ
	- Flash       192kB
	- RAM          20kB
	- Data EEPROM   6kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 40K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 192K
	EEPROM (xrw)  : ORIGIN = 0x08080000, LENGTH = 6K
}
