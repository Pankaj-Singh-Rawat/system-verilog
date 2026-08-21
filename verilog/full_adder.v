module full_adder(
	input a,
	input b,
  input cin,
  output y,
  output carry
);
  
  assign y = a ^ b ^ cin;
  assign carry = (a&b) + (b&cin) + (a&cin);
endmodule

module tb();
  reg a;
  reg b;
  reg cin;

  wire y;
  wire carry;

  full_adder dut(
    .a(a),
    .b(b),
    .cin(cin),
    .y(y),
    .carry(carry)
  );

  initial begin
    a = 0; b = 0; cin = 0; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    a = 0; b = 1; cin = 0; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    a = 1; b = 0; cin = 0; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    a = 1; b = 1; cin = 0; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    a = 0; b = 0; cin = 1; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    a = 0; b = 1; cin = 1; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    a = 1; b = 0; cin = 1; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    a = 1; b = 1; cin = 1; #10
    $display("a = %b, b = %b, cin = %b, y = %b, carry = %b", a, b, cin, y, carry);

    $finish;
  end
endmodule