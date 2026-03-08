//	Design and verification a SR latch using Verilog HDL.

module sr_latch(S, R, Q, Qbar);
  input S, R;
  output Q, Qbar;
  nor (Q, R, Qbar);
  nor (Qbar, S, Q);
endmodule

//Testbench

module tb_sr_latch;
  reg S, R;
  wire Q, Qbar;
  sr_latch uut(S, R, Q, Qbar);
  initial begin
    $monitor("S=%b R=%b Q=%b Qbar=%b", S, R, Q, Qbar);
    S=0; R=0;
    #10 S=1; R=0;
    #10 S=0; R=1;
    #10 S=1; R=1;
  end
endmodule

//Design and verification a SR flip-flop using HDL.

module sr_ff(S, R, clk, Q, Qbar);
  input S, R, clk;
  output reg Q, Qbar;
  always @(posedge clk)
  begin
    if(S && !R)
      Q <= 1;
    else if(!S && R)
      Q <= 0;
    else if(S && R)
      Q <= 1'bx;
    Qbar <= ~Q;
  end
endmodule

//Testbench

module tb_sr_ff;
  reg S, R, clk;
  wire Q, Qbar;
  sr_ff uut(S, R, clk, Q, Qbar);
  always #5 clk = ~clk;
  initial begin
    clk=0; S=0; R=0;
    #10 S=1; R=0;
    #10 S=0; R=1;
    #10 S=1; R=1;
    #10 S=0; R=0;
    #10 $finish;
  end
  initial $monitor("S=%b R=%b Q=%b Qbar=%b", S, R, Q, Qbar);
endmodule


