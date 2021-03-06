`timescale 1ns/1ns
module rv_sopc_tb;
   parameter div = 2;
   localparam clk_half_period = div * 5;
   localparam irq_period = 10_000;

   reg         clk = 1'b1;
   reg         rst = 1'b0;
   inout [7:0] led;
   reg         irq = 1'b0;

   always #clk_half_period clk <= !clk;

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
      .led  (led),
      .irq  (irq)
   );

   integer i;

   initial
   begin
      $dumpfile("testbench.vcd");
      $dumpvars;
      #100
      rst <= 1'b1;
      #200
      rst <= 1'b0;
      @(led);
      for (i = 0; i < 10; i = i + 1)
      begin
         @(led);

         $display("Pulse %0d/10 %0d", i + 1, led);
      end

      $display("Testbench finished OK");
      $finish;
   end

endmodule
