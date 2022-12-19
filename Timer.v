//`include "timescale.v"
`timescale 1ns/10ps


//`include "watchdog_defines.v"
/* Wishbone data width */
`define WDT_WIDTH  32

/* If number is -1, counting is stopped */
`define WDT_INITIAL (~`WDT_WIDTH'h0)


module watchdog(
	wb_clk_i, wb_rst_i, wb_dat_i, wb_dat_o, 
	wb_we_i, wb_stb_i, wb_cyc_i, wb_ack_o,
        wb_int_o);

parameter Tp = 1;

// wishbone signals
input         wb_clk_i;     // master clock input
input         wb_rst_i;     // synchronous active high reset
input  [`WDT_WIDTH - 1:0] wb_dat_i;     // databus input
output [`WDT_WIDTH - 1:0] wb_dat_o;     // databus output
reg    [`WDT_WIDTH - 1:0] wb_dat_o;
input         wb_we_i;      // write enable input
input         wb_stb_i;     // stobe/core select signal
input         wb_cyc_i;     // valid bus cycle input
output        wb_ack_o;     // bus cycle acknowledge output
output        wb_int_o;     // interrupt request signal output
reg           wb_int_o;     // interrupt request signal output

reg           stb;
reg           we;
reg    [`WDT_WIDTH - 1:0] dat_ir;

assign        wb_ack_o = stb;

/* sample input signals */
always @(posedge wb_rst_i or posedge wb_clk_i)
  if (wb_rst_i) begin
    stb <= #Tp 1'b0;
    we <= #Tp 1'b0;
    dat_ir <= #Tp `WDT_WIDTH'h0;
  end else begin
    stb <= #Tp wb_stb_i && wb_cyc_i;
    we <= #Tp wb_we_i;
    dat_ir <= #Tp wb_dat_i;
  end

/* Counter */
always @(posedge wb_rst_i or posedge wb_clk_i)
  if (wb_rst_i) wb_dat_o <= #Tp `WDT_INITIAL;
  else if (stb && we) wb_dat_o <= #Tp dat_ir;
  else if (~&wb_dat_o) wb_dat_o <= #Tp wb_dat_o - `WDT_WIDTH'h1;

/* Interrupt */
always @(posedge wb_rst_i or posedge wb_clk_i)
  if (wb_rst_i) wb_int_o <= #Tp 1'b0;
  else if (stb) wb_int_o <= #Tp 1'b0;
  else if (~|wb_dat_o) wb_int_o <= #Tp 1'b1;

endmodule
