//2.	Design and verification of half adder and full adder using Verilog HDL.
//Verilog HDL Code
module half_adder(a, b, sum, carry);
  input a, b;
  output sum, carry;
  xor (sum, a, b);
  and (carry, a, b);
endmodule
module full_adder(a, b, cin, sum, carry);
  input a, b, cin;
  output sum, carry;
  wire s1, c1, c2;
  xor (s1, a, b);
  xor (sum, s1, cin);
  and (c1, a, b);
  and (c2, s1, cin);
  or  (carry, c1, c2);
endmodule
//Testbench
module tb_adder;
  reg a, b, cin;
  wire sum1, carry1, sum2, carry2;

  half_adder ha(a, b, sum1, carry1);
  full_adder fa(a, b, cin, sum2, carry2);

  initial begin
    $monitor("a=%b b=%b cin=%b | HA: sum=%b carry=%b | FA: sum=%b carry=%b",
              a, b, cin, sum1, carry1, sum2, carry2);
    a=0; b=0; cin=0;
    #10 a=0; b=1; cin=0;
    #10 a=1; b=0; cin=1;
    #10 a=1; b=1; cin=1;
  end
endmodule

//3.	Design and verification of half subtractor and full subtractor using Verilog HDL.
//Verilog HDL Code
module half_subtractor(a, b, diff, borrow);
  input a, b;
  output diff, borrow;
  xor (diff, a, b);
  and (borrow, ~a, b);
endmodule

module full_subtractor(a, b, bin, diff, bout);
  input a, b, bin;
  output diff, bout;
  wire d1, b1, b2;
  xor (d1, a, b);
  xor (diff, d1, bin);
  and (b1, ~a, b);
  and (b2, ~d1, bin);
  or  (bout, b1, b2);
endmodule
//Testbench

module tb_subtractor;
  reg a, b, bin;
  wire diff1, borrow1, diff2, bout2;

  half_subtractor hs(a, b, diff1, borrow1);
  full_subtractor fs(a, b, bin, diff2, bout2);

  initial begin
    $monitor("a=%b b=%b bin=%b | HS: diff=%b borrow=%b | FS: diff=%b bout=%b",
              a, b, bin, diff1, borrow1, diff2, bout2);
    a=0; b=0; bin=0;
    #10 a=0; b=1; bin=0;
    #10 a=1; b=0; bin=1;
    #10 a=1; b=1; bin=1;
  end
endmodule
