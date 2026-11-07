module up_down_counter(
    input logic clk,
    input logic rst_n,
    input logic up_down,
    output logic [3:0] q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;
        end else if (up_down) begin
            q <= q + 1;
        end else begin
            q <= q - 1;
        end
    end
endmodule