module counter_4bit(
    input logic clk,
    input logic rst_n,
    input logic en,
    output logic [3:0] q
);

    always_ff (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;
        end else if (en) begin
            q <= q + 4'b0001;
        end
    end

endmodule