# Software!
This folder contains everything related to the software compilation process.
**All** the sources are in the subfolder "src"

This project is built using **AUTOTOOLS**!.

The proyect is currently unable to work as a native application simulating the
embedded behaviour.
- This will change in the future.

Default setup of AUTOTOOLS commands are as follows:
```    
    mkdir build
    cd build
    ../configure --host=riscv32-unknown-elf 
```

The following are core files for the system to work:
- init.S: Contains all the low level assembly setting the processor
        configuration for the execution.
  - This will need two entry points defined
        in the "C" sources: "main" and "irq".
- custom_ops.S: Defines all specific instructions for PicoRV32.

- firmware.c: Contains all the "C" level code for the utilization of the
        system. 
  - This file contains the "main" function with a basic behaviour. 
  - This file contains the "irq" with an example of how to hanlde the 
  	specifics of an IRQ received by the CPU.

The following outputs are utilized for the image building process:
- firmware.bin: The bin file containing all the instructions starting at
        0x0000000000000000 without any other discrimination being done.
  - This file must be present at "synthesis" time for the "Vivado" utilities to 
  	load the file into the memories.

The following files are related to the building process:
- Makefile.am: This contains all the build instructions and definitions.
  - This also handles the logic of native/embedded builds.
  - Now it does automatically the objdump of all the sources for better
    debugging experience with "make debug". If only desired from a single
    intermediate C object file it is through "make path/to/target.**asm**"
    instead of the usual ".o" extension.
  - configure.ac: This defines the environment variables needed by Makefile.am.

The following outputs are for help to the user:
- firmware.asm: This file contains the assembly of the final executable. This
        allows to follow the actual operations of the CPU.

**This CPU does not support ANY kind of debugging!**. It does not offer an
additional interface from which to attach a GDB to itself.
