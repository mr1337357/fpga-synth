SPI Synthesizer for FPGA in VHDL
================================

Motivation
----------
There are two main motives for creating this project. First of all, I'm taking a course that requires that we develop some sort of project on an FPGA. Second of all, I'd like to have a slightly more custom than average entry into demoscene contests.

Usage
-----
Simply create a project in your favorite FPGA development environment and import the code in the HDL folder. Keep in mind that the tb subfolder code will not synthesize. It is mainly for simulation and debugging.

Signals:
* l_out: left audio channel
* r_out: right audio channel
* clk: 100Mhz crystal input
* sck: SPI serial clock
* sdi: SPI serial data
* cs: SPI active low chipselect
* led(15:0): control LEDs on the dev board for debugging (may leave disconnected)

Protocol:
---------
This synthesizer uses standard SPI unidirectional data communication. There currently is no provision for the FPGA to report data back to the host processor.
Packets take the form of /CS,addr,data,CS. This means that a transaction begins with the processor bringing CS low, then transmitting a one byte address to pick a sub-block of the design, followed by data to be transmitted to said block.
The FPGA will assume that sdi is valid only on falling edges of sck.

Addresses:

* 0. Frequency/Phase accumulator - This sets the step size for the phase accumulator. In plain English, this means the frequency of the note to be played. This register contains a MSB-first 16 bit number
* 1. Look Up Table - This is the memory to store the wave. Waves take the form of offset binary signed bytes. There are 256 samples per wave, each 8 bits wide. Offset binary simply means it is a signed number with the most significant bit inverted. 
* 2. Volume/Envelope - This sets the volume for the signal to be played. Currently it is a linear function, although I'd like to change this to a scaled logarithmic curve. It takes a one byte unsigned number but it only uses the 5 least significant bits.
* 3. LEDs - This register isn't necessary. It is just a 16 bit register that shows its stored value on a bank of LEDs.

SPI TIMING
----------
```
       +----------------------------------------------------------------------------+
       |                                                                            |
CS     | +--+                                                                  +--+ |
       |    |                                                                  |    |
       |    +------------------------------------------------------------------+    |
SCK    | +------+   +---+   +---+   +---+   +---+   +---+   +---+   +---+   +-----+ |
       |        |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |       |
       |        +---+   +---+   +---+   +---+   +---+   +---+   +---+   +---+       |
SDI    | +--+                                               +-------+       +-----+ |
       |    |                                               |       |       |       |
       |    +-----------------------------------------------+       +-------+       |
       |                                                                            |
       +----------------------------------------------------------------------------+
BITS            0       0       0       0       0       0       1       0      =0x02
```
