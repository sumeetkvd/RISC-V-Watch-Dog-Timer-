module watchdog_timer (input clk, input rst, input en, input [31:0] timeout, output reg wdt);
   reg [31:0] cnt;
   always @(posedge clk) begin
      if (rst) begin
         cnt <= 32'h0;
      end 
      else if (en) begin
         cnt <= cnt + 1;
      end
   end
   always @(posedge clk) begin
      if (cnt == timeout) begin
         wdt <= 1;
         cnt <= 32'h0;
      end 
      else begin
         wdt <= 0;
      end
   end
endmodule
