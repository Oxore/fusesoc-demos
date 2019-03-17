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
- `rv_sopc` - Basic RISCV sopc with gpio.
  - `sim` - Run tests using icarus verilog. Patch `picorv32` submodule before
  running (see [description](#RISC_V_SOPC)).

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

### RISC V SOPC

Before running this target you need to apply patch to `picorv32` submodule with
following command (assuming you are at the root directory of this repo):

    git apply cores/picorv32.patch --directory=cores/picorv32

Then you should build the program for this SOC.
You need [`riscv32-unknown-elf`](https://github.com/riscv/riscv-gnu-toolchain)
toolchain for this.

    make -C cores/rv_sopc/data/sw

Then run `fusesoc`:

    fusesoc run --target=sim rv_sopc

At this point there is not much functionality.
There is `gpio0` at base `0x9100_0000` and `ram0` at base `0x0` which is used to
directly load a program with `$radmemh()` function.
It is also used for stack which starts at `0x0000_4000` and grows down.

---

[Wishbone notes](Wishbone.md)
