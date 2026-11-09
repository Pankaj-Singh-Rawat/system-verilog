module moore_fsm(
    input logic clk,
    input logic rst_n,
    input logic in_bit,
    output logic detected
);


    typedef enum logic [1:0] {
        IDLE = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10,
        S11 = 2'b11
    } state_t;

    state_t current_state, next_state;


    
    always_ff @(posedge clk or negedge rst_n) begin

        if (!rst_n) current_state <= IDLE;
        else current_state <= next_state;

    end

    always_comb begin
        next_state = current_state;

        case (current_state)
        IDLE : next_state = in_bit? S1: IDLE;
        S1: next_state = in_bit? S1: S10;
        S10: next_state = in_bit? S101: IDLE;
        S101: next_state = in_bit? S1: S10;
        default: next_state = IDLE;
        endcase
    end

    assign detected = (current_state == S101);

endmodule