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

Then you can perform a simulation of the blinky demo:

```
fusesoc run --target=sim blinky
```

Or build and program the blinky demo to the board:

```
fusesoc run --target=synth blinky
```

## Cores

There are following examples:

- `blinky` - blinking LED example
  - `sim` - Run tests using icarus verilog.
  - `synth` - Build and run on DE0\_Nano via Quartus.
- `plights` ***(unimplemented)*** - Wishbone master example: pea lights.
  - `sim` ***(unimplemented)*** - Run tests using icarus verilog.
  - `test_div` - Run `divider.v` module tests using icarus verilog.
  - `synth` ***(unimplemented)*** - Build and run on DE0\_Nano via Quartus.

---

[Wishbone notes](Wishbone.md)
