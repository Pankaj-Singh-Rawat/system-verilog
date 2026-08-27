module sipo_shift_reg(input wire clk,
                     input wire rst_n,
                     input wire din,
                      output reg [3:0] q);
  
  always @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
      q <= 4'b0000;
    end else begin
      q <= {din, q[3:1]};
    end
  end
endmodule
      
module tb();
  reg clk;
  reg rst_n;
  reg din;
  wire [3:0] q;
  
  sipo_shift_reg dut(
    .clk(clk),
    .rst_n(rst_n),
    .din(din),
    .q(q)
  );
  
  always #5 clk = ~clk;
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
    
    clk = 0; rst_n = 0; din = 0; #10;
    
	rst_n = 1; #10;
    
    din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 1; #10;
    
    $finish;
    
  end
endmodule