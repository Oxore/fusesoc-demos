module rv_sopc #(
   parameter ROM_DEPTH = 'h1000
)
(
   input          clk,
   input          rst,
   input          irq,
   output [7:0]   led
);

wire wb_clk;
wire wb_rst;
wire tim_irq;

assign wb_clk = clk;
assign wb_rst = rst;
assign wb_m2s_picorv320_cti[2:0] = 3'b000;


`include "bus.vh"

picorv32_wb #(
   .ENABLE_REGS_DUALPORT(1),
   .ENABLE_MUL(1),
   .ENABLE_DIV(1),
   .ENABLE_IRQ(1),
   .ENABLE_TRACE(1),
   .ENABLE_REGS_16_31(1),
   .ENABLE_IRQ_QREGS(0)
)
picorv320 (
   .wb_clk_i   (wb_clk),
   .wb_rst_i   (wb_rst),
   .irq        ({26'h0, tim_irq, irq, 4'b0000}),

   .wbm_adr_o  (wb_m2s_picorv320_adr),
   .wbm_dat_o  (wb_m2s_picorv320_dat),
   .wbm_sel_o  (wb_m2s_picorv320_sel),
   .wbm_we_o   (wb_m2s_picorv320_we),
   .wbm_cyc_o  (wb_m2s_picorv320_cyc),
   .wbm_stb_o  (wb_m2s_picorv320_stb),
   .wbm_dat_i  (wb_s2m_picorv320_dat),
   .wbm_ack_i  (wb_s2m_picorv320_ack)
);

gpio gpio0 (
   .wb_clk     (wb_clk),
   .wb_rst     (wb_rst),
   .wb_adr_i   (wb_m2s_gpio0_adr[0]),
   .wb_dat_i   (wb_m2s_gpio0_dat),
   .wb_we_i    (wb_m2s_gpio0_we),
   .wb_cyc_i   (wb_m2s_gpio0_cyc),
   .wb_stb_i   (wb_m2s_gpio0_stb),
   .wb_cti_i   (wb_m2s_gpio0_cti),
   .wb_bte_i   (wb_m2s_gpio0_bte),
   .wb_dat_o   (wb_s2m_gpio0_dat),
   .wb_ack_o   (wb_s2m_gpio0_ack),
   .wb_err_o   (wb_s2m_gpio0_err),
   .wb_rty_o   (wb_s2m_gpio0_rty),
   .gpio_o     (led)
);

d_ip_timer_wb timer0 (
   .wb_clk        (wb_clk),
   .wb_rst        (wb_rst),
   .wb_adr_i      (wb_m2s_timer0_adr[5:0]),
   .wb_dat_i      (wb_m2s_timer0_dat),
   .wb_we_i       (wb_m2s_timer0_we),
   .wb_cyc_i      (wb_m2s_timer0_cyc),
   .wb_stb_i      (wb_m2s_timer0_stb),
   .wb_cti_i      (wb_m2s_timer0_cti),
   .wb_bte_i      (wb_m2s_timer0_bte),
   .wb_dat_o      (wb_s2m_timer0_dat),
   .wb_ack_o      (wb_s2m_timer0_ack),
   .wb_err_o      (wb_s2m_timer0_err),
   .wb_rty_o      (wb_s2m_timer0_rty),

   .timer_in      (clk),
   .overflow_int  (tim_irq)
);

wb_ram #(
   .depth      (ROM_DEPTH),
   .memfile    ("mem.hex")
)
ram0 (
   .wb_clk_i   (wb_clk),
   .wb_rst_i   (wb_rst),
   .wb_adr_i   (wb_m2s_ram0_adr[$clog2(ROM_DEPTH) - 1:0]),
   .wb_dat_i   (wb_m2s_ram0_dat),
   .wb_sel_i   (wb_m2s_ram0_sel),
   .wb_we_i    (wb_m2s_ram0_we),
   .wb_cyc_i   (wb_m2s_ram0_cyc),
   .wb_stb_i   (wb_m2s_ram0_stb),
   .wb_cti_i   (wb_m2s_ram0_cti),
   .wb_bte_i   (wb_m2s_ram0_bte),
   .wb_dat_o   (wb_s2m_ram0_dat),
   .wb_ack_o   (wb_s2m_ram0_ack),
   .wb_err_o   (wb_s2m_ram0_err)
);

assign wb_s2m_ram0_rty = rst;

endmodule
