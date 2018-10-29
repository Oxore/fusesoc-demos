# Wishbone B3 notes

## Building a simple wishbone master

Wishbone bus has only clock and reset *inputs* - `wb_clk_i` and `wb_rst_i`, no clock or reset outputs.
Every master and slave device must be clocked the same way as the bus itself, i.e. all of them must share same clock and reset source in simple case.

In simple case `wb_cti_o` of master should always be set to `000`, if burst mode is not used.

In simple case for every transaction it is mandatory for master to set `wb_stb_o` and `wb_cyc_o` to `high` and wait for slave setting the `wb_ack_i` to `high`, which means the end of transaction.
`wb_stb_o` and `wb_cyc_o` signals may may be set to `low`.

If `wb_we_o` was set alongside with `wb_stb_o` and `wb_cyc_o` to `high`, then a write transaction performed.
Otherwise a read transaction performed.

If slave has no `wb_rty_o`, it must be driven somehow (by `rst` or pulled down to `low`), otherwise `wb_err_i` will be set to `high`.

## Controlling slave's low address bits [1:0]

There is such a code in `wb_data_resize.v` in [`wb_intercon_1.2.1`](https://github.com/olofk/wb_intercon):

```verilog
assign wbs_adr_o[1:0] = wbm_sel_i[3] ? 2'd0 :
                        wbm_sel_i[2] ? 2'd1 :
                        wbm_sel_i[1] ? 2'd2 : 2'd3;

assign wbs_dat_o = wbm_sel_i[3] ? wbm_dat_i[31:24] :
                   wbm_sel_i[2] ? wbm_dat_i[23:16] :
                   wbm_sel_i[1] ? wbm_dat_i[15:8]  :
                   wbm_sel_i[0] ? wbm_dat_i[7:0]   : 8'b0;
```

Which means the following for 8 bit slave:

| sel[3] | sel[2] | sel[1] | sel[0] | s\_adr\_i[1] | s\_adr\_i[0] | s\_dat\_i[7:0]   |
| :----: | :----: | :----: | :----: | :----------: | :----------: | :--------------: |
| **1**  | x      | x      | x      | 0            | 0            | m\_dat\_o[31:24] |
| 0      | **1**  | x      | x      | 0            | **1**        | m\_dat\_o[23:16] |
| 0      | 0      | **1**  | x      | **1**        | 0            | m\_dat\_o[15:8]  |
| 0      | 0      | 0      | **1**  | **1**        | **1**        | m\_dat\_o[7:0]   |
| 0      | 0      | 0      | 0      | **1**        | **1**        | 0                |

A reversed binary encoder.
Strange, huh?
For me it is strange, although wishbone documentation does not describe this moment.
It would be much intuitive if it was like this:

| sel[3] | sel[2] | sel[1] | sel[0] | s\_adr\_i[1] | s\_adr\_i[0] | s\_dat\_i[7:0]   |
| :----: | :----: | :----: | :----: | :----------: | :----------: | :--------------: |
| 0      | 0      | 0      | 0      | 0            | 0            | 0                |
| x      | x      | x      | **1**  | 0            | 0            | m\_dat\_o[7:0]   |
| x      | x      | **1**  | 0      | 0            | **1**        | m\_dat\_o[15:8]  |
| x      | **1**  | 0      | 0      | **1**        | 0            | m\_dat\_o[23:16] |
| **1**  | 0      | 0      | 0      | **1**        | **1**        | m\_dat\_o[31:24] |

## Memory mapping

There is a strange thing while specifying size in [`wb_intercon_1.2.1`](https://github.com/olofk/wb_intercon).
For instance, `size=80` produces a right mask, but sets `err` to `high` after accessing address `base+0x10`.
Setting `size=8000` allows addresses up to `base+0x80`.
Probably a bug in `wb_mux.v`.
