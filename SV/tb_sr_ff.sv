module tb_sr_ff();
    logic clk;
    logic rst_n;
    logic s;
    logic r;
    logic q;

    sr_ff uut (
        .clk(clk),
        .rst_n(rst_n),
        .s(s),
        .r(r),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Time\t rst_n s r | q");
        $monitor("%t\t\t %b %b %b | %b", $time, rst_n, s, r, q);

        rst_n = 0; s = 0; r = 0; #12;
        rst_n = 1; #10;

        s = 1; #10;
        s = 1; r = 0; #10;
        s = 1; r = 1; #15;

        rst_n = 0; #8;
        rst_n = 1; #10;

        $finish;
    end
endmodule