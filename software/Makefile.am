bin_PROGRAMS = firmware
firmware_SOURCES = \
	src/firmware.c

# Default flags for compilation of the code
firmware_CFLAGS = $(AM_CFLAGS) -Wall -Wextra --std=gnu99

# If cross compiling, set flags for specific CPU
if HOST_RISCV

# Full specific flags when cross compiling
firmware_CFLAGS += -march=rv32i -mabi=ilp32 -mstrict-align -ffreestanding -nostartfiles -static
firmware_CCASFLAGS = $(firmware_CFLAGS)

# Has to be done with -Wl because it is using the linker through GCC, not
# calling linker directly
# Only special mapping when cross compiling
firmware_LDFLAGS = -Wl,-Bstatic,-T,$(top_srcdir)/src/firmware.lds,-Map=firmware.map,--strip-debug,-lgcc

# Add specific assemblies
firmware_SOURCES += \
	src/init.S \
	src/custom_ops.S

# Extended binaries only when cross compiling
firmware.bin: firmware
	$(host_alias)-objcopy -O binary firmware firmware.bin
firmware.hex: firmware.bin
	python3 $(top_srcdir)/src/makehex.py firmware.bin 4096 > firmware.hex
firmware.coe: firmware.hex
	echo "memory_initialization_radix=16;" > firmware.coe
	echo "memory_initialization_vector=" >> firmware.coe
	cat firmware.hex >> firmware.coe
firmware.asm: firmware
	$(host_alias)-objdump -drwC -S firmware > firmware.asm
# This rule allows the creation of the assembly dump of any object file.
# Specially useful when dealing with C.
.o.asm:
	$(host_alias)-objdump -drwC -S $< > $@

# This creates the assembly objdump of all object files!
assemblies: $(firmware_OBJECTS:.o=.asm)

# Add extra targets to allow default compilation create them
all-local: firmware.hex firmware.asm

# Add also cleanup of extra targets
clean-local:
	rm -f $(firmware_OBJECTS:.o=.asm)
	rm -f firmware.bin firmware.hex firmware.coe firmware.asm firmware.map

else
# Sources for the native compilation
# This is part is currently pending

endif

dist_doc_DATA = README.md
