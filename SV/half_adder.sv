module half_adder(
  input logic a, b,
  output logic sum, carry
);
  
  always_comb begin
    {carry, sum} = a + b;
  end
endmodule