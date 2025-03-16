`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Akshaycn04 
// 
// Create Date: 15.03.2025 19:55:00
// Design Name: 
// Module Name: DEBUG_MONITOR
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

(* keep_hierarchy = "yes" *)
module DEBUG_MONITOR(
    input [31:0] PC_in,
    input [31:0] instr_in,
    input [31:0] alu_result_in,
    output [31:0] PC_out,
    output [31:0] instr_out,
    output [31:0] alu_result_out
);
    // Use explicit assignments for better visibility
    assign PC_out = PC_in;
    assign instr_out = instr_in;
    assign alu_result_out = alu_result_in;
endmodule