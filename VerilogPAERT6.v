// Design and verification of D flip flop using Verilog HDL

module d_flipflop (
    input D,
    input CLK,
    input RESET,
    output reg Q
);
  always @(posedge CLK or posedge RESET)
  begin
    if (RESET)
      Q <= 1'b0;         
    else
      Q <= D;            
  end
endmodule

//Testbench

module tb_d_flipflop;
  reg D, CLK, RESET;
  wire Q;
d_flipflop uut (D, CLK, RESET, Q);
  always #5 CLK = ~CLK;
 initial begin
   CLK = 0; RESET = 1; D = 0;
    #10 RESET = 0;
    #10 D = 1;
    #10 D = 0;
    #10 D = 1;
    #10 RESET = 1;
    #10 RESET = 0;
    #10 D = 0;
    #20 $finish;
  end
 initial begin
    $monitor("Time=%0t | CLK=%b | RESET=%b | D=%b | Q=%b", $time, CLK, RESET, D, Q);
  end
endmodule

// Design and verification of JK flip flop using Verilog HDL

module jk_flipflop (
    input J,
    input K,
    input CLK,
    input RESET,
    output reg Q
);
  always @(posedge CLK or posedge RESET)
  begin
    if (RESET)
      Q <= 1'b0;                   // Asynchronous reset
    else begin
      case ({J, K})
        2'b00: Q <= Q;             // No change
        2'b01: Q <= 1'b0;          // Reset
        2'b10: Q <= 1'b1;          // Set
        2'b11: Q <= ~Q;            // Toggle
      endcase
    end
  end
endmodule

//Testbench

module tb_jk_flipflop;
  reg J, K, CLK, RESET;
  wire Q;

  jk_flipflop uut (J, K, CLK, RESET, Q);
  always #5 CLK = ~CLK;
  initial begin
    // Initialize signals
    CLK = 0; RESET = 1; J = 0; K = 0;
    #10 RESET = 0;

    // Apply test vectors
    #10 J=0; K=0;   // No change
    #10 J=0; K=1;   // Reset
    #10 J=1; K=0;   // Set
    #10 J=1; K=1;   // Toggle
    #10 J=0; K=0;   // Hold
    #10 RESET = 1;  // Reset again
    #10 RESET = 0; J=1; K=1;
    #20 $finish;
  end

  initial begin
    $monitor("Time=%0t | CLK=%b | RESET=%b | J=%b | K=%b | Q=%b", 
              $time, CLK, RESET, J, K, Q);
  end
endmodule

