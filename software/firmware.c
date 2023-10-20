//volatile char * OUTPUT_REG = (volatile char *)0x10000000;
#define OUTPUT_REG (*((volatile char *)0x10000000))
//volatile char * SERIAL_REG = (volatile char *)0x10000001;
#define SERIAL_REG (*((volatile char *)0x10000001))

static char SERIAL_OUT = 1;

void putc(char c)
{
	OUTPUT_REG = c;
	// Implementation detail of current UART
	// when reading the 10th bit of the register
	// gives the status of the OUTPUT going buffer.
//	while(!((SERIAL_REG) & 1<<9)) {
		(SERIAL_REG) = c;
//	}
}

void puts(const char *s)
{
	while (*s) putc(*s++);
}

void *memcpy(void *dest, const void *src, int n)
{
	while (n) {
		n--;
		((char*)dest)[n] = ((char*)src)[n];
	}
	return dest;
}

void main()
{
	char message[] = "$Uryyb+Jbeyq!+Vs+lbh+pna+ernq+guvf+zrffntr+gura$gur+CvpbEI32+PCH"
			"+frrzf+gb+or+jbexvat+whfg+svar.$$++++++++++++++++GRFG+CNFFRQ!$$";
	putc(0xFF);
	putc(0x00);
	putc(0xAA);
	putc(0x55);
	putc(0x00);
	for (int i = 0; message[i]; i++)
		switch (message[i])
		{
		case 'a' ... 'm':
		case 'A' ... 'M':
			message[i] += 13;
			break;
		case 'n' ... 'z':
		case 'N' ... 'Z':
			message[i] -= 13;
			break;
		case '$':
			message[i] = '\n';
			break;
		case '+':
			message[i] = ' ';
			break;
		}
	puts(message);
}
