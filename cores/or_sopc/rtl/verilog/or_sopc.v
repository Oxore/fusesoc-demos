module or_sopc #(
   parameter ROM_DEPTH = 4 * 1000
)
(
   input          clk,
   input          rst,
   output [7:0]   led,
   output [31:0]  dbg_adr_d,
   output [31:0]  dbg_dat_d_m2s,
   output [31:0]  dbg_dat_d_s2m,
   output [31:0]  dbg_adr_i,
   output [31:0]  dbg_dat_i_m2s
);

wire wb_clk;
wire wb_rst;

assign wb_clk = clk;
assign wb_rst = rst;

assign dbg_adr_d = mor1kx0.dwbm_adr_o;

`include "ibus.vh"
`include "dbus.vh"

mor1kx #(
   .OPTION_CPU0 ("CAPPUCCINO"),
   .IBUS_WB_TYPE ("CLASSIC"),

   .FEATURE_TIMER ("NONE"),
   .FEATURE_SYSCALL ("NONE"),
   .FEATURE_TRAP ("NONE"),
   .FEATURE_RANGE ("NONE"),
   .FEATURE_PIC ("NONE"),
   .FEATURE_OVERFLOW ("NONE"),
   .FEATURE_FASTCONTEXTS ("NONE")

)
mor1kx0 (
   .clk        (wb_clk),
   .rst        (wb_rst),

   .multicore_coreid_i   (32'h0),
   .multicore_numcores_i (32'h1),
   .snoop_adr_i          (32'h0),
   .snoop_en_i           (1'b0),
   .du_addr_i            (16'h0),
   .du_dat_i             (32'h0),
   .du_stb_i             (1'h0),
   .du_we_i              (1'h0),
   .du_stall_i           (1'h0),

   .iwbm_adr_o (wb_m2s_mor1kx0_i_adr),
   .iwbm_dat_o (wb_m2s_mor1kx0_i_dat),
   .iwbm_sel_o (wb_m2s_mor1kx0_i_sel),
   .iwbm_we_o  (wb_m2s_mor1kx0_i_we),
   .iwbm_cyc_o (wb_m2s_mor1kx0_i_cyc),
   .iwbm_stb_o (wb_m2s_mor1kx0_i_stb),
   .iwbm_cti_o (wb_m2s_mor1kx0_i_cti),
   .iwbm_bte_o (wb_m2s_mor1kx0_i_bte),
   .iwbm_dat_i (wb_s2m_mor1kx0_i_dat),
   .iwbm_ack_i (wb_s2m_mor1kx0_i_ack),
   .iwbm_err_i (wb_s2m_mor1kx0_i_err),
   .iwbm_rty_i (wb_s2m_mor1kx0_i_rty),

   .dwbm_adr_o (wb_m2s_mor1kx0_d_adr),
   .dwbm_dat_o (wb_m2s_mor1kx0_d_dat),
   .dwbm_sel_o (wb_m2s_mor1kx0_d_sel),
   .dwbm_we_o  (wb_m2s_mor1kx0_d_we),
   .dwbm_cyc_o (wb_m2s_mor1kx0_d_cyc),
   .dwbm_stb_o (wb_m2s_mor1kx0_d_stb),
   .dwbm_cti_o (wb_m2s_mor1kx0_d_cti),
   .dwbm_bte_o (wb_m2s_mor1kx0_d_bte),
   .dwbm_dat_i (wb_s2m_mor1kx0_d_dat),
   .dwbm_ack_i (wb_s2m_mor1kx0_d_ack),
   .dwbm_err_i (wb_s2m_mor1kx0_d_err),
   .dwbm_rty_i (wb_s2m_mor1kx0_d_rty),

   .irq_i      (32'b0)
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
rom0 (
   .wb_clk_i   (wb_clk),
   .wb_rst_i   (wb_rst),
   .wb_adr_i   (wb_m2s_rom0_adr[$clog2(ROM_DEPTH) - 1:0]),
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

wb_ram #(
   .depth      (ROM_DEPTH)
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

assign wb_s2m_rom0_rty = rst;
assign wb_s2m_ram0_rty = rst;

endmodule
