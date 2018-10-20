module blinky_top (
   input       sys_clk_pad_i,
   input       rst_n_pad_i,

   inout [7:0] gpio0_io,
   input [3:0] gpio1_i
);

   blinky blinky0 (.clk(sys_clk_pad_i), .blinky_o(gpio0_io[0]));

endmodule
