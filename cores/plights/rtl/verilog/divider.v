/*
 * This clock divider does not work correctly on a real FPGA for some reason
 * but works perfectly in icarus verilog
 *
 * */
module divider
#(
   parameter div = 1
)
(
   input  clk_in,
   output clk_out
);

   reg [$clog2(div) - 1:0] count = 0;

generate
   if (div <= 1)
      assign clk_out = clk_in;
   else
   begin
      reg clk = 1'b0;

      assign clk_out = clk;

      always @(clk_in)
      begin
         if (count == div - 1)
         begin
            clk   <= !clk;
            count <= 0;
         end
         else
            count <= count + 1;
      end
   end
endgenerate

endmodule
