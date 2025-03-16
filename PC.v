`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2025 20:39:34
// Design Name: 
// Module Name: PC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//pc
module PC(
    input clk,
    input reset, 
    input [31:0] PC_in,
    output reg [31:0] PC_out
);
    // Explicitly define intermediate signals for better schematic visibility
    (* keep = "true" *)
    reg [31:0] PC_internal;

    always @(posedge clk or posedge reset) begin
        if(reset)
            PC_internal <= 32'b0;
        else
            PC_internal <= PC_in;        
    end
    
    // Assign to output
    always @(*) begin
        PC_out = PC_internal;
    end
endmodule