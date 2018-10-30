module plights_top (
   input    sys_clk_pad_i,
   input    rst_n_pad_i,
   input    usrkey_n_pad_i,

   output [7:0]   gpio0_io
);

   wire clk;
   wire rst;

   assign rst = ~rst_n_pad_i;

   divider2 #(.clk_freq_hz (500_000))
   div0 (.clk_in (sys_clk_pad_i), .clk_out (clk));

   plights
   dut (
      .clk  (clk),
      .rst  (rst),
      .led  (gpio0_io)
   );

endmodule
