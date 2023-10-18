TOOLCHAIN_PREFIX = /opt/riscv/bin/riscv32-unknown-elf-
CC_FLAGS = -march=rv32i -mabi=ilp32 -mstrict-align -Os -ffreestanding -nostdlib --std=gnu99

firmware.hex: firmware.S firmware.c firmware.lds
	$(TOOLCHAIN_PREFIX)gcc $(CC_FLAGS) -o firmware.elf firmware.S firmware.c \
		 -Wl,-Bstatic,-T,firmware.lds,-Map,firmware.map,--strip-debug -lgcc
	$(TOOLCHAIN_PREFIX)objcopy -O binary firmware.elf firmware.bin
	python3 makehex.py firmware.bin 4096 > firmware.hex

clean:
	rm -rf firmware.bin firmware.elf firmware.hex firmware.map
