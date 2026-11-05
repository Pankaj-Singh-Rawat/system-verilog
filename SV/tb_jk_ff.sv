module tb_jk_ff();
    logic clk;
    logic rst_n;
    logic j;
    logic k;
    logic q;

    jk_ff uut (
        .clk(clk),
        .rst_n(rst_n),
        .j(j),
        .k(k),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Time\t rst_n j k | q");
        $monitor("%t\t\t %b %b %b | %b", $time, rst_n, j, k, q);

        rst_n = 0; j = 0; k = 0; #12;
        rst_n = 1; #10;

        j = 1; #10;
        k = 1; j = 0; #10;
        j = 1; k = 1; #15;

        rst_n = 0; #8;
        rst_n = 1; #10;

        $finish;
    end
endmodule