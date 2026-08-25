module up_down_counter(
	input wire clk,
	input wire rst_n,
	input wire mode,
	input wire enable,
  output reg [3:0] y);
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      y <= 4'b000;
    end else if(enable) begin
      if (mode) begin
        y <= y + 1'b1;
      end else begin
        y <= y - 1'b1;
      end
    end
  end 
endmodule
    
module tb();
  reg clk;
  reg rst_n;
  reg mode;
  reg enable;
  
  wire [3:0] y;
  
  up_down_counter dut(
    .clk(clk),
    .rst_n(rst_n),
    .mode(mode),
    .enable(enable),
    .y(y)
  );
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
    clk = 0;
    rst_n = 0;
    enable = 0;
    mode = 1;
    #10;
    
    rst_n = 1;
    #10;
    enable = 1;
    #40;
    
    mode = 0;
    #40;
    
    $finish;
  end
endmodule