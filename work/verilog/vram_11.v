/*
   This file was generated automatically by Alchitry Labs version 1.1.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module vram_11 (
    input clk,
    input rst,
    input [9:0] read_addr,
    input write_en,
    input [2:0] write_data,
    input [9:0] write_addr,
    output reg [2:0] out_bit
  );
  
  
  
  wire [3-1:0] M_disp_vram_read_data;
  reg [10-1:0] M_disp_vram_raddr;
  simple_dual_ram_12 #(.SIZE(2'h3), .DEPTH(11'h400)) disp_vram (
    .rclk(clk),
    .wclk(clk),
    .write_en(write_en),
    .waddr(write_addr),
    .write_data(write_data),
    .raddr(M_disp_vram_raddr),
    .read_data(M_disp_vram_read_data)
  );
  
  reg M_write_d, M_write_q = 1'h0;
  reg [11:0] M_i_d, M_i_q = 1'h0;
  
  always @* begin
    M_disp_vram_raddr = read_addr;
    out_bit = M_disp_vram_read_data;
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_write_q <= 1'h0;
      M_i_q <= 1'h0;
    end else begin
      M_write_q <= M_write_d;
      M_i_q <= M_i_d;
    end
  end
  
endmodule