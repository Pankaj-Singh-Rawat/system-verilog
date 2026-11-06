module tb_siso();
    logic clk;
    logic rst_n;
    logic si;
    logic [3:0] q;

    siso uut(
        .clk(clk),
        .rst_n(rst_n),
        .si(si),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $display("time\t rst_n si | q");
        $monitor("%t\t %b     %b  | %b", $time, rst_n, si, q);
        
        rst_n = 0; si = 0; #12;
        rst_n = 1; si = 0; #10;

        si = 1; #12;
        si = 0; #12;
        si = 0; #12;
        si = 1; #12;

        rst_n = 0; #15;
        rst_n = 1; #8;

        $finish;
    end
endmodule