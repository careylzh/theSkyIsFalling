/*
   This file was generated automatically by Alchitry Labs version 1.1.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     CLK_FREQ = 50000000
*/
module reg_interface_3 (
    input clk,
    input rst,
    input [7:0] rx_data,
    input new_rx_data,
    output reg [7:0] tx_data,
    output reg new_tx_data,
    input tx_busy,
    output reg [65:0] regOut,
    input [32:0] regIn
  );
  
  localparam CLK_FREQ = 26'h2faf080;
  
  
  localparam IDLE_state = 3'd0;
  localparam GET_ADDR_state = 3'd1;
  localparam WRITE_state = 3'd2;
  localparam REQUEST_WRITE_state = 3'd3;
  localparam REQUEST_READ_state = 3'd4;
  localparam WAIT_READ_state = 3'd5;
  localparam READ_RESULT_state = 3'd6;
  
  reg [2:0] M_state_d, M_state_q = IDLE_state;
  reg [5:0] M_addr_ct_d, M_addr_ct_q = 1'h0;
  reg [1:0] M_byte_ct_d, M_byte_ct_q = 1'h0;
  reg M_inc_d, M_inc_q = 1'h0;
  reg M_wr_d, M_wr_q = 1'h0;
  reg [23:0] M_timeout_d, M_timeout_q = 1'h0;
  reg [31:0] M_addr_d, M_addr_q = 1'h0;
  reg [31:0] M_data_d, M_data_q = 1'h0;
  
  always @* begin
    M_state_d = M_state_q;
    M_data_d = M_data_q;
    M_byte_ct_d = M_byte_ct_q;
    M_addr_ct_d = M_addr_ct_q;
    M_wr_d = M_wr_q;
    M_addr_d = M_addr_q;
    M_timeout_d = M_timeout_q;
    M_inc_d = M_inc_q;
    
    regOut[0+0-:1] = 1'h0;
    regOut[1+0-:1] = 1'bx;
    regOut[2+31-:32] = M_addr_q;
    regOut[34+31-:32] = M_data_q;
    tx_data = 1'bx;
    new_tx_data = 1'h0;
    M_timeout_d = M_timeout_q + 1'h1;
    if (new_rx_data) begin
      M_timeout_d = 1'h0;
    end
    
    case (M_state_q)
      IDLE_state: begin
        M_timeout_d = 1'h0;
        M_byte_ct_d = 1'h0;
        if (new_rx_data) begin
          M_wr_d = rx_data[7+0-:1];
          M_inc_d = rx_data[6+0-:1];
          M_addr_ct_d = rx_data[0+5-:6];
          M_state_d = GET_ADDR_state;
        end
      end
      GET_ADDR_state: begin
        if (new_rx_data) begin
          M_addr_d = {rx_data, M_addr_q[8+23-:24]};
          M_byte_ct_d = M_byte_ct_q + 1'h1;
          if (M_byte_ct_q == 2'h3) begin
            if (M_wr_q) begin
              M_state_d = WRITE_state;
            end else begin
              M_state_d = REQUEST_READ_state;
            end
          end
        end
      end
      WRITE_state: begin
        if (new_rx_data) begin
          M_data_d = {rx_data, M_data_q[8+23-:24]};
          M_byte_ct_d = M_byte_ct_q + 1'h1;
          if (M_byte_ct_q == 2'h3) begin
            M_state_d = REQUEST_WRITE_state;
          end
        end
      end
      REQUEST_WRITE_state: begin
        regOut[0+0-:1] = 1'h1;
        regOut[1+0-:1] = 1'h1;
        M_addr_ct_d = M_addr_ct_q - 1'h1;
        if (M_addr_ct_q == 1'h0) begin
          M_state_d = IDLE_state;
        end else begin
          M_state_d = WRITE_state;
          if (M_inc_q) begin
            M_addr_d = M_addr_q + 1'h1;
          end
        end
      end
      REQUEST_READ_state: begin
        regOut[0+0-:1] = 1'h1;
        regOut[1+0-:1] = 1'h0;
        if (regIn[32+0-:1]) begin
          M_data_d = regIn[0+31-:32];
          M_state_d = READ_RESULT_state;
        end else begin
          M_state_d = WAIT_READ_state;
        end
      end
      WAIT_READ_state: begin
        if (regIn[32+0-:1]) begin
          M_data_d = regIn[0+31-:32];
          M_state_d = READ_RESULT_state;
        end
      end
      READ_RESULT_state: begin
        M_timeout_d = 1'h0;
        if (!tx_busy) begin
          tx_data = M_data_q[0+7-:8];
          M_data_d = M_data_q >> 4'h8;
          new_tx_data = 1'h1;
          M_byte_ct_d = M_byte_ct_q + 1'h1;
          if (M_byte_ct_q == 2'h3) begin
            M_addr_ct_d = M_addr_ct_q - 1'h1;
            if (M_addr_ct_q == 1'h0) begin
              M_state_d = IDLE_state;
            end else begin
              M_state_d = REQUEST_READ_state;
              if (M_inc_q) begin
                M_addr_d = M_addr_q + 1'h1;
              end
            end
          end
        end
      end
    endcase
    if ((&M_timeout_q)) begin
      M_state_d = IDLE_state;
    end
  end
  
  always @(posedge clk) begin
    M_addr_ct_q <= M_addr_ct_d;
    M_byte_ct_q <= M_byte_ct_d;
    M_inc_q <= M_inc_d;
    M_wr_q <= M_wr_d;
    M_timeout_q <= M_timeout_d;
    M_addr_q <= M_addr_d;
    M_data_q <= M_data_d;
    
    if (rst == 1'b1) begin
      M_state_q <= 1'h0;
    end else begin
      M_state_q <= M_state_d;
    end
  end
  
endmodule
