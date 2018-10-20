module mapper
#(
   parameter addr_in_start = 32'hF0000110,
   parameter addr_in_end   = 32'hF0000008,
   parameter addr_out      = 32'h91000000
)
(
   input             wb_clk,
   input             wb_rst,
   input      [31:0] wb_dat_i,
   input             wb_ack_i,
   input             wb_err_i,
   input             wb_rty_i,
   output reg [31:0] wb_adr_o = 0,
   output reg [31:0] wb_dat_o = 0,
   output reg  [3:0] wb_sel_o = 0,
   output            wb_we_o,
   output            wb_cyc_o,
   output reg  [2:0] wb_cti_o = 0,
   output reg  [1:0] wb_bte_o = 0,
   output            wb_stb_o
);
   localparam IDLE = 0;
   localparam REQ = 1;
   localparam WAIT = 2;

   reg [31:0] addr = addr_out;
   reg  [1:0] state = IDLE;
   reg [31:0] data;

   assign wb_cyc_o = ^(state);
   assign wb_stb_o = state[0] & ~state[1];
   assign wb_we_o = 0;

   always @(posedge wb_clk)
   begin
      if (wb_rst)
      begin
         state <= IDLE;
         addr <= addr_out;
      end
      else
      begin
         if ((state == IDLE) && !wb_rty_i)
         begin
            state <= REQ;
         end

         if (state == REQ)
         begin
            if (wb_ack_i)
            begin
               data <= wb_dat_i;
               state <= IDLE;
            end
         end
      end
   end

endmodule
