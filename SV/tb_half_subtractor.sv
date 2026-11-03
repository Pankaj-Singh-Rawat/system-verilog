module tb_half_subtractor();
  logic a, b;
  logic diff, borrow;
  
  half_subtractor uut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_half_subtractor);
    $display("time\t a b | diff borrow");
    $monitor("%t\t\t %b %b | %b %b", $time, a, b, diff, borrow);
    
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
    
    $finish;
  end
endmodule