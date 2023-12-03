bin_PROGRAMS = firmware
firmware_SOURCES = \
	src/firmware.c


# Default flags for compilation of the code
DEFAULT_FLAGS = -Wall -Wextra --std=gnu99
firmware_CFLAGS = $(AM_CFLAGS) $(DEFAULT_FLAGS)
firmware_CCASFLAGS = $(AM_CCASFLAGS) $(DEFAULT_FLAGS)

# If cross compiling, set flags for specific CPU
if HOST_RISCV

# Full specific flags when cross compiling
FIRMWARE_FLAGS = -march=rv32i -mabi=ilp32 -mstrict-align -ffreestanding -nostartfiles -static
firmware_CFLAGS += $(FIRMWARE_FLAGS)
firmware_CCASFLAGS += $(FIRMWARE_FLAGS)

# Has to be done with -Wl because it is using the linker through GCC, not
# calling linker directly
# Only special mapping when cross compiling
firmware_LDFLAGS = -Wl,-Bstatic,-T,$(top_srcdir)/src/firmware.lds,-Map=firmware.map,--strip-debug,-lgcc

# Add specific assemblies
firmware_SOURCES += \
	../firmware/init.S \
	../firmware/custom_ops.S

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

# Add extra targets to allow default compilation create them
all-local: firmware.hex

# Added a target for all debug related necessities
debug: $(firmware_OBJECTS:.o=.asm) firmware.asm

# Add also cleanup of extra targets
clean-local:
	rm -f $(firmware_OBJECTS:.o=.asm)
	rm -f firmware.bin firmware.hex firmware.coe firmware.asm firmware.map

else
# Sources for the native compilation
# This is part is currently pending

endif

dist_doc_DATA = README.md
