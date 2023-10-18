#Minimal running picorv32 for CMOD S7
This is a personal proyect just to get down to basics and understand how the 
picorv32 is handled.

##Goals!
I want to have a simple program to blink the leds in the board using the soft core.
I want the soft core to be programmed via C/C++ and the FOSS toolchain.
Learn as much as possible!
    Including memory mapping layouts in the GCC compiler.
**KISS** Keep it stupid simple!
    I want to use this proyect as basis for all my other fpga + picorv32 implementation.

###New goals!!!!
Have the picorv32 communicate via SERIAL/UART to the computer as to allow basic communication/debug.
    I understand that this DOES NOT imply proper debugging, that would be through GDB.
After serial I will focus on GDB debugging included into the system.

##Completed goals!
I want to have a simple program to blink the leds in the board using the soft core.
    Done, it was very direct and insightful into how actual computers work. TAG: "WorkingLeds".

I want the soft core to be programmed via C/C++ and the FOSS toolchain.
    Managed to cross compile from my ARM system, very happy about that one.
    Needed to compile from source to have all libraries be in RV32I configuration.

#Aknowledgments
Absolutely to the [picorv32](https://github.com/YosysHQ/picorv32) proyect, from which all the code is based on.
All the specifics regarding the board [cmod S7](https://digilent.com/reference/programmable-logic/cmod-s7/start).

#Links
Picorv32: https://github.com/YosysHQ/picorv32
Cmod S7: https://digilent.com/reference/programmable-logic/cmod-s7/start
