TOOLCHAIN_PREFIX = riscv32-unknown-elf-
CC_FLAGS = -Wall -Wextra -march=rv32i -mabi=ilp32 -mstrict-align -ffreestanding -nostdlib --std=gnu99

default: firmware.hex

FIRMWARE_PATH:=../firmware
SOURCE_PATH:=../c_autotools/src

firmware.elf: $(SOURCE_PATH)/firmware.c $(SOURCE_PATH)/firmware.lds $(FIRMWARE_PATH)/init.S $(FIRMWARE_PATH)/custom_ops.S
	$(TOOLCHAIN_PREFIX)gcc $(CC_FLAGS) -o \
		firmware.elf \
		$(FIRMWARE_PATH)/init.S \
		$(FIRMWARE_PATH)/custom_ops.S \
		$(SOURCE_PATH)/firmware.c \
		-Wl,-Bstatic,-T,$(SOURCE_PATH)/firmware.lds,-Map,firmware.map,--strip-debug -lgcc

firmware.bin: firmware.elf
	$(TOOLCHAIN_PREFIX)objcopy -O binary firmware.elf firmware.bin

firmware.hex: firmware.bin
	python3 makehex.py firmware.bin 4096 > firmware.hex

firmware.coe: firmware.hex
	echo "memory_initialization_radix=16;" > firmware.coe
	echo "memory_initialization_vector=" >> firmware.coe
	cat firmware.hex >> firmware.coe

firmware.asm: firmware.hex
	$(TOOLCHAIN_PREFIX)objdump -drwC -S firmware.elf > firmware.asm

all: firmware.asm firmware.coe

clean:
	rm -rf firmware.bin firmware.elf firmware.hex firmware.map firmware.s firmware.coe firmware.asm
