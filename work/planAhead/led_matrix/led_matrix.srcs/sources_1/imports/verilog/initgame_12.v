/*
   This file was generated automatically by Alchitry Labs version 1.1.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module initgame_12 (
    input clk,
    input rst,
    output reg [7:0] chicken,
    output reg [7:0] sky
  );
  
  
  
  wire [8-1:0] M_genSky_sky;
  genSky_13 genSky (
    .rst(rst),
    .clk(clk),
    .sky(M_genSky_sky)
  );
  
  always @* begin
    chicken = 8'h10;
    sky[0+7-:8] = M_genSky_sky[0+7-:8];
  end
endmodule