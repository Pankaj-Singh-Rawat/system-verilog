module half_adder(

	input a,
	input b, 
	output y,
	output c);
   assign y = a ^ b;
  assign c = a & b;
  
endmodule


module half_adder_tb;
  reg a;
  reg b;
  wire y; 
  wire c;
  
  half_adder dut(.a(a), .b(b), .y(y), .c(c));
  
  
  initial begin
    
    a=0; b=0; #10
    $display("a = %b, b = %b, y = %b, c = %b", a , b , y, c);
    a=0; b=1; #10
    $display("a = %b, b = %b, y = %b, c = %b", a , b , y, c);
    a=1; b=0; #10
    $display("a = %b, b = %b, y = %b, c = %b", a , b , y, c);
    a=1; b=1; #10
    $display("a = %b, b = %b, y = %b, c = %b", a , b , y, c);

  end
  
endmodule