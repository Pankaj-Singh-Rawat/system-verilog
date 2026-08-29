module dual_channel_power_gated_alu (
    input wire clk,
    input wire rst_n,

    // --- Channel 0 Interface ---
    input  wire        ch0_en,
    input  wire [ 2:0] ch0_opcode,
    input  wire        ch0_cin,
    input  wire [15:0] ch0_a,
    input  wire [15:0] ch0_b,
    output wire [15:0] ch0_result,
    output wire        ch0_carry,
    output wire        ch0_zero,
    output wire        ch0_overflow,

    // --- Channel 1 Interface ---
    input  wire        ch1_en,
    input  wire [ 2:0] ch1_opcode,
    input  wire        ch1_cin,
    input  wire [15:0] ch1_a,
    input  wire [15:0] ch1_b,
    output wire [15:0] ch1_result,
    output wire        ch1_carry,
    output wire        ch1_zero,
    output wire        ch1_overflow
);

  // Internal Gated Clocks & Unisolated Flags
  wire        clk_ch0, clk_ch1;
  wire [15:0] raw_res_ch0, raw_res_ch1;
  wire        raw_c_ch0, raw_c_ch1;
  wire        raw_z_ch0, raw_z_ch1;
  wire        raw_v_ch0, raw_v_ch1;

  
  icg_cell icg_0 (
      .clk      (clk),
      .enable   (ch0_en),
      .gated_clk(clk_ch0)
  );

  alu_channel_advanced alu_ch0 (
      .clk          (clk_ch0),
      .rst_n        (rst_n),
      .opcode       (ch0_opcode),
      .cin          (ch0_cin),
      .a            (ch0_a),
      .b            (ch0_b),
      .result       (raw_res_ch0),
      .carry_flag   (raw_c_ch0),
      .zero_flag    (raw_z_ch0),
      .overflow_flag(raw_v_ch0)
  );

  
  assign ch0_result   = ch0_en ? raw_res_ch0 : 16'h0000;
  assign ch0_carry    = ch0_en ? raw_c_ch0 : 1'b0;
  assign ch0_zero     = ch0_en ? raw_z_ch0 : 1'b0;
  assign ch0_overflow = ch0_en ? raw_v_ch0 : 1'b0;


  icg_cell icg_1 (
      .clk      (clk),
      .enable   (ch1_en),
      .gated_clk(clk_ch1)
  );

  alu_channel_advanced alu_ch1 (
      .clk          (clk_ch1),
      .rst_n        (rst_n),
      .opcode       (ch1_opcode),
      .cin          (ch1_cin),
      .a            (ch1_a),
      .b            (ch1_b),
      .result       (raw_res_ch1),
      .carry_flag   (raw_c_ch1),
      .zero_flag    (raw_z_ch1),
      .overflow_flag(raw_v_ch1)
  );


  assign ch1_result   = ch1_en ? raw_res_ch1 : 16'h0000;
  assign ch1_carry    = ch1_en ? raw_c_ch1 : 1'b0;
  assign ch1_zero     = ch1_en ? raw_z_ch1 : 1'b0;
  assign ch1_overflow = ch1_en ? raw_v_ch1 : 1'b0;
  
endmodule