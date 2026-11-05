module tb_comparator();

    logic [3:0] a, b;
    logic gt, lt, eq;

    comparator uut (
        .a(a),
        .b(b),
        .gt(gt),
        .lt(lt),
        .eq(eq)
    );

    initial begin
    $display("Time\t a b | gt lt eq");
    $monitor("%t\t\t %b %b | %b %b %b", $time, a, b, gt, lt, eq);
        a = 4'b0000; b = 4'b0000; #10;
        a = 4'b0100; b = 4'b0010; #10;
        a = 4'b0001; b = 4'b0100; #10;
        a = 4'b1111; b = 4'b1111; #10;
      $finish;
    end
endmodule