module down_counter (
    input wire clk,
    input wire rst_n,
    input wire enable,
    output reg [3:0] count
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count <= 4'b1111;
    end else if (enable) begin
      count <= count - 1'b1;
    end
  end
endmodule 

module tb ();

  reg clk;
  reg rst_n;
  reg enable;
  wire [3:0] count;

  down_counter uut (
      .clk   (clk),
      .rst_n (rst_n),
      .enable(enable),
      .count (count)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb); 
    clk    = 0;
    rst_n  = 0;
    enable = 0;

    #12 rst_n = 1;
    #10 enable = 1;
    #100;

    $finish;
  end

endmodule  