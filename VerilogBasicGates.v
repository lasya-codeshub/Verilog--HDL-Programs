/1. Design and verification of Logic gates using verilog HDL
//Verilog HDL Code

module logic_gates(a, b, and_out, or_out, not_a, nand_out, nor_out, xor_out, xnor_out);
  input a, b;
  output and_out, or_out, not_a, nand_out, nor_out, xor_out, xnor_out;

  and  (and_out, a, b);
  or   (or_out, a, b);
  not  (not_a, a);
  nand (nand_out, a, b);
  nor  (nor_out, a, b);
  xor  (xor_out, a, b);
  xnor (xnor_out, a, b);
endmodule
//Testbench Code
module tb_logic_gates;
  reg a, b;
  wire and_out, or_out, not_a, nand_out, nor_out, xor_out, xnor_out;

  logic_gates uut(a, b, and_out, or_out, not_a, nand_out, nor_out, xor_out, xnor_out);

  initial begin
    $monitor("a=%b b=%b | AND=%b OR=%b NOT=%b NAND=%b NOR=%b XOR=%b XNOR=%b",
              a, b, and_out, or_out, not_a, nand_out, nor_out, xor_out, xnor_out);
    a=0; b=0;
    #10 a=0; b=1;
    #10 a=1; b=0;
    #10 a=1; b=1;
  end
endmodule
