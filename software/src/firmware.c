#include <stdint.h>
#include <stdbool.h>

//volatile char * OUTPUT_REG = (volatile char *)0x10000000
volatile uint32_t * const OUTPUT_REG = ((volatile uint32_t *)0x10000000);
//volatile char * SERIAL_REG = (volatile char *)0x10000004;
volatile uint32_t * const SERIAL_REG = ((volatile uint32_t *)0x10000004);
// Sub register division for SERIAL control
uint32_t const SERIAL_OUT_BSY = 0x200;
uint32_t const SERIAL_IN_MORE_DATA = 0x100;
uint32_t const SERIAL_IN_DATA = 0x0FF;

#define BUFFER_SIZE 100
static char serial_buffer[BUFFER_SIZE];
static uint32_t serial_buffer_idx;

void putc(char c)
{
	*OUTPUT_REG = c;
	// Implementation detail of current UART
	// when reading the 10th bit of the register
	// gives the BSY status of the OUTPUT going buffer.
	while(*SERIAL_REG & SERIAL_OUT_BSY);
	// When no longer busy, we write to SERIAL.
	*SERIAL_REG = c;
}

void puts(const char *s)
{
	while (*s) putc(*s++);
}

void putd(uint32_t val)
{
	char buffer[10];
	char *p = buffer;
	while (val || p == buffer) {
		*(p++) = val % 10;
		val = val / 10;
	}
	while (p != buffer) {
		putc('0' + *(--p));
	}
}

void puth(uint32_t val, uint32_t digits)
{
	for (int i = (4*digits)-4; i >= 0; i -= 4)
		putc("0123456789ABCDEF"[(val >> i) % 16]);
}

void *memcpy(void *dest, const void *src, int n)
{
	while (n) {
		n--;
		((char*)dest)[n] = ((char*)src)[n];
	}
	return dest;
}

void my_sleep_ms(unsigned int ms) {
  #define STEPS_PER_SEC 10000
  unsigned int i,s;
  for (s=0; s < ms; s++) {
    for (i=0; i < STEPS_PER_SEC; i++) {
       // skip CPU cycle or any other statement(s) for making loop
       // untouched by C compiler code optimizations
       asm("nop");
    }
  }
}

void main()
{
	char message[] = "$Uryyb+Jbeyq!+Vs+lbh+pna+ernq+guvf+zrffntr+gura$gur+CvpbEI32+PCH"
			"+frrzf+gb+or+jbexvat+whfg+svar.$$++++++++++++++++GRFG+CNFFRQ!$$";
	puts("\r\n");
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
	puts("\r\n");

	while(1) {
                // If we capture new line
                if (serial_buffer_idx >= BUFFER_SIZE ||
                        serial_buffer[serial_buffer_idx-1] == '\r') {
                    // We set the end of the string
                    serial_buffer[serial_buffer_idx] = '\0';
                    puts(serial_buffer);
                    putc('\n');
                    serial_buffer_idx = 0;
                }
	}
}

uint32_t *irq(uint32_t *regs, uint32_t irqs)
{
	static unsigned int ext_irq_5_count = 0;
	static unsigned int timer_irq_count = 0;

	if ((irqs & (1<<4)) != 0) {
                uint32_t serial_tmp;
                serial_tmp = *SERIAL_REG;
                serial_buffer[serial_buffer_idx++] = serial_tmp & SERIAL_IN_DATA;
	}

	if ((irqs & (1<<5)) != 0) {
		ext_irq_5_count++;
		puts("[EXT-IRQ-5]\r\n");
	}

	if ((irqs & 1) != 0) {
		timer_irq_count++;
		puts("[TIMER-IRQ]\r\n");
	}

	return regs;
}
