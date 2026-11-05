module tb_t_ff();
    logic clk;
    logic rst_n;
    logic t;
    logic q;

    t_ff uut(
        .clk(clk),
        .rst_n(rst_n),
        .t(t),
        .q(q)
    );

    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Time\t rst_n t | q");
        $monitor("%t\t\t %b %b | %b", $time, rst_n, t, q);

        rst_n = 0; t = 0; #12;
        rst_n = 1;  #10;

        t = 1; #8;
        t = 0; #10;
        t = 1; #8;

        rst_n = 0; #12;
        rst_n = 1; #8;

        $finish;
    end
    endmodule
        