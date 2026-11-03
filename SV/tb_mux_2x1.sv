module tb_mux_2x1();
    logic a, b, s;
    logic y;

    mux_2x1 uut(
        .a(a),
        .b(b),
        .s(s),
        .y(y)
    );

    initial begin
        $display("time\t a b s | y");
        $monitor("%t\t\t %b %b %b | %b", $time, a, b, s, y);

        a = 0;  b = 0; s = 0; #10;
        a = 0;  b = 1; s = 0; #10;
        a = 1;  b = 0; s = 0; #10;
        a = 1;  b = 1; s = 0; #10;


        a = 0;  b = 0; s = 1; #10;
        a = 0;  b = 1; s = 1; #10;
        a = 1;  b = 0; s = 1; #10;
        a = 1;  b = 1; s = 1; #10;

        $finish;
    end
endmodule