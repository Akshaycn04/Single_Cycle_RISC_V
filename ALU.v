`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 15:53:18
// Design Name: 
// Module Name: ALU
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


module ALU(a,b,control_in,alu_result,zero);

input [31:0] a,b; 
input [3:0] control_in;
output  reg zero;
output reg [31:0] alu_result;

always @(control_in or a or b)
begin
    case(control_in)
    4'b0000: begin zero <= 1'b0;alu_result <= a&b; end
    4'b0001: begin zero <= 1'b0; alu_result <= a|b; end
    4'b0010: begin zero <= 1'b0; alu_result <= a+b; end
    4'b0110: begin if(a==b) zero <= 1'b1; else zero<=1'b0;alu_result <= a-b; end 
    endcase
end
endmodule
