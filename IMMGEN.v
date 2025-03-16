`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2025 23:11:35
// Design Name: 
// Module Name: IMMGEN
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


module IMMGEN(opcode, instr, immext);
input [6:0] opcode;
input [31:0] instr;
output reg [31:0]immext;

always @*
begin 
        case(opcode)
        7'b0000011: immext= {{20{instr[31]}}, instr[31:20]};
        7'b0100011: immext= {{20{instr[31]}}, instr[31:25], instr[11:7]};
        7'b1100011: immext= {{20{instr[31]}},instr[31], instr[30:25], instr[11:8],1'b0}; 
        endcase
end      
endmodule
