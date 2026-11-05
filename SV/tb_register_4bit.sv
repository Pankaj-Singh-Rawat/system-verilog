module tb_register_4bit();
    logic clk;
    logic rst_n;
    logic load;
    logic [3:0] d;
    logic [3:0] q;

    register_4bit uut(
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .d(d),
        .q(q)
    );


    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $display("Time\n rst_n load d | q");
        $monitor("%t\n\n %b %b %b | %b", $time, rst_n, load, d, q);

        rst_n = 0; d = 4'b0000; load = 0; #12;
        rst_n = 1; #10;

        load = 1; d = 4'b1010;#8;
         

        load = 0; d = 4'b1111; #15;

        load = 1; d = 4'b0001; #8;

        rst_n = 0; #8;
        rst_n = 1; #8;

        $finish;
    end

endmodule
