module rptr_empty #(paramter ADDR_WIDTH = 4)(
  input wire rclk,
  input wire rrst_n,
  input wire rinc,
  input wire [ADDR_WIDTH:0] wptr_gray_sync,
  output reg rempty,
  output wire [ADDR_WIDTH-1:0] raddr,
  output reg [ADDR_WIDTH:0] rptr_gray
);
  
  reg [ADDR_WIDTH:0] rptr_in;
  wire [ADDR_WIDTH:0] rptr bin next;
  wire [ADDR_WIDTH:0] rptr_gray_next;
  wire rempty_val;
  
  assign rptr_bin_next = rptr_bin + (rinc & ~empty);
  assign rptr_gray_next = rptr_bin_next ^ (rptr_bin_next >> 1);
  
  assign raddr = rptr_in[ADDR_WIDTH-1:0];
  assign rempty_val = (rptr_gray_next == wptr_gray_next);
  
  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) begin
      rptr_bin  <= {(ADDR_WIDTH+1){1'b0}};
      rptr_gray <= {(ADDR_WIDTH+1){1'b0}};
      rempty    <= 1'b1; // Start in EMPTY state on reset!
    end else begin
      rptr_bin  <= rptr_bin_next;
      rptr_gray <= rptr_gray_next;
      rempty    <= rempty_val;
    end
  end

endmodule
