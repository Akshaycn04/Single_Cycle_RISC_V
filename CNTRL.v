`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2025 23:36:56
// Design Name: 
// Module Name: CNTRL
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


module CNTRL(
    input  [6:0] instr,
    output reg Branch, MemRead, MemWrite, ALUSrc, RegWrite, MemtoReg,
    output reg [1:0] ALUop
);
    
    always @(*) begin
        case (instr)
            7'b0110011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUop} = 8'b001000_10; // R-type
            7'b0000011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUop} = 8'b111100_00; // Load
            7'b0100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUop} = 8'b100010_00; // Store
            7'b1100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUop} = 8'b000001_01; // Branch
            default:    {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUop} = 8'b00000000;  // Default case
        endcase
    end
    
endmodule

