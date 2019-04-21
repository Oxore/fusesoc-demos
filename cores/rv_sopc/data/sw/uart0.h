#define UART_BASE       0x09002000

// Register addresses
#define UART_REG_RB     ((uint8_t *)UART_BASE + 0x0)    // receiver buffer
#define UART_REG_TR     ((uint8_t *)UART_BASE + 0x0)    // transmitter
#define UART_REG_IE     ((uint8_t *)UART_BASE + 0x1)    // Interrupt enable
#define UART_REG_II     ((uint8_t *)UART_BASE + 0x2)    // Interrupt identification
#define UART_REG_FC     ((uint8_t *)UART_BASE + 0x2)    // FIFO control
#define UART_REG_LC     ((uint8_t *)UART_BASE + 0x3)    // Line Control
#define UART_REG_MC     ((uint8_t *)UART_BASE + 0x4)    // Modem control
#define UART_REG_LS     ((uint8_t *)UART_BASE + 0x5)    // Line status
#define UART_REG_MS     ((uint8_t *)UART_BASE + 0x6)    // Modem status
#define UART_REG_SR     ((uint8_t *)UART_BASE + 0x7)    // Scratch register
#define UART_REG_DL1    ((uint8_t *)UART_BASE + 0x0)    // Divisor latch bytes (1-2)
#define UART_REG_DL2    ((uint8_t *)UART_BASE + 0x1)

// Interrupt Enable register bits
#define UART_IE_RDA     (1 << 0)    // Received Data available interrupt
#define UART_IE_THRE    (1 << 1)    // Transmitter Holding Register empty interrupt
#define UART_IE_RLS     (1 << 2)    // Receiver Line Status Interrupt
#define UART_IE_MS      (1 << 3)    // Modem Status Interrupt

// Interrupt Identification register bits
#define UART_II_IP      (1 << 0)    // Interrupt pending when 0
#define UART_II_II      (7 << 1)    // Interrupt identification (1110)

// Interrupt identification values for bits 3:1
#define UART_II_RLS     (3 << 1)    // Receiver Line Status (011x)
#define UART_II_RDA     (2 << 1)    // Receiver Data available (010x)
#define UART_II_TI      (6 << 1)    // Timeout Indication (110x)
#define UART_II_THRE    (1 << 1)    // Transmitter Holding Register empty (001x)
#define UART_II_MS      0           // Modem Status (000x)

// FIFO Control Register bits
#define UART_FC_TL      (3 << 0)    // Trigger level

// FIFO trigger level values
#define UART_FC_1       (0 << 0)
#define UART_FC_4       (1 << 0)
#define UART_FC_8       (2 << 0)
#define UART_FC_14      (3 << 0)

// Line Control register bits
#define UART_LC_BITS    (3 << 0)    // bits in character
#define UART_LC_SB      (1 << 2)    // stop bits
#define UART_LC_PE      (1 << 3)    // parity enable
#define UART_LC_EP      (1 << 4)    // even parity
#define UART_LC_SP      (1 << 5)    // stick parity
#define UART_LC_BC      (1 << 6)    // Break control
#define UART_LC_DL      (1 << 7)    // Divisor Latch access bit

// Modem Control register bits
#define UART_MC_DTR     (1 << 0)
#define UART_MC_RTS     (1 << 1)
#define UART_MC_OUT1    (1 << 2)
#define UART_MC_OUT2    (1 << 3)
#define UART_MC_LB      (1 << 4)    // Loopback mode

// Line Status Register bits
#define UART_LS_DR      (1 << 0)    // Data ready
#define UART_LS_OE      (1 << 1)    // Overrun Error
#define UART_LS_PE      (1 << 2)    // Parity Error
#define UART_LS_FE      (1 << 3)    // Framing Error
#define UART_LS_BI      (1 << 4)    // Break interrupt
#define UART_LS_TFE     (1 << 5)    // Transmit FIFO is empty
#define UART_LS_TE      (1 << 6)    // Transmitter Empty indicator
#define UART_LS_EI      (1 << 7)    // Error indicator

// Modem Status Register bits
#define UART_MS_DCTS    (1 << 0)    // Delta signals
#define UART_MS_DDSR    (1 << 1)
#define UART_MS_TERI    (1 << 2)
#define UART_MS_DDCD    (1 << 3)
#define UART_MS_CCTS    (1 << 4)    // Complement signals
#define UART_MS_CDSR    (1 << 5)
#define UART_MS_CRI     (1 << 6)
#define UART_MS_CDCD    (1 << 7)
