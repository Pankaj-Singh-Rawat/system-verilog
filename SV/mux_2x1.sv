module mux_2x1(
    input logic a, b, s,
    output logic y
);

    always_comb begin
        y = (~s & a) | (s & b);
    end
endmodule
