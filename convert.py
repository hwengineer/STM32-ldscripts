import csv
from string import Template

#=============================================================================#
# STM32L0

linker_template= Template('''/******************************************************************************
	Memory Layout Linker File

	Device : ${device}
	- Flash       ${flash}kB
	- RAM          ${ram}kB
	- Data EEPROM   ${eeprom}B
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = ${ram}K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = ${flash}K
	EEPROM (rw)   : ORIGIN = 0x08080000, LENGTH = ${eeprom}
}''')

with open('STM32L0/STM32L0.csv', 'r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=';', quotechar='"')
    csvfile.readline() # dummy read, ignore header
    for row in spamreader:
        device = row[0]
        flash  = row[1]
        eeprom = row[2]
        ram    = row[3]

        with open('STM32L0/'+device + '.ld', 'w') as csvfile:
            csvfile.write(linker_template.safe_substitute(device=device, flash=flash, ram=ram, eeprom=eeprom))

#=============================================================================#
# STM32F3

linker_template= Template('''/******************************************************************************
	Memory Layout Linker File

	Device : ${device}
	- Flash       ${flash}kB
	- RAM          ${ram}kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = ${ram}K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = ${flash}K
}''')

linker_templateCCRAM= Template('''/******************************************************************************
	Memory Layout Linker File

	Device : ${device}
	- Flash       ${flash}kB
	- RAM          ${ram}kB
	- CCRAM        ${ccram}kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = ${ram}K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = ${flash}K
	CCMRAM (xrw)  : ORIGIN = 0x10000000, LENGTH = ${ccram}K
}''')


with open('STM32F3/STM32F3.csv', 'r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    csvfile.readline() # dummy read, ignore header
    for row in spamreader:
        device = row[0]
        flash  = row[1]
        ram    = row[2]
        ccram  = row[3] if( row[3] != '' ) else 0

        if(ccram == 0):
            with open('STM32F3/'+device + '.ld', 'w') as csvfile:
                csvfile.write(linker_template.safe_substitute(device=device, flash=flash, ram=ram))
        else:
            with open('STM32F3/'+device + '.ld', 'w') as csvfile:
                csvfile.write(linker_templateCCRAM.safe_substitute(device=device, flash=flash, ram=ram,ccram=ccram))

#=============================================================================#
# STM32F0

linker_template= Template('''/******************************************************************************
	Memory Layout Linker File

	Device : ${device}
	- Flash       ${flash}kB
	- RAM          ${ram}kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = ${ram}K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = ${flash}K
}''')

with open('STM32F0/STM32F0.csv', 'r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=';', quotechar='"')
    csvfile.readline() # dummy read, ignore header
    for row in spamreader:
        device = row[0]
        flash  = row[1]
        ram    = row[2]

        with open('STM32F0/'+device + '.ld', 'w') as csvfile:
            csvfile.write(linker_template.safe_substitute(device=device, flash=flash, ram=ram))
