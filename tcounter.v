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
module test_counter;

reg clk, reset;
wire [7:0] count;

counter dut (count, clk, reset);

initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
initial	// Test stimulus
  begin
    reset = 0;
    #5 reset = 1;
    #4 reset = 0;
  end
  
initial
    $monitor($stime,, reset,, clk,,, count); 
    
endmodule    
