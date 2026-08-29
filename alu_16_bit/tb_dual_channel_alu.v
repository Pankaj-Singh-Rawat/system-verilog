module tb_dual_channel_alu ();

  // Global Signals
  reg        clk;
  reg        rst_n;

  // Channel 0 Signals
  reg        ch0_en;
  reg  [2:0] ch0_opcode;
  reg        ch0_cin;
  reg  [15:0] ch0_a;
  reg  [15:0] ch0_b;
  wire [15:0] ch0_result;
  wire       ch0_carry;
  wire       ch0_zero;
  wire       ch0_overflow;

  // Channel 1 Signals
  reg        ch1_en;
  reg  [2:0] ch1_opcode;
  reg        ch1_cin;
  reg  [15:0] ch1_a;
  reg  [15:0] ch1_b;
  wire [15:0] ch1_result;
  wire       ch1_carry;
  wire       ch1_zero;
  wire       ch1_overflow;

  // Instantiate DUT
  dual_channel_power_gated_alu dut (
      .clk         (clk),
      .rst_n       (rst_n),
      .ch0_en      (ch0_en),
      .ch0_opcode  (ch0_opcode),
      .ch0_cin     (ch0_cin),
      .ch0_a       (ch0_a),
      .ch0_b       (ch0_b),
      .ch0_result  (ch0_result),
      .ch0_carry   (ch0_carry),
      .ch0_zero    (ch0_zero),
      .ch0_overflow(ch0_overflow),
      .ch1_en      (ch1_en),
      .ch1_opcode  (ch1_opcode),
      .ch1_cin     (ch1_cin),
      .ch1_a       (ch1_a),
      .ch1_b       (ch1_b),
      .ch1_result  (ch1_result),
      .ch1_carry   (ch1_carry),
      .ch1_zero    (ch1_zero),
      .ch1_overflow(ch1_overflow)
  );

  // Clock Generator (10 ns period)
  always #5 clk = ~clk;

  initial begin
    // Setup Waveform Dumping
    $dumpfile("dump.vcd");
    $dumpvars;

    // Initialize all inputs
    clk        = 0;
    rst_n      = 0;
    ch0_en     = 0;
    ch0_opcode = 3'b000;
    ch0_cin    = 0;
    ch0_a      = 16'h0000;
    ch0_b      = 16'h0000;

    ch1_en     = 0;
    ch1_opcode = 3'b000;
    ch1_cin    = 0;
    ch1_a      = 16'h0000;
    ch1_b      = 16'h0000;

    #12 rst_n = 1;  
    
    ch0_en     = 1;
    ch0_opcode = 3'b000;
    ch0_cin    = 1;
    ch0_a      = 16'h1000;
    ch0_b      = 16'h2000;

    ch1_en     = 1;
    ch1_opcode = 3'b010;
    ch1_cin    = 1;
    ch1_a      = 16'h0004;
    ch1_b      = 16'h0005;

    #20;  
    
    ch0_opcode = 3'b011;
    ch0_a      = 16'h0005;
    ch0_b      = 16'h0020;

    ch1_opcode = 3'b100;
    ch1_a      = 16'hABCD;
    ch1_b      = 16'hCDEF;

    #20;

    
    ch0_opcode = 3'b111;
    ch0_a      = 16'h0050;
    ch0_b      = 16'h0030;

    ch1_en     = 0;  // Power Gate Channel 1!
    ch1_opcode = 3'b000;
    ch1_a      = 16'hFFFF;
    ch1_b      = 16'hFFFF;

    #20;

    
    ch0_en = 0;

    #20;

    $finish;
  end

endmodule