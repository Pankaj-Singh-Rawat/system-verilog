module siso (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       si,
    output logic [3:0] q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;
        end else begin
            q <= {q[2:0], si}; 
        end
    end

endmodule