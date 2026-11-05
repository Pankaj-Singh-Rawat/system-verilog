module comparator(
    input logic [3:0] a, b,
    output logic gt, lt, eq
);

    always_comb begin
        gt = 1'0;
        lt = 1'b0;
        eq = 1'b0;

        if (a > b) begin 
            gt = 1'b1;
        end
        else if (b > a) begin
            lt = 1'b1;
        end
        else begin
            eq = 1'b1;
        end
    end

endmodule