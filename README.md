# Minimal running picorv32 for CMOD S7
This is a personal proyect just to get down to basics and understand how the 
picorv32 is handled.

## Goals!
I want to have a simple program to blink the leds in the board using the soft core. I want the soft core to be programmed via C/C++ and the FOSS toolchain.

Learn as much as possible!
- Including memory mapping layouts in the GCC compiler.
- **KISS** Keep it stupid simple!
- I want to use this proyect as basis for all my other fpga + picorv32 implementation.

### New goals!!!!
Have the picorv32 communicate via SERIAL/UART to the computer as to allow basic communication/debug.
- I understand that this DOES NOT imply proper debugging, that would be through GDB.
- Serial decided for the time being to be provided by: [jakubcabal/uart-for-fpga](https://github.com/jakubcabal/uart-for-fpga.git)

Have the picorv32 communicate via SERIAL/UART and handle the reception via IRQ.
- This is a basis to handle all other kind of IO to not require POLLING.

Migrate to autotools for the software compilation.
- After serial I will focus on GDB debugging included into the system.

## Completed goals!
I want to have a simple program to blink the leds in the board using the soft core.
- Done, it was very direct and insightful into how actual computers work.
  - TAG: "WorkingLeds".

I want the soft core to be programmed via C/C++ and the FOSS toolchain.
- Managed to cross compile from my ARM system, very happy about that one.
- Needed to compile from source to have all libraries be in RV32I configuration.

Have the picorv32 communicate via SERIAL/UART to the computer as to allow basic communication/debug.
- Currently is only sending data from PicoRV32 to the outside system.
- This is now working bidirectional with the example code of the PicoRV32 project. 
  - TAG: "WorkingSerial".

Have the picorv32 communicate via SERIAL/UART and handle the reception via IRQ.
- The code is a bit bulkier, there is a buffer in the UART of 8 words deep,
    configurable by the user. In another update I will try to remove the buffer.
    - TAG: "WorkinSerialIRQ".
- Redone in a simplified logic, this follows more closely to the intentions of 
  this GIT/proyect.
    - TAG: "WorkingSerialIRQSimplified"

Migration to autotools for software compilation done!
- This has a new README.md in software explaining high level functionality.
  - The core has been solved, allowing anyone take the files and just change
    their source code specific needs. It has all the configuration and files
    needed for this project linked.
    - TAG: "WorkingAutotools"

Produce a better system for understanding the status of the serial by the CPU.
- This has been accomplished, it was already given by DIN_RDY if it was kept high. 
  - TAG: "WorkingSerialWait".

# Aknowledgments
Absolutely to the [picorv32](https://github.com/YosysHQ/picorv32) proyect, from which the main code is based on.

All the specifics regarding the board [cmod S7](https://digilent.com/reference/programmable-logic/cmod-s7/start).

# Links
- Picorv32: https://github.com/YosysHQ/picorv32
- Cmod S7: https://digilent.com/reference/programmable-logic/cmod-s7/start
- RISC-V GNU Compiler Toolchain: https://github.com/riscv-collab/riscv-gnu-- toolchain
- Verilog formatter: https://github.com/chipsalliance/verible
- Serial for FPGA: https://github.com/jakubcabal/uart-for-fpga.git
