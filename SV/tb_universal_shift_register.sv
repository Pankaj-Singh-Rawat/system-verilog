module tb_universal_shift_register();
	logic clk;
	logic rst_n;
	logic [1:0] ctrl;
	logic [3:0] d;
	logic sli;
	logic slr;
	logic [3:0] q;
	
	universal_shift_register uut(
		.clk(clk),
		.rst_n(rst_n),
		.ctrl(ctrl),
        .d(d),
        .sli(sli),
        .slr(slr),
        .q(q)
	);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("time\t rst_n ctrl sli slr | q");
        $monitor("%t\n\n %b %b %b %b | %b", $time, rst_n, ctrl, sli, slr, q);

        rst_n = 0; d = 4'b0000; ctrl = 2'b00; sli = 0; slr = 0; #12;
        rst_n = 1; #10;

        ctrl = 2'b11; d = 4'b1011; #5;
        ctrl = 2'b01; slr = 1; #7;
        ctrl = 2'b00; #8;
        ctrl = 2'b10; sli = 0; #5;

        $finish;
    end
endmodule
