module full_adder(
  input logic a, b, cin,
  output logic sum, carry
	
);
  
  always_comb begin
    {carry, sum} = a + b + cin;
  end
endmodule