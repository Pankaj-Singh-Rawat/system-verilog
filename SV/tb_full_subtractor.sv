module tb_full_subtractor();
    logic a, b, bin;
    logic diff, bout;

    full_subtractor uut (
        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)
    );

    initial begin
        $display("time\t a b bin | diff bout");
        $monitor("%t\t\t %b %b %b | %b %b", $time, a, b, bin, diff, bout);


        a = 0; b = 0; bin = 0; #10;
        a = 0; b = 1; bin = 0; #10;
        a = 1; b = 0; bin = 0; #10;
        a = 1; b = 1; bin = 0; #10;

        a = 0; b = 0; bin = 1; #10;
        a = 0; b = 1; bin = 1; #10;
        a = 1; b = 0; bin = 1; #10;
        a = 1; b = 1; bin = 1; #10;

        $finish;
    end
endmodule