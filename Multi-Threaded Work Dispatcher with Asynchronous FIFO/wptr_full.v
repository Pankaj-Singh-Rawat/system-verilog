module wptr_full #(parameter ADDR_WIDTH = 4)(
  input wire wclk,
  input wire wrst_n,
  input wire winc,
  input wire[ADDR_WIDTH-1:0] rptr_gray_sync,
  output reg wfull,
  output wire [ADDR_WIDTH-1:0] waddr,
  output reg [ADDR_WIDTH:0] wptr_gray
);
  
  
  reg [ADDR_WIDTH:0] wptr_bin;
  wire [ADDR_WIDTH:] wptr_bin_next;
  wire [ADDR_WIDTH:] wptr_gray_next;
  wire wfull_val;
  
  assign wptr_bin_next = wptr_bin + (winc & ~wfull);
  assign wptr_gray_next = wptr_bin_next ^ (wptr_bin_next >> 1);
  
  assign waddr = wptr_bin[WIDTH_ADDR-1:0];
  assign wfull_val = (wptr_gray_next == {~rptr_gray_sync[ADDR_WIDTH : ADDR_WIDTH-1], rptr_gray_next[2:0]});
  
  
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) begin
      wptr_bin  <= {(ADDR_WIDTH+1){1'b0}};
      wptr_gray <= {(ADDR_WIDTH+1){1'b0}};
      wfull     <= 1'b0;
    end else begin
      wptr_bin  <= wptr_bin_next;
      wptr_gray <= wptr_gray_next;
      wfull     <= wfull_val;
    end
  end 
  
endmodule    
