module icg_cell(
	input wire clk,
	input wire enable,
	output wire gated_clk);
  
  reg latch_en;
  
  always @(clk or enable) begin
    if (!clk) latch_en <= enable;
  end
  
  assgn gated_clk = clk & latch_en;
  
endmodule