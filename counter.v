//
// Unpublished work. Copyright 2024 Siemens
//
// This material contains trade secrets or otherwise confidential information
// owned by Siemens Industry Software Inc. or its affiliates (collectively,
// "SISW"), or its licensors. Access to and use of this information is strictly
// limited as set forth in the Customer's applicable agreements with SISW.
//
// This material may not be copied, distributed, or otherwise disclosed outside
// of the Customer's facilities without the express written permission of SISW,
// and may not be used in any way not expressly authorized by SISW.
//

`timescale 1ns / 1ns
module counter (count, clk, reset);
output [7:0] count;
input clk, reset;

reg [7:0] count;
parameter tpd_reset_to_count = 3;
parameter tpd_clk_to_count   = 2;

function [7:0] increment;
input [7:0] val;
reg [3:0] i;
reg carry;
  begin
    increment = val;
    carry = 1'b1;
    /* 
     * Exit this loop when carry == zero, OR all bits processed 
     */ 
    for (i = 4'b0; ((carry == 4'b1) && (i <= 7));  i = i+ 4'b1)
       begin
         increment[i] = val[i] ^ carry;
         carry = val[i] & carry;
       end
  end       
endfunction

always @ (posedge clk or posedge reset)
  if (reset)
     count = #tpd_reset_to_count 8'h00;
  else
     count <= #tpd_clk_to_count increment(count);

/***************************************************************** 
Use the following block to make the design synthesizable.

always @ (posedge clk or posedge reset)
  if (reset)
     count = 8'h00;
  else
     count <= count + 8'h01;
******************************************************************/
endmodule
