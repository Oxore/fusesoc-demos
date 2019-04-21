#include <stdint.h>

#include "timer0.h"

#define GPIO0_BASE  0x91000000
#define GPIO0_DATA  ((uint8_t *)(GPIO0_BASE + 0))
#define GPIO0_DIR   ((uint8_t *)(GPIO0_BASE + 1))

volatile unsigned char dat = 0x00;

static void gpio_init()
{
    *GPIO0_DIR = 0xff;
    *GPIO0_DATA = dat;
}

static void timer_init()
{
    *TIMER0_CTRL = TCTRL_START | TCTRL_FREE | TCTRL_OVF_INT;
}

int main(void)
{
    gpio_init();
    timer_init();

    while (1) {
        *GPIO0_DATA = dat;
    }

    return 0;
}
