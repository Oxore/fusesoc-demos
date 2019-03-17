module rv_sopc #(
   parameter ROM_DEPTH = 'h4000
)
(
   input          clk,
   input          rst,
   output [7:0]   led
);

wire wb_clk;
wire wb_rst;
reg [31:0] irq;

assign wb_clk = clk;
assign wb_rst = rst;
assign wb_m2s_picorv320_cti[2:0] = 3'b000;

always @* begin
   irq = 0;
   irq[4] = &picorv320.picorv32_core.count_cycle[12:0];
   irq[5] = &picorv320.picorv32_core.count_cycle[15:0];
end


`include "bus.vh"

picorv32_wb #(
   .ENABLE_REGS_DUALPORT(1),
   .ENABLE_MUL(1),
   .ENABLE_DIV(1),
   .ENABLE_IRQ(1),
   .ENABLE_TRACE(1)
)
picorv320 (
   .wb_clk_i   (wb_clk),
   .wb_rst_i   (wb_rst),
   .irq        (irq),

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
