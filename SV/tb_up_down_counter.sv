module tb_up_counter();
    logic clk;
    logic rst_n;
    logic up_down;
    logic [3:0] q;

    up_down_counter_4bit uut(
        .clk(clk),
        .rst_n(rst_n),
        .up_down(up_down),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $display("time\n rst_n up_down | q");
        $monitor("%t\t\t %b %b | %b", $time, rst_n, up_down, q);

        rst_n = 0; up_down = 0; #12;
        rst_n = 1; #10;

        up_down = 1; #25;
        up_down = 0; #5;
        up_down = 1; #10;

        rst_n = 0; #10;
        rst_n = 1; #8;

        $finish;

    end
endmodule