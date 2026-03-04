//4.	Design and verification of 4-bit full adder using Verilog HDL.
//Verilog HDL Code
module full_adder_4bit(a, b, cin, sum, cout);
  input [3:0] a, b;
  input cin;
  output [3:0] sum;
  output cout;
  wire c1, c2, c3;
  full_adder fa0(a[0], b[0], cin, sum[0], c1);
  full_adder fa1(a[1], b[1], c1, sum[1], c2);
  full_adder fa2(a[2], b[2], c2, sum[2], c3);
  full_adder fa3(a[3], b[3], c3, sum[3], cout);
endmodule
//Testbench
module tb_full_adder_4bit;
  reg [3:0] a, b;
  reg cin;
  wire [3:0] sum;
  wire cout;
  full_adder_4bit uut(a, b, cin, sum, cout);
  initial begin
    a=4'b0101; b=4'b0011; cin=0;
    #10 a=4'b1111; b=4'b0001; cin=1;
    #10 a=4'b1001; b=4'b0101; cin=0;
  end
  initial $monitor("a=%b b=%b cin=%b sum=%b cout=%b", a,b,cin,sum,cout);
endmodule


//5.	Design and verification of 2x1 mux, 4x1 mux and 16x1 mux using Verilog HDL.
//Verilog HDL Code
module mux2x1(i0, i1, s, y);
  input i0, i1, s;
  output y;
  wire sbar, a1, a2;
  not (sbar, s);
  and (a1, i0, sbar);
  and (a2, i1, s);
  or  (y, a1, a2);
endmodule
module mux4x1(i, s, y);
  input [3:0] i;
  input [1:0] s;
  output y;
  wire [3:0] w;
  mux2x1 m1(i[0], i[1], s[0], w[0]);
  mux2x1 m2(i[2], i[3], s[0], w[1]);
  mux2x1 m3(w[0], w[1], s[1], y);
endmodule
module mux16x1(i, s, y);
  input [15:0] i;
  input [3:0] s;
  output y;
  wire [3:0] w;
  mux4x1 m1(i[3:0], s[1:0], w[0]);
  mux4x1 m2(i[7:4], s[1:0], w[1]);
  mux4x1 m3(i[11:8], s[1:0], w[2]);
  mux4x1 m4(i[15:12], s[1:0], w[3]);
  mux4x1 m5(w, s[3:2], y);
endmodule
//Testbench
module tb_mux;
  reg [15:0] i;
  reg [3:0] s;
  wire y;
  mux16x1 uut(i, s, y);
  initial begin
    i = 16'hA55A;
    s = 4'b0000;
    repeat(16) begin
      #10 s = s + 1;
    end
  end
  initial $monitor("s=%b y=%b", s, y);
endmodule
