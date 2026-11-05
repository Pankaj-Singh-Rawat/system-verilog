// Code your testbench here
// or browse Examples
module tb_d_ff();
    logic rst_n;
    logic clk;
    logic d;
    logic q;


    d_ff uut(
        .rst_n(rst_n),
        .clk(clk),
        .d(d),
        .q(q)
    );

    initial begin      
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Time\t rst_n d | q");
        $monitor("%t\t\t %b %b | %b", $time, rst_n, d, q);

        rst_n = 0; d = 0; #12;
        rst_n = 1; d = 0; #10;

        d = 1; #12;
        d = 0; #10;
        d = 1; #15;

        rst_n = 0; #8;
        rst_n = 1; #10;

        $finish;
    end
endmodule