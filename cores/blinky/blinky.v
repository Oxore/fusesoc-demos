module blinky
#(parameter clk_freq_hz = 50_000_000)
(
   input  clk,
   output reg blinky_o = 1'b0
);

   reg [$clog2(clk_freq_hz) - 1:0] count = 0;

   always @(posedge clk) begin
      count <= count + 1;
      if (count == clk_freq_hz - 1) begin
         blinky_o <= !blinky_o;
         count <= 0;
      end
   end

endmodule
