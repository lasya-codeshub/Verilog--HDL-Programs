 Design and verification of 2 to 4 decoder and 3 to 8 decoders using Verilog HDL.

module decoder2x4(a, b, en, y);
  input a, b, en;
  output [3:0] y;
  wire a_bar, b_bar;
  not (a_bar, a);
  not (b_bar, b);
  and (y[0], a_bar, b_bar, en);
  and (y[1], a_bar, b, en);
  and (y[2], a, b_bar, en);
  and (y[3], a, b, en);
endmodule
module decoder3x8(a, b, c, en, y);
  input a, b, c, en;
  output [7:0] y;
  wire a_bar, b_bar, c_bar;
  not (a_bar, a);
  not (b_bar, b);
  not (c_bar, c);
  and (y[0], a_bar, b_bar, c_bar, en);
  and (y[1], a_bar, b_bar, c, en);
  and (y[2], a_bar, b, c_bar, en);
  and (y[3], a_bar, b, c, en);
  and (y[4], a, b_bar, c_bar, en);
  and (y[5], a, b_bar, c, en);
  and (y[6], a, b, c_bar, en);
  and (y[7], a, b, c, en);
endmodule

//Testbench

module tb_decoder;
  reg a, b, c, en;
  wire [7:0] y;
  decoder3x8 uut(a, b, c, en, y);
  initial begin
    en=1; {a,b,c}=0;
    repeat(8) begin
      #10 {a,b,c} = {a,b,c} + 1;
    end
  end
  initial $monitor("a=%b b=%b c=%b y=%b", a,b,c,y);
endmodule

//	Design and verification of 8 to 3 encoder using Verilog HDL.

module encoder8x3(d, y);
  input [7:0] d;
  output [2:0] y;
  or (y[0], d[1], d[3], d[5], d[7]);
  or (y[1], d[2], d[3], d[6], d[7]);
  or (y[2], d[4], d[5], d[6], d[7]);
endmodule
//Testbench
module tb_encoder;
  reg [7:0] d;
  wire [2:0] y;
  encoder8x3 uut(d, y);
  initial begin
    d=8'b00000001;
    repeat(8) begin
      #10 d = d << 1;
    end
  end
  initial $monitor("d=%b y=%b", d, y);
endmodule
