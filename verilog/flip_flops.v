`timescale 1ns / 1ps

module d_ff (
    input wire d,
    input wire clk,
    input wire rst_n,
    output reg q
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end
endmodule


module sr_ff (
    input wire s,
    input wire r,
    input wire clk,
    input wire rst_n,
    output reg q
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;
    end else begin
      case ({s, r})
        2'b01:   q <= 1'b0;
        2'b10:   q <= 1'b1;
        2'b11:   q <= 1'bx;
        default: q <= q;
      endcase
    end
  end
endmodule


module jk_ff (
    input wire j,
    input wire k,
    input wire clk,
    input wire rst_n,
    output reg q
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;
    end else begin
      case ({j, k})
        2'b01:   q <= 1'b0;
        2'b10:   q <= 1'b1;
        2'b11:   q <= ~q;
        default: q <= q;
      endcase
    end
  end
endmodule


module t_ff (
    input wire t,
    input wire clk,
    input wire rst_n,
    output reg q
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;
    end else if (t) begin
      q <= ~q;
    end
  end
endmodule


module tb_flip_flops;

  reg clk;
  reg rst_n;
  reg d;
  reg s, r;
  reg j, k;
  reg t;

  wire q_d;
  wire q_sr;
  wire q_jk;
  wire q_t;

  d_ff u_d_ff (
      .d(d),
      .clk(clk),
      .rst_n(rst_n),
      .q(q_d)
  );

  sr_ff u_sr_ff (
      .s(s),
      .r(r),
      .clk(clk),
      .rst_n(rst_n),
      .q(q_sr)
  );

  jk_ff u_jk_ff (
      .j(j),
      .k(k),
      .clk(clk),
      .rst_n(rst_n),
      .q(q_jk)
  );

  t_ff u_t_ff (
      .t(t),
      .clk(clk),
      .rst_n(rst_n),
      .q(q_t)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("flip_flops.vcd");
    $dumpvars(0, tb_flip_flops);

    $monitor("Time=%0t ns | clk=%b rst_n=%b | D=%b Q_d=%b | S=%b R=%b Q_sr=%b | J=%b K=%b Q_jk=%b | T=%b Q_t=%b",
             $time, clk, rst_n, d, q_d, s, r, q_sr, j, k, q_jk, t, q_t);

    clk   = 0;
    rst_n = 0;
    d     = 0;
    s     = 0; r = 0;
    j     = 0; k = 0;
    t     = 0;

    #12;
    rst_n = 1;
    #8;

    d = 1; s = 1; r = 0; j = 1; k = 0; t = 1;
    #10;

    d = 0; s = 0; r = 1; j = 0; k = 1; t = 0;
    #10;

    s = 0; r = 0; j = 1; k = 1; t = 1;
    #10;
    #10;

    s = 1; r = 1; j = 0; k = 0; t = 0;
    #10;

    d = 1; s = 1; r = 0; j = 1; k = 0;
    #10;
    #4;
    rst_n = 0;
    #6;
    rst_n = 1;
    #10;

    $finish;
  end

endmodule