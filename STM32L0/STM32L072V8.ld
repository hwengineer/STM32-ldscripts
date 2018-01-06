/******************************************************************************
	Memory Layout Linker File

	Device : STM32L072V8
	- Flash       64kB
	- RAM          20kB
	- Data EEPROM   3072B
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 20K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 64K
	EEPROM (rw)   : ORIGIN = 0x08080000, LENGTH = 3072
}