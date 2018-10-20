# Wishbone notes

## Building a wishbone master

Wishbone bus has only `wb_clk_i` and `wb_rst_i`, no clock or reset outputs. Every master and slave device must be clocked the same way as the bus itself, i.e. all of them must share same clock and reset source in simple case.


