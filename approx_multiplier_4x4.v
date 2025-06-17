`timescale 1ns / 1ps

module approx_full_adder(
input A, B, Cin,
output S, Cout);

assign S=A^B|Cin;
assign Cout=A&B|B&Cin;

endmodule
module half_adder(input A,B, output S,Cout);
assign S=A^B;
assign Cout=A&B;

endmodule
module compressor4_2(input p0, p1, p2, p3, output w2, w1);
    assign w2 = (p0^p1)|(p2^p3);
    assign w1 = (p0&p1)|(p2&p3);
endmodule

module approx_multiplier_4x4(
input [3:0] A,B,
output [7:0] result
    );
   
  wire [3:0] p0,p1,p2,p3;
  
    assign p0[0] = A[0]&B[0];
    assign p0[1] = A[0]&B[1];
    assign p0[2] = A[0]&B[2];
    assign p0[3] = A[0]&B[3];

    assign p1[0] = A[1]&B[0];
    assign p1[1] = A[1]&B[1];
    assign p1[2] = A[1]&B[2];
    assign p1[3] = A[1]&B[3];

    assign p2[0] = A[2]&B[0];
    assign p2[1] = A[2]&B[1];
    assign p2[2] = A[2]&B[2];
    assign p2[3] = A[2]&B[3];

    assign p3[0] = A[3]&B[0];
    assign p3[1] = A[3]&B[1];
    assign p3[2] = A[3]&B[2];
    assign p3[3] = A[3]&B[3];
    
    // dadda tree reduction and simplification
    assign result[0]=p0[0];
    assign result[1]=p0[1]^p1[0];
    // ignore this carry as the probability of it being 1 is really less (1/16) and it has significantly less chances of increasing relative error
    wire carry_1,sum_1,carry_2;
    approx_full_adder fa1(.A (p1[1]),.B (p2[0]),.Cin(p0[2]),.S (result[2]),.Cout (carry_1) );
    compressor4_2 c1(.p0 (p3[0]),.p1 (p0[3]),.p2 (p2[1]),.p3 (p1[2]),.w2 (sum_1),.w1 (carry_2) );
     wire carry_3,carry_4,carry_5;
    approx_full_adder fa3(.A (carry_1),.B (sum_1),.Cin(carry_2),.S (result[3]),.Cout (carry_3) );

    // to oompute result[4]
     compressor4_2 c2(.p0 (p3[1]),.p1 (p1[3]),.p2 (p2[2]),.p3 (carry_3),.w2 (result[4]),.w1 (carry_4) );
    approx_full_adder fa2(.A (p3[2]),.B (p2[3]),.Cin(carry_4),.S (result[5]),.Cout (carry_5) );
    half_adder ha1(.A (p3[3]),.B (carry_5),.S (result[6]),.Cout (result[7]));
      
endmodule


