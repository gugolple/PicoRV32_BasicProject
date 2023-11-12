bin_PROGRAMS = firmware
firmware_SOURCES = \
	src/firmware.c

# Default flags for compilation of the code
firmware_CFLAGS = $(AM_CFLAGS) -Wall -Wextra --std=gnu99

# If cross compiling, set flags for specific CPU
if HOST_RISCV
# Add specific assemblies
firmware_SOURCES += \
	src/firmware.S \
	src/custom_ops.S

# Full specific fflags when cross compiling
firmware_CFLAGS += -march=rv32i -mabi=ilp32 -mstrict-align -ffreestanding -nostartfiles -static

# Only special mapping when cross compiling
firmware_LDFLAGS = -Wl,-Bstatic,-T,$(top_srcdir)/src/firmware.lds,-Map=firmware.map,--strip-debug,-lgcc

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

# Add extra targets to allow default compilation create them
all-local: firmware.hex firmware.asm

# Add also cleanup of extra targets
clean-local:
	pwd
	rm -f firmware.bin firmware.hex firmware.coe firmware.asm firmware.map

else
# Sources for the native compilation
# This is part is currently pending

endif

# Has to be done with -Wl because it is using the linker through GCC, not
# calling linker directly
dist_doc_DATA = README.md
