`timescale 1ns/1ns
module plights_tb;
   parameter div = 2;
   localparam clk_half_period = div * 5;

   reg         clk = 1'b1;
   reg         rst = 1'b0;
   inout [7:0] led;

   always #clk_half_period clk <= !clk;

   plights
   dut (
      .clk  (clk),
      .rst  (rst),
      .led  (led)
   );

   integer i;

   initial
   begin
      $dumpfile("plights.vcd");
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
