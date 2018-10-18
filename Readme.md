# My own FuseSoC related DE0\_Nano FPGA Kit specific demos

At first run

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
