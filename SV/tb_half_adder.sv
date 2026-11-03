module tb_half_adder();
  logic a, b;
  logic sum, carry;
  
  half_adder uut(
    .a(a), .b(b), .sum(sum), .carry(carry)
  );
  
  initial begin
    
    $display("time\t a b | sum carry");
    $monitor("%t\t\t %b %b | %b %b", $time, a, b, sum, carry);
    
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
    
    $finish;
  end

endmodule