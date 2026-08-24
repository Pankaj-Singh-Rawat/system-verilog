module and_gate(
    input a, 
    input b, 
    output y);

    assign y = a & b;
endmodule

module or_gate(input a, 
              input b,
               output y);
  
  or o1(y, a, b);
endmodule

module nor_gate(input a, 
              input b,
               output y);
  
  nor n1(y, a, b);
endmodule

module xor_gate(input a, 
              input b,
               output y);
  
  xor n1(y, a, b);
endmodule

module nand_gate(input a, 
              input b,
               output y);
  
  nand n1(y, a, b);
endmodule


module xnor_gate(input a, 
              input b,
               output y);
  
  xnor n1(y, a, b);
endmodule

module not_gate(input a, 
               output y);
  
  not n1(y,a);
endmodule

module buffer_gate(input a, 
                   output y);
  
  buf b1(y, a);
endmodule

  
module tristate_gates(input data, 
                      input enable,
                      output y1,
                     output y2,
                     output y3,
                     output y4);
    
  bufif1 t1(y1, data, enable);
  bufif0 t2(y2, data, enable);
  notif1 t3(y3, data, enable);
  notif0 t4(y4, data, enable);
endmodule
  
module cmos_switch(input data, 
                   input n_mos,
                   input p_mos,
                   output y);
  
  cmos c1(y, data, n_mos, p_mos);
endmodule


module tb_all_gates();
  reg a, b;
  reg n_mos, p_mos;
  reg data, enable;
  
  wire y_and, y_or, y_nor, y_xor, y_nand, y_xnor, y_not, y_buf;
  wire y_bufif1, y_bufif0, y_notif1, y_notif0;
  wire y_cmos;
  
  and_gate	   u_and	(.a(a), .b(b), .y(y_and));
  or_gate      u_or     (.a(a), .b(b), .y(y_or));
  nor_gate     u_nor    (.a(a), .b(b), .y(y_nor));
  xor_gate     u_xor    (.a(a), .b(b), .y(y_xor));
  nand_gate    u_nand   (.a(a), .b(b), .y(y_nand));
  xnor_gate    u_xnor   (.a(a), .b(b), .y(y_xnor));
  not_gate     u_not    (.a(a), .y(y_not));
  buffer_gate  u_buf    (.a(a), .y(y_buf));
  
  
  tristate_gates u_tristate (.data(data), .enable(enable), .y1(y_bufif1), .y2(y_bufif0), .y3(y_notif1), .y4(y_notif0));
  
  cmos_switch u_cmos (.data(data), .n_mos(n_mos), .p_mos(p_mos), .y(y_cmos));
                      
                      
initial begin

  $monitor("Time=%0t | a=%b b=%b data=%b en=%b | AND=%b OR=%b NOR=%b XOR=%b XNOR=%b NAND=%b NOT=%b BUF=%b | Tri(f1/f0/nf1/nf0)=%b/%b/%b/%b | CMOS=%b", 
             $time, a, b, data, enable, y_and, y_or, y_nor, y_xor, y_xnor, y_nand, y_not, y_buf, 
             y_bufif1, y_bufif0, y_notif1, y_notif0, y_cmos);
    a = 0; b = 0; data = 0; enable = 0; n_mos = 0; p_mos = 1;
    #10;
    
    a = 0; b = 1; data = 1; enable = 1; n_mos = 1; p_mos = 0;
    #10;

    a = 1; b = 0; data = 0; enable = 0; n_mos = 0; p_mos = 1;
    #10;

    a = 1; b = 1; data = 1; enable = 1; n_mos = 1; p_mos = 0;
    #10;

    $finish;
  end

endmodule