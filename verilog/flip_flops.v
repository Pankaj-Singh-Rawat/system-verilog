
module d_ff(
    input wire d,
    input wire clk,
    input wire rst,
    output reg q
);
  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end 
  end
endmodule


module sr_ff(
    input wire s, 
    input wire r,
    input wire clk,
    input wire rst,
    output reg q
);
  always @(posedge clk) begin
    if (rst) begin
      q <= 1'b0;
    end else begin
      case ({s,r})
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= 1'bx;
        default: q <= 1'b0; 
      endcase
    end
  end
endmodule


module jk_ff(
    input wire j,
    input wire k, 
    input wire clk,
    input wire rst,
    output reg q 
  always @(posedge clk) begin
    if (rst) begin 
      q <= 1'b0;
    end else begin
      case ({j,k}) 
        2'b00: q <= q; 
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= ~q;
        default: q <= 1'b0;
      endcase
    end
  end
endmodule


module t_ff(
    input wire t,
    input wire clk,
    input wire rst,
    output reg q
);
  always @(posedge clk or negedge rst) begin 
    if (!rst) begin
      q <= 1'b0;
    end else begin
      if (t) begin
        q <= ~q; 
      end else begin 
        q <= q;  
      end 
    end
  end
endmodule