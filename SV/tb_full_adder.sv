module tb_full_adder();
  logic a, b, cin;
  logic sum, carry;
  
  full_adder uut (
    .a(a), .b(b), .cin(cin),
    .sum(sum), .carry(carry)
  );
  
  initial begin
    
    $display("Time\t a b cin | carry sum");
    $monitor("%0t\t\t %b %b %b | %b %b", $time, a, b, cin, carry, sum);
    
    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 1; cin = 0; #10;
    
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 1; #10;
    
    $finish;
  end
endmodule