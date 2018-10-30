module plights #(
   parameter depth = 4 * 10
)
(
   input          clk,
   input          rst,
   output [7:0]   led
);

wire wb_clk;
wire wb_rst;

assign wb_clk = clk;
assign wb_rst = rst;

`include "bus.vh"

mapper mapper0 (
   .wb_clk    (wb_clk),
   .wb_rst    (wb_rst),
   .wb_adr_o  (wb_m2s_mapper0_adr),
   .wb_dat_o  (wb_m2s_mapper0_dat),
   .wb_sel_o  (wb_m2s_mapper0_sel),
   .wb_we_o   (wb_m2s_mapper0_we),
   .wb_cyc_o  (wb_m2s_mapper0_cyc),
   .wb_stb_o  (wb_m2s_mapper0_stb),
   .wb_cti_o  (wb_m2s_mapper0_cti),
   .wb_bte_o  (wb_m2s_mapper0_bte),
   .wb_dat_i  (wb_s2m_mapper0_dat),
   .wb_ack_i  (wb_s2m_mapper0_ack),
   .wb_err_i  (wb_s2m_mapper0_err),
   .wb_rty_i  (wb_s2m_mapper0_rty)
);

gpio gpio0 (
   .wb_clk    (wb_clk),
   .wb_rst    (wb_rst),
   .wb_adr_i  (wb_m2s_gpio0_adr[0]),
   .wb_dat_i  (wb_m2s_gpio0_dat),
   .wb_we_i   (wb_m2s_gpio0_we),
   .wb_cyc_i  (wb_m2s_gpio0_cyc),
   .wb_stb_i  (wb_m2s_gpio0_stb),
   .wb_cti_i  (wb_m2s_gpio0_cti),
   .wb_bte_i  (wb_m2s_gpio0_bte),
   .wb_dat_o  (wb_s2m_gpio0_dat),
   .wb_ack_o  (wb_s2m_gpio0_ack),
   .wb_err_o  (wb_s2m_gpio0_err),
   .wb_rty_o  (wb_s2m_gpio0_rty),
   .gpio_o    (led)
);

wb_ram #(
   .depth   (depth),
   .memfile ("mem.hex")
)
rom0 (
   .wb_clk_i   (wb_clk),
   .wb_rst_i   (wb_rst),
   .wb_adr_i   (wb_m2s_rom0_adr[$clog2(depth) - 1:0]),
   .wb_dat_i   (wb_m2s_rom0_dat),
   .wb_sel_i   (wb_m2s_rom0_sel),
   .wb_we_i    (wb_m2s_rom0_we),
   .wb_cyc_i   (wb_m2s_rom0_cyc),
   .wb_stb_i   (wb_m2s_rom0_stb),
   .wb_cti_i   (wb_m2s_rom0_cti),
   .wb_bte_i   (wb_m2s_rom0_bte),
   .wb_dat_o   (wb_s2m_rom0_dat),
   .wb_ack_o   (wb_s2m_rom0_ack),
   .wb_err_o   (wb_s2m_rom0_err)
);

assign wb_s2m_rom0_rty = rst;

endmodule
