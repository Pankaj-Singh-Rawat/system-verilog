module fsm_moore (
    input  wire clk,
    input  wire rst_n,
    input  wire din,
    output reg  match
);

  localparam IDLE  = 3'b000;
  localparam s1    = 3'b001;
  localparam s10   = 3'b010;
  localparam s101  = 3'b011;
  localparam s1011 = 3'b100;

  reg [2:0] current_state, next_state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) current_state <= IDLE;
    else        current_state <= next_state;
  end

  always @(*) begin
    case (current_state)
      IDLE:  next_state = din ? s1 : IDLE;
      s1:    next_state = din ? s1 : s10;
      s10:   next_state = din ? s101 : IDLE;
      s101:  next_state = din ? s1011 : s10;
      s1011: next_state = din ? s1 : s10;
      default: next_state = IDLE;
    endcase
  end

  always @(*) begin
    match = (current_state == s1011);
  end

endmodule


module fsm_mealy (
    input  wire clk,
    input  wire rst_n,
    input  wire din,
    output reg  match
);

  localparam IDLE = 2'b00;
  localparam s1   = 2'b01;
  localparam s10  = 2'b10;
  localparam s101 = 2'b11;

  reg [1:0] current_state, next_state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) current_state <= IDLE;
    else        current_state <= next_state;
  end

  always @(*) begin
    case (current_state)
      IDLE:    next_state = din ? s1 : IDLE;
      s1:      next_state = din ? s1 : s10;
      s10:     next_state = din ? s101 : IDLE;
      s101:    next_state = din ? s1 : s10;
      default: next_state = IDLE;
    endcase
  end

  always @(*) begin
    if (current_state == s101 && din == 1'b1) begin
      match = 1'b1;
    end else begin
      match = 1'b0;
    end
  end

endmodule


module tb_fsm_comparison ();

  reg  clk;
  reg  rst_n;
  reg  din;
  wire match_moore;
  wire match_mealy;

  fsm_moore u_moore (
      .clk  (clk),
      .rst_n(rst_n),
      .din  (din),
      .match(match_moore)
  );

  fsm_mealy u_mealy (
      .clk  (clk),
      .rst_n(rst_n),
      .din  (din),
      .match(match_mealy)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    clk   = 0;
    rst_n = 0;
    din   = 0;

    #12 rst_n = 1;

    @(posedge clk); din = 1'b1;
    @(posedge clk); din = 1'b0;
    @(posedge clk); din = 1'b1;
    @(posedge clk); din = 1'b1; // mealy shold trigger

    @(posedge clk); din = 1'b0; // moore should trigger here
    @(posedge clk); din = 1'b1;
    @(posedge clk); din = 1'b1; // overlapping

    @(posedge clk); din = 1'b0;
    #20;

    $finish;
  end

endmodule
