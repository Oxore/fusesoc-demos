#include <stdint.h>

//#define LOCATE_RST  __attribute__((__section__(".reset_handler")))

#define GPIO0_BASE  0x91000000
#define GPIO0_DIR   (GPIO0_BASE + 0)
#define GPIO0_DATA  (GPIO0_BASE + 1)

volatile unsigned char dat = 0x00;

static void gpio_init() {
  /* Set the GPIO to all out */
  char dir = 0xff;
  *(uint8_t *)GPIO0_DIR = dir;
  /* Initialise with the first data value */
  *(uint8_t *)GPIO0_DATA = dat;
}

static void gpio_increment() {
  *(uint8_t *)GPIO0_DATA = (++dat)%256;
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

//void LOCATE_RST reset_handler(void)
//{
//    (void)main();
//}
