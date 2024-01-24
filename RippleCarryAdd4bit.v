
//code
module HalfAdder(a1,b1,sum,carry);
  input a1,b1;
  output sum,carry;
  xor xor1(sum,a1,b1);
  and and1(carry,a1,b1);
endmodule

module FullAdder(a,b,cin,sumfa,cout);
  wire s1,c1,c2;
  input a,b,cin;
  output sumfa,cout;
  
  HalfAdder hf1(a,b,s1,c1);
  HalfAdder hf2(s1,cin,sumfa,c2);
  or or1(cout,c1,c2);
endmodule

module RippleCarryAdder(a2, b2, sum2);
  input [3:0] a2, b2;
  output [4:0] sum2;

  wire [2:0] c;
  FullAdder fa0(a2[0], b2[0], 1'b0, sum2[0], c[0]);
  FullAdder fa1(a2[1], b2[1], c[0], sum2[1], c[1]);
  FullAdder fa2(a2[2], b2[2], c[1], sum2[2], c[2]);
  FullAdder fa3(a2[3], b2[3], c[2], sum2[3], sum2[4]);
endmodule

// testbench
//module testbench();
  reg [3:0] a2;
  reg [3:0] b2;
  wire [4:0] sum2;
  
  RippleCarryAdder dut(.a2(a2), .b2(b2) , .sum2(sum2));
  
  initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0,testbench);
    
    a2 = 4'b0110;b2 = 4'b0011;
    #10
    a2 = 4'b0100;b2 = 4'b1011;
    #10
    a2 = 4'b1110;b2 = 4'b1111;
    $finish();
  end
endmodule
