/*
 *
 * All registers are 8-bit long
 *
 *            |31    24       16        8        0|
 *            |-------- -------- -------- --------|
 * 0x91001000 |//////// CTRL_OUT  CTRL_IN    CTRL |
 * 0x91001004 |//////// //////// ////////  STATUS |
 * 0x91001008 |    CNT   CNT_MAX  CNT_MIN CNT_INIT|
 * 0x9100100C |//////// ////////  CNT_M2   CNT_M1 |
 *
 * */
#define TIMER0_BASE         0x91001000

#define TIMER0_CTRL         (uint8_t *)(TIMER0_BASE + 0x0)
#define TIMER0_CTRL_IN      (uint8_t *)(TIMER0_BASE + 0x1)
#define TIMER0_CTRL_OUT     (uint8_t *)(TIMER0_BASE + 0x2)
#define TIMER0_STATUS       (uint8_t *)(TIMER0_BASE + 0x4)
#define TIMER0_CNT_INIT     (uint8_t *)(TIMER0_BASE + 0x8)
#define TIMER0_CNT_MIN      (uint8_t *)(TIMER0_BASE + 0x9)
#define TIMER0_CNT_MAX      (uint8_t *)(TIMER0_BASE + 0xA)
#define TIMER0_CNT          (uint8_t *)(TIMER0_BASE + 0xB)
#define TIMER0_CNT_M0       (uint8_t *)(TIMER0_BASE + 0xC)
#define TIMER0_CNT_M1       (uint8_t *)(TIMER0_BASE + 0xD)

#define TCTRL_START         (1 << 0)
#define TCTRL_CNT_MODE      (1 << 1)
#define TCTRL_CLK_SEL       (1 << 3)
#define TCTRL_OVF_INT       (1 << 4)
#define TCTRL_M0_INT        (1 << 5)
#define TCTRL_M1_INT        (1 << 6)
#define TCTRL_FREE          (1 << 7)

#define TCTRL_IN_EDGE       (1 << 0)
#define TCTRL_IN_PS1        (0 << 4)
#define TCTRL_IN_PS2        (1 << 4)
#define TCTRL_IN_PS4        (2 << 4)
#define TCTRL_IN_PS8        (3 << 4)
#define TCTRL_IN_PS16       (4 << 4)
#define TCTRL_IN_PS32       (5 << 4)
#define TCTRL_IN_PS64       (6 << 4)
#define TCTRL_IN_PS128      (7 << 4)

#define TCTRL_OUT_PWM       (1 << 0)
#define TCTRL_OUT_INV       (1 << 1)
#define TCTRL_OUT_OVF_TRG   (1 << 4)
#define TCTRL_OUT_M0_TRG    (1 << 5)
#define TCTRL_OUT_M1_TRG    (1 << 6)

#define TSTATUS_OVF         (1 << 0)
#define TSTATUS_M0F         (1 << 1)
#define TSTATUS_M1F         (1 << 2)
