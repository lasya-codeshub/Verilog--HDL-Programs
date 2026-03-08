// Design and verification up counter and down counter using Verilog HDL.


module up_counter(clk, rst, count);
  input clk, rst;
  output reg [3:0] count;
  always @(posedge clk or posedge rst)
    if(rst)
      count <= 0;
    else
      count <= count + 1;
endmodule
module down_counter(clk, rst, count);
  input clk, rst;
  output reg [3:0] count;
  always @(posedge clk or posedge rst)
    if(rst)
      count <= 4'b1111;
    else
      count <= count - 1;
endmodule

//Testbench

module tb_counters;
  reg clk, rst;
  wire [3:0] up, down;

  up_counter uc(clk, rst, up);
  down_counter dc(clk, rst, down);

  always #5 clk = ~clk;

  initial begin
    clk=0; rst=1;
    #10 rst=0;
    #100 $finish;
  end

  initial $monitor("Time=%0t | Up=%b | Down=%b", $time, up, down);
endmodule
