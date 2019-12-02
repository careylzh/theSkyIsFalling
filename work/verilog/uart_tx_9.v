/*
   This file was generated automatically by Alchitry Labs version 1.1.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     CLK_FREQ = CLK_FREQ
     BAUD = BAUD
*/
module uart_tx_9 (
    input clk,
    input rst,
    output reg tx,
    input block,
    output reg busy,
    input [7:0] data,
    input new_data
  );
  
  localparam CLK_FREQ = 26'h2faf080;
  localparam BAUD = 19'h7a120;
  
  
  localparam CLK_PER_BIT = 28'h0000064;
  
  localparam CTR_SIZE = 3'h7;
  
  localparam IDLE_state = 2'd0;
  localparam START_BIT_state = 2'd1;
  localparam DATA_state = 2'd2;
  localparam STOP_BIT_state = 2'd3;
  
  reg [1:0] M_state_d, M_state_q = IDLE_state;
  reg [6:0] M_ctr_d, M_ctr_q = 1'h0;
  reg [2:0] M_bitCtr_d, M_bitCtr_q = 1'h0;
  reg [7:0] M_savedData_d, M_savedData_q = 1'h0;
  reg M_txReg_d, M_txReg_q = 1'h0;
  reg M_blockFlag_d, M_blockFlag_q = 1'h0;
  
  always @* begin
    M_state_d = M_state_q;
    M_ctr_d = M_ctr_q;
    M_blockFlag_d = M_blockFlag_q;
    M_txReg_d = M_txReg_q;
    M_savedData_d = M_savedData_q;
    M_bitCtr_d = M_bitCtr_q;
    
    tx = M_txReg_q;
    busy = 1'h1;
    M_blockFlag_d = block;
    
    case (M_state_q)
      IDLE_state: begin
        M_txReg_d = 1'h1;
        if (!M_blockFlag_q) begin
          busy = 1'h0;
          M_bitCtr_d = 1'h0;
          M_ctr_d = 1'h0;
          if (new_data) begin
            M_savedData_d = data;
            M_state_d = START_BIT_state;
          end
        end
      end
      START_BIT_state: begin
        M_ctr_d = M_ctr_q + 1'h1;
        M_txReg_d = 1'h0;
        if (M_ctr_q == 29'h00000063) begin
          M_ctr_d = 1'h0;
          M_state_d = DATA_state;
        end
      end
      DATA_state: begin
        M_txReg_d = M_savedData_q[(M_bitCtr_q)*1+0-:1];
        M_ctr_d = M_ctr_q + 1'h1;
        if (M_ctr_q == 29'h00000063) begin
          M_ctr_d = 1'h0;
          M_bitCtr_d = M_bitCtr_q + 1'h1;
          if (M_bitCtr_q == 3'h7) begin
            M_state_d = STOP_BIT_state;
          end
        end
      end
      STOP_BIT_state: begin
        M_txReg_d = 1'h1;
        M_ctr_d = M_ctr_q + 1'h1;
        if (M_ctr_q == 29'h00000063) begin
          M_state_d = IDLE_state;
        end
      end
      default: begin
        M_state_d = IDLE_state;
      end
    endcase
  end
  
  always @(posedge clk) begin
    M_ctr_q <= M_ctr_d;
    M_bitCtr_q <= M_bitCtr_d;
    M_savedData_q <= M_savedData_d;
    M_txReg_q <= M_txReg_d;
    M_blockFlag_q <= M_blockFlag_d;
    
    if (rst == 1'b1) begin
      M_state_q <= 1'h0;
    end else begin
      M_state_q <= M_state_d;
    end
  end
  
endmodule
