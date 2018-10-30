module mapper
#(
   parameter addr_in_start  = 32'h08000000,
   parameter addr_in_end    = addr_in_start + 4 * (10 - 1),
   parameter addr_out_start = 32'h91000000,
   parameter addr_out_end   = addr_out_start + 1
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
   localparam READ_STEP = 4;

   localparam READ_ROM = 0;
   localparam WRITE_LED = 1;

   localparam IDLE = 0;
   localparam REQ = 1;

   reg        rw_cycle = READ_ROM;
   reg        state = IDLE;
   reg [31:0] data = 0;
   reg [31:0] addr_read = addr_in_start;
   reg [31:0] addr_write = addr_out_start;

   assign  wb_cyc_o = state;
   assign  wb_stb_o = state;
   assign  wb_we_o  = state & rw_cycle;
   initial wb_adr_o = addr_in_start;

   always @(posedge wb_clk)
   begin
      if (wb_rst)
      begin
         state <= IDLE;
         rw_cycle <= READ_ROM;
         addr_read <= addr_in_start;
         addr_write <= addr_out_start;
         wb_adr_o <= addr_in_start;
         wb_dat_o <= 0;
         data <= 0;
      end
      else
      begin
         if ((state == IDLE) && !wb_rty_i)
         begin
            state <= REQ;

            if (rw_cycle == WRITE_LED)
            begin
               wb_dat_o <= data;
               wb_sel_o[3:2] <= {~wb_adr_o[0], wb_adr_o[0]};
            end
            else
            begin
               wb_sel_o <= 4'b0;
            end
         end

         if (state == REQ)
         begin
            if (wb_ack_i)
            begin
               state <= IDLE;

               if (rw_cycle == READ_ROM)
               begin
                  data <= wb_dat_i;

                  if (addr_read >= addr_in_end)
                     addr_read <= addr_in_start;
                  else
                     addr_read <= addr_read + READ_STEP;

                  rw_cycle <= WRITE_LED;
                  wb_adr_o <= addr_write;
               end
               else
               begin
                  if (addr_write == addr_out_end)
                  begin
                     addr_write <= addr_out_start;
                     rw_cycle <= READ_ROM;
                     wb_adr_o <= addr_read;
                  end
                  else
                  begin
                     addr_write <= addr_write + 1;
                     wb_adr_o <= addr_write + 1;
                  end
               end
            end
         end
      end
   end

endmodule
