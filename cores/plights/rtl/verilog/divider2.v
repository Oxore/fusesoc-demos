module divider2
#(parameter clk_freq_hz = 50_000_000)
(
   input  clk_in,
   output reg clk_out = 1'b0
);

   reg [$clog2(clk_freq_hz) - 1:0] count = 0;

   always @(posedge clk_in) begin
      count <= count + 1;
      if (count == clk_freq_hz - 1) begin
         clk_out <= !clk_out;
         count <= 0;
      end
   end

endmodule
