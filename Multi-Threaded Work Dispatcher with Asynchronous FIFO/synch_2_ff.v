
module synch_2_ff(
  input wire clk,
  input wire rst_n,
  input wire [WIDTH-1:0] async_in, // WIDTH -> scalable
  output reg [WIDTH-1:0] sync_out
);
  
  reg [WIDTH-1:0] sync_m;
  
  always @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
      sync_m <= {WIDTH{1'b0}};
      sync_out <= {WIDTH{1'b0}}; 
    end else begin
      sync_m <= async_in; // captures async signal
      sync_out <= sync_m; // removes metastability
    end
  end
endmodule

        
      
