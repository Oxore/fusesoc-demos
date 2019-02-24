// THIS FILE IS AUTOGENERATED BY wb_intercon_gen
// ANY MANUAL CHANGES WILL BE LOST
module wb_dbus
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_mor1kx0_d_adr_i,
    input  [31:0] wb_mor1kx0_d_dat_i,
    input   [3:0] wb_mor1kx0_d_sel_i,
    input         wb_mor1kx0_d_we_i,
    input         wb_mor1kx0_d_cyc_i,
    input         wb_mor1kx0_d_stb_i,
    input   [2:0] wb_mor1kx0_d_cti_i,
    input   [1:0] wb_mor1kx0_d_bte_i,
    output [31:0] wb_mor1kx0_d_dat_o,
    output        wb_mor1kx0_d_ack_o,
    output        wb_mor1kx0_d_err_o,
    output        wb_mor1kx0_d_rty_o,
    output [31:0] wb_gpio0_adr_o,
    output  [7:0] wb_gpio0_dat_o,
    output  [3:0] wb_gpio0_sel_o,
    output        wb_gpio0_we_o,
    output        wb_gpio0_cyc_o,
    output        wb_gpio0_stb_o,
    output  [2:0] wb_gpio0_cti_o,
    output  [1:0] wb_gpio0_bte_o,
    input   [7:0] wb_gpio0_dat_i,
    input         wb_gpio0_ack_i,
    input         wb_gpio0_err_i,
    input         wb_gpio0_rty_i);

wire [31:0] wb_m2s_resize_gpio0_adr;
wire [31:0] wb_m2s_resize_gpio0_dat;
wire  [3:0] wb_m2s_resize_gpio0_sel;
wire        wb_m2s_resize_gpio0_we;
wire        wb_m2s_resize_gpio0_cyc;
wire        wb_m2s_resize_gpio0_stb;
wire  [2:0] wb_m2s_resize_gpio0_cti;
wire  [1:0] wb_m2s_resize_gpio0_bte;
wire [31:0] wb_s2m_resize_gpio0_dat;
wire        wb_s2m_resize_gpio0_ack;
wire        wb_s2m_resize_gpio0_err;
wire        wb_s2m_resize_gpio0_rty;

wb_mux
  #(.num_slaves (1),
    .MATCH_ADDR ({32'h91000000}),
    .MATCH_MASK ({32'hfffffffe}))
 wb_mux_mor1kx0_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_mor1kx0_d_adr_i),
    .wbm_dat_i (wb_mor1kx0_d_dat_i),
    .wbm_sel_i (wb_mor1kx0_d_sel_i),
    .wbm_we_i  (wb_mor1kx0_d_we_i),
    .wbm_cyc_i (wb_mor1kx0_d_cyc_i),
    .wbm_stb_i (wb_mor1kx0_d_stb_i),
    .wbm_cti_i (wb_mor1kx0_d_cti_i),
    .wbm_bte_i (wb_mor1kx0_d_bte_i),
    .wbm_dat_o (wb_mor1kx0_d_dat_o),
    .wbm_ack_o (wb_mor1kx0_d_ack_o),
    .wbm_err_o (wb_mor1kx0_d_err_o),
    .wbm_rty_o (wb_mor1kx0_d_rty_o),
    .wbs_adr_o ({wb_m2s_resize_gpio0_adr}),
    .wbs_dat_o ({wb_m2s_resize_gpio0_dat}),
    .wbs_sel_o ({wb_m2s_resize_gpio0_sel}),
    .wbs_we_o  ({wb_m2s_resize_gpio0_we}),
    .wbs_cyc_o ({wb_m2s_resize_gpio0_cyc}),
    .wbs_stb_o ({wb_m2s_resize_gpio0_stb}),
    .wbs_cti_o ({wb_m2s_resize_gpio0_cti}),
    .wbs_bte_o ({wb_m2s_resize_gpio0_bte}),
    .wbs_dat_i ({wb_s2m_resize_gpio0_dat}),
    .wbs_ack_i ({wb_s2m_resize_gpio0_ack}),
    .wbs_err_i ({wb_s2m_resize_gpio0_err}),
    .wbs_rty_i ({wb_s2m_resize_gpio0_rty}));

wb_data_resize
  #(.aw  (32),
    .mdw (32),
    .sdw (8))
 wb_data_resize_gpio0
   (.wbm_adr_i (wb_m2s_resize_gpio0_adr),
    .wbm_dat_i (wb_m2s_resize_gpio0_dat),
    .wbm_sel_i (wb_m2s_resize_gpio0_sel),
    .wbm_we_i  (wb_m2s_resize_gpio0_we),
    .wbm_cyc_i (wb_m2s_resize_gpio0_cyc),
    .wbm_stb_i (wb_m2s_resize_gpio0_stb),
    .wbm_cti_i (wb_m2s_resize_gpio0_cti),
    .wbm_bte_i (wb_m2s_resize_gpio0_bte),
    .wbm_dat_o (wb_s2m_resize_gpio0_dat),
    .wbm_ack_o (wb_s2m_resize_gpio0_ack),
    .wbm_err_o (wb_s2m_resize_gpio0_err),
    .wbm_rty_o (wb_s2m_resize_gpio0_rty),
    .wbs_adr_o (wb_gpio0_adr_o),
    .wbs_dat_o (wb_gpio0_dat_o),
    .wbs_we_o  (wb_gpio0_we_o),
    .wbs_cyc_o (wb_gpio0_cyc_o),
    .wbs_stb_o (wb_gpio0_stb_o),
    .wbs_cti_o (wb_gpio0_cti_o),
    .wbs_bte_o (wb_gpio0_bte_o),
    .wbs_dat_i (wb_gpio0_dat_i),
    .wbs_ack_i (wb_gpio0_ack_i),
    .wbs_err_i (wb_gpio0_err_i),
    .wbs_rty_i (wb_gpio0_rty_i));

endmodule
