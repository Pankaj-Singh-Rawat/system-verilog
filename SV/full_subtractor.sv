module full_subtractor(
    input logic a, b, bin,
    output logic diff, bout
);

    always_comb begin
        // if I pad a upto 2 bits the follwing bits like b and bin widens automatically
        {bout, diff} = {1'b00, a} - b - bin;
    end

endmodule