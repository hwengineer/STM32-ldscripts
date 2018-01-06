/******************************************************************************
	Memory Layout Linker File

	Device : STM32F302RC
	- Flash       256kB
	- RAM          40kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 40K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 256K
}