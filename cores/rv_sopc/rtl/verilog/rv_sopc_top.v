module rv_sopc_top (
   input    sys_clk_pad_i,
   input    rst_n_pad_i,
   input    usrkey_n_pad_i,

   output [7:0]   gpio0_io
);
   localparam irq_period = 10_000;

   wire clk = sys_clk_pad_i;
   wire rst = ~rst_n_pad_i;
   reg  irq = 1'b0;

   reg [$clog2(irq_period) - 1:0] count = 0;

   always @(posedge clk) begin
      count <= count + 1;
      if (count == irq_period - 1) begin
         irq <= 1;
         count <= 0;
      end
      else begin
         irq <= 0;
      end
   end

   rv_sopc
   dut (
      .clk  (clk),
      .rst  (rst),
      .irq  (irq),
      .led  (gpio0_io)
   );

endmodule
