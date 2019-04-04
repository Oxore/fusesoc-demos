/*
 *
 * All registers are 8-bit long
 *
 *            |31    24       16        8        0|
 *            |-------- -------- -------- --------|
 * 0x91001000 |//////// CTRL_OUT  CTRL_IN    CTRL |
 * 0x91001004 |//////// //////// ////////  STATUS |
 * 0x91001008 |    CNT   CNT_MAX  CNT_MIN CNT_INIT|
 * 0x91001008 |//////// ////////  CNT_M2   CNT_M1 |
 *
 * */
#define TIMER0_BASE         0x91001000
#define TIMER0_CTRL         (TIMER0_BASE + 0x0)
#define TIMER0_CTRL_IN      (TIMER0_BASE + 0x1)
#define TIMER0_CTRL_OUT     (TIMER0_BASE + 0x2)
#define TIMER0_STATUS       (TIMER0_BASE + 0x4)
#define TIMER0_CNT_INIT     (TIMER0_BASE + 0x8)
#define TIMER0_CNT_MIN      (TIMER0_BASE + 0x9)
#define TIMER0_CNT_MAX      (TIMER0_BASE + 0xA)
#define TIMER0_CNT          (TIMER0_BASE + 0xB)
#define TIMER0_CNT_M0       (TIMER0_BASE + 0xC)
#define TIMER0_CNT_M1       (TIMER0_BASE + 0xD)
