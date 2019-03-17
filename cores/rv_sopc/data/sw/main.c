#include <stdint.h>

#define LOCATE_RST  __attribute__((__section__(".reset_handler")))

char* gpio_base = (char*) 0x91000000;

unsigned char dat = 0x00;

static void gpio_init() {
  /* Set the GPIO to all out */
  char dir = 0xff;
  *(gpio_base+1) = dir;
  /* Initialise with the first data value */
  *(gpio_base+0) = dat;
}

static void gpio_increment() {
  *(gpio_base+0) = (++dat)%256;
}

int main(void)
{
  uint32_t ticks = 0;
  uint32_t timerstate;

  gpio_init();

  while (1) {
    ticks++;
    if (ticks == 100) {
      gpio_increment();
      ticks = 0;
    }
  }

  return 0;
}

void LOCATE_RST reset_handler(void)
{
    (void)main();
}
