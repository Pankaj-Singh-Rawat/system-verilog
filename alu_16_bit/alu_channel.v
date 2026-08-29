module alu_channel_advanced (
    input wire clk,
    input wire rst_n,
    input wire [2:0] opcode, 
    input wire cin, 
    input wire [15:0] a,
    input wire [15:0] b,
    output reg [15:0] result,
    output reg carry_flag,
    output reg zero_flag,
    output reg overflow_flag
);

// Operand Pipeline Registers
  reg [15:0] a_s1, b_s1;
  reg [2:0] opcode_s1;
  reg cin_s1;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      a_s1      <= 16'h0000;
      b_s1      <= 16'h0000;
      opcode_s1 <= 3'b000;
      cin_s1    <= 1'b0;
    end else begin
      a_s1      <= a;
      b_s1      <= b;
      opcode_s1 <= opcode;
      cin_s1    <= cin;
    end
  end

// Combinational Execution 
  reg [16:0] alu_raw;
  reg ovf_temp;

  always @(*) begin
    alu_raw  = 17'h00000;
    ovf_temp = 1'b0;

    case (opcode_s1)
      
      3'b000: begin
        alu_raw = a_s1 + b_s1 + cin_s1;
        ovf_temp = (a_s1[15] == b_s1[15]) && (alu_raw[15] != a_s1[15]);
      end

      3'b001: begin
        alu_raw = a_s1 - b_s1 - cin_s1;
        ovf_temp = (a_s1[15] != b_s1[15]) && (alu_raw[15] != a_s1[15]);
      end

 
      3'b010: begin
        alu_raw[15:0] = (a_s1 * b_s1) + cin_s1;
      end

      
      3'b011: begin
        if (a_s1 >= b_s1) alu_raw[15:0] = a_s1 - b_s1;
        else alu_raw[15:0] = b_s1 - a_s1;
      end


      3'b100: begin
        alu_raw[15:0] = {b_s1[7:0], a_s1[15:8]};
      end


      3'b101: begin
        alu_raw[15:0] = $signed(a_s1) >>> b_s1[3:0];
      end


      3'b110: begin
        alu_raw[15:0] = (a_s1 & ~b_s1) | {15'b0, cin_s1};
      end


      3'b111: begin
        alu_raw[15:0] = (a_s1 <= b_s1) ? a_s1 : b_s1;
      end

      default: alu_raw = 17'h00000;
    endcase
  end

// Pipeline Output
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result        <= 16'h0000;
      carry_flag    <= 1'b0;
      zero_flag     <= 1'b0;
      overflow_flag <= 1'b0;
    end else begin
      result        <= alu_raw[15:0];
      carry_flag    <= alu_raw[16];
      zero_flag     <= (alu_raw[15:0] == 16'h0000);
      overflow_flag <= ovf_temp;
    end
  end

endmodule