module half_subtractor(
    input logic a, b,
    output logic diff, borrow
);

    always_comb begin
        diff = a ^ b;
        borrow = ~a & b;
    end
endmodule
