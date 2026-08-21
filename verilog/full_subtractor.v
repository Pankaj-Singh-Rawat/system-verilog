module full_subtractor(

	input a,
	input b,
  	input bin,
	output y,
	output br
	);
  
   assign y = a ^ b ^ bin;
   assign br = (~a & b) | (~a & bin) | (b & bin);
  
endmodule


module half_sub_tb;
  reg a;
  reg b;
  reg bin;
  wire y; 
  wire br;
  
  full_subtractor dut(.a(a), .b(b), .bin(bin), .y(y), .br(br));
  
  
  initial begin
    
    a=0; b=0; bin=0; #10
    $display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);
    a=0; b=1; bin=0; #10
    $display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);
    a=1; b=0; bin=0; #10
    $display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);
    a=1; b=1; bin=0; #10
	$display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);    a=0; b=0; bin=1; #10
    $display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);
    a=0; b=1; bin=1; #10
    $display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);
    a=1; b=0; bin=1; #10
    $display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);
    a=1; b=1; bin=1; #10
    $display("a = %b, b = %b, bin = %b, y = %b, br = %b", a , b, bin , y, br);
    

  end
  
endmodule