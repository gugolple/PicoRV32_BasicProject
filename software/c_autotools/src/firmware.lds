SECTIONS {
	.memory :{
		. = 0x000000;
		*(.init);
		. = 0x000010;
		*(.irq);
		*(.text);
		*(*);
		. = ALIGN(4);
		end = .;
	}
}

