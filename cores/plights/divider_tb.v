`timescale 1ns/1ns
module divider_tb;
   parameter div = 2;
   localparam clk_half_period = 5;

   reg  clk = 1'b1;
   wire clk1;
   wire clk2;
   wire clk4;
   wire clk5;
   wire clk6;
   wire clk7;
   wire clk8;

   always #clk_half_period clk <= !clk;

   divider #(.div (1))
   div1 (.clk_in (clk), .clk_out (clk1));

   divider #(.div (2))
   div2 (.clk_in (clk), .clk_out (clk2));

   divider #(.div (3))
   div3 (.clk_in (clk), .clk_out (clk3));

   divider #(.div (4))
   div4 (.clk_in (clk), .clk_out (clk4));

   divider #(.div (5))
   div5 (.clk_in (clk), .clk_out (clk5));

   divider #(.div (6))
   div6 (.clk_in (clk), .clk_out (clk6));

   divider #(.div (7))
   div7 (.clk_in (clk), .clk_out (clk7));

   divider #(.div (8))
   div8 (.clk_in (clk), .clk_out (clk8));

   integer i;
   time last_edge = 0;

   initial
   begin
      //$dumpfile("plights.vcd");
      //$dumpvars;
      for (i = 1; i < 100; i = i + 1)
      begin
         @(clk);

         if (clk1 != clk)
            $display("Pulse %0d/10, clk1 = %0d is WRONG", i, clk1);
         if (clk2 != (i / 2) % 2)
            $display("Pulse %0d/10, clk2 = %0d is WRONG", i, clk2);
         if (clk3 != (i / 3) % 2)
            $display("Pulse %0d/10, clk3 = %0d is WRONG", i, clk3);
         if (clk4 != (i / 4) % 2)
            $display("Pulse %0d/10, clk4 = %0d is WRONG", i, clk4);
         if (clk5 != (i / 5) % 2)
            $display("Pulse %0d/10, clk5 = %0d is WRONG", i, clk5);
         if (clk6 != (i / 6) % 2)
            $display("Pulse %0d/10, clk6 = %0d is WRONG", i, clk6);
         if (clk7 != (i / 7) % 2)
            $display("Pulse %0d/10, clk7 = %0d is WRONG", i, clk7);
         if (clk8 != (i / 8) % 2)
            $display("Pulse %0d/10, clk8 = %0d is WRONG", i, clk8);
      end

      $display("Testbench finished OK");
      $finish;
   end

endmodule
