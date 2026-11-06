module universal_shift_register(
	input logic clk,
	input logic rst_n,
	input logic [1:0] ctrl,
	input logic [3:0] d,
	input logic sli,
	input logic slr,
	output logic [3:0] q	
);

	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			q <= 4'b0000;
		end else begin
			case (ctrl)
				2'b00: q <= q;

				2'b01: q <= {slr, q[3:1]};

				2'b10: q <= {q[2:0], sli};

				2'b11: q <= d;
			endcase
		end
	end
endmodule