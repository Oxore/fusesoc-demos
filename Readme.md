# My own FuseSoC related DE0\_Nano FPGA Kit specific demos

## Usage

Clone the repository:

```
git clone https://github.com/Oxore/fusesoc-demos
cd fusesoc-demos
```

Run the following command to initialize a local library of cores provided by this repository:

```
fusesoc library add local cores
```

Then you can run any demo with any target.
For example run the `sim` target of the `blinky` core to perform a simulation:

```
fusesoc run --target=sim blinky
```

Or build and program the `blinky` demo to a board using Quartus:

```
fusesoc run --target=synth blinky
```

## Cores

There are the following examples with the targets:

- `blinky` - blinking LED example
  - `sim` - Run tests using icarus verilog.
  - `synth` - Build and run on DE0\_Nano via Quartus.
- `plights` - Wishbone master example: pea lights.
  - `sim` - Run tests using icarus verilog.
  - `test_div` - Run `divider.v` module tests using icarus verilog.
  - `synth` - Build and run on DE0\_Nano via Quartus.

### Blinky

A trivial clock divider assigned to the `LED[0]` according to DE0\_Nano board specification.

### Plights

This is an example implementation of a simple wishbone master.
The master is implemented in the `mapper.v` verilog file.

It is a state machine, that reads 32-bit words from the ROM by address of `0x0800_0000`.
Every word after being read is written by address `0x9100_0000` which is a GPIO output port.
Byte of bits `[31:24]` is written to `0x9100_0000` - a data register of GPIO.
Byte of bits `[23:16]` is written to `0x9100_0001` - a direction register of GPIO.
There are `10` words in total stored in the `mem.hex` file.
You can see the two lights running from side to side on an LED array.

---

[Wishbone notes](Wishbone.md)
