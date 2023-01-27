module watchdog_timer (input clk, input rst, input en, output reg wdt);
   reg [31:0] cnt;
   always @(posedge clk) begin
      if (rst) begin
         cnt <= 32'h0;
      end else if (en) begin
         cnt <= cnt + 1;
      end
   end
   always @(posedge clk) begin
      if (cnt == 32'h3fffffff) begin
         wdt <= 1;
         cnt <= 32'h0;
      end else begin
         wdt <= 0;
      end
   end
endmodule
