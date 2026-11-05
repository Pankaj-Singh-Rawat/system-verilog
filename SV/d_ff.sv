module d_ff(
    input logic rst_n, clk, d,
    output logic q
);

    always_ff @(posedge clk or rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule