module tb_counter_4bit();
    logic clk;
    logic rst_n;
    logic en;
    logic [3:0] q;

    counter_4bit uut(
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $display("time\n rst_n en | q");
        $monitor("%t\t\t %b %b | %b", $time, rst_n, en, q);

        rst_n = 0; en = 0; #12;
        rst_n = 1; #10;

        en = 1; #25;
        en = 0; #5;
        en = 1; #10;

        rst_n = 0; #10;
        rst_n = 1; #8;

        $finish;

    end
endmodule