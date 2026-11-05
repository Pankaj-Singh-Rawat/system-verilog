module t_ff(
    input logic clk, rst_n, t,
    output logic q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else if (t) begin
            q <= ~q;
        end else begin
            q <= q
        end
    end
endmodule

