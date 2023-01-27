# RISC-V-Watch-Dog-Timer-

(1). 32 Bit Watchdog Timer:

(1). This module has four inputs: clk, rst, en, and an output wdt. The clk input is the clock signal that drives the timer, rst is the reset signal, and en is the enable signal. The wdt output is a signal that indicates when the timer has expired.

(2). The module uses an internal 32-bit counter cnt that is incremented on each rising edge of the clk signal, as long as the en signal is high. The counter is reset to 0 when the rst signal is high.

(3). When the counter reaches its maximum value (32'h3fffffff), the wdt signal is set to 1 and the counter is reset to 0. Otherwise, the wdt signal is set to 0.

(2). Test Bench of 32 Bit Watchdog Timer:

(1). In the testbench, I created all the necessary input regs, clk, rst, en and wire for the output, wdt. Then instantiated the module under test (uut) with these inputs and output.

(2). In the initial block, I set the initial values for inputs, rst and en are high, and clk starts with 0. Then I set rst to low after 5 ns and en to 1 after another 5 ns. Finally, I created an infinite loop to toggle the clock signal every 5 ns.

