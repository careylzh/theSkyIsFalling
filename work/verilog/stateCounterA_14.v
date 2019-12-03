/*
   This file was generated automatically by Alchitry Labs version 1.1.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module stateCounterA_14 (
    input clk,
    input rst,
    output reg out
  );
  
  
  
  reg [26:0] M_stateCounter_d, M_stateCounter_q = 1'h0;
  
  always @* begin
    M_stateCounter_d = M_stateCounter_q;
    
    out = M_stateCounter_q[26+0-:1];
    M_stateCounter_d = M_stateCounter_q + 1'h1;
    if (M_stateCounter_q[26+0-:1] == 1'h1) begin
      M_stateCounter_d[26+0-:1] = 1'h0;
    end
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_stateCounter_q <= 1'h0;
    end else begin
      M_stateCounter_q <= M_stateCounter_d;
    end
  end
  
endmodule
