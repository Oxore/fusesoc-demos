# My own FuseSoC related DE0\_Nano FPGA Kit specific demos

## Usage

Clone this repository:

```
git clone https://github.com/Oxore/fusesoc-demos
cd fusesoc-demos
```

Run following command to initialize local library provided by this repository:

```
fusesoc library add local cores
```

Then you can any demo with any target.
For example `blinky` core `sim` target for simulation:

```
fusesoc run --target=sim blinky
```

Or build and program `blinky` demo to a board:

```
fusesoc run --target=synth blinky
```

## Cores

There are following examples with targets:

- `blinky` - blinking LED example
  - `sim` - Run tests using icarus verilog.
  - `synth` - Build and run on DE0\_Nano via Quartus.
- `plights` - Wishbone master example: pea lights.
  - `sim` - Run tests using icarus verilog.
  - `test_div` - Run `divider.v` module tests using icarus verilog.
  - `synth` - Build and run on DE0\_Nano via Quartus.

### Blinky

Trivial clock divider assigned to `LED[0]` according to DE0\_Nano board specification.

### Plights

This is simple wishbone master example.
The master implemented in `mapper.v` verilog file.

It is a state machine, that reads 32-bit words from some ROM from address of `0x0800_0000`.
Every word after being read is written by address `0x9100_0000` which is GPIO output port.
Byte of bits `[31:24]` is written to `0x9100_0000` - data register of GPIO.
Byte of bits `[23:16]` is written to `0x9100_0001` - direction register of GPIO.
There are `10` words in total stored in `mem.hex` file.
You can see two lights running from side to side on LED array.

---

[Wishbone notes](Wishbone.md)
