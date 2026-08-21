module half_subtractor(

	input a,
	input b, 
	output y,
	output br
    );

    assign y = a ^ b;
    assign br = ~a & b;
  
endmodule

module half_sub_tb;
  reg a;
  reg b;
  wire y; 
  wire br;
  
  half_subtractor dut(.a(a), .b(b), .y(y), .br(br));
  
  
  initial begin
    
    a=0; b=0; #10
    $display("a = %b, b = %b, y = %b, br = %b", a , b , y, br);
    a=0; b=1; #10
    $display("a = %b, b = %b, y = %b, br = %b", a , b , y, br);
    a=1; b=0; #10
    $display("a = %b, b = %b, y = %b, br = %b", a , b , y, br);
    a=1; b=1; #10
    $display("a = %b, b = %b, y = %b, br = %b", a , b , y, br);

  end
  
endmodule