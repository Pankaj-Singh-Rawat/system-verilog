module universal_shift_reg(
  input wire clk,
  input wire rst_n,
  input wire [1:0] mode,
  input wire din_left,
  input wire din_right,
  input wire [3:0] parallel_in,
  output reg [3:0] q
);
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 4'b0000;
    end else begin
      case (mode)
        2'b00 : q <= q;
        2'b01 : q <= {din_right, q[3:1]};
        2'b10 : q <= {q[2:0], din_left};
        2'b11 : q <= parallel_in;
      endcase
    end
  end
endmodule

module tb();
  reg clk;
  reg rst_n;
  reg [1:0] mode;
  reg din_left;
  reg din_right;
  reg [3:0] parallel_in;
  wire [3:0] q;
  
  universal_shift_reg dut(
    .clk(clk),
    .rst_n(rst_n),
    .mode(mode),
    .din_left(din_left),
    .din_right(din_right),
    .parallel_in(parallel_in),
    .q(q)
  );
  
  always #5 clk = ~clk;
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars;
    
    clk = 0; rst_n = 0; mode = 2'b00; din_left = 0; din_right = 0; parallel_in = 4'b0000; #10;
    
	rst_n = 1; #10;
 		
    parallel_in = 4'b1010; mode = 2'b11; #10;
    
    mode = 2'b00; #10;
    
    din_left = 1; mode = 2'b10; #10;
    
    din_right = 1; mode = 2'b01; #10;
    
    #20;
    
    $finish;
    
  end
endmodule