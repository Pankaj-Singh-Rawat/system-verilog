  
module binary2gray #(parameter length = 5)(
  input wire [WIDTH-1:0] bin,
  output reg [WIDTH-1:0] gray
);  
  
  assign gray <= bin ^ (bin >> 1);
  
endmodule

