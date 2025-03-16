`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2025 23:01:45
// Design Name: 
// Module Name: mux2
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



module mux2(sel2,a2,b2,mux_out_2);
input sel2;
input [31:0] a2,b2;
output [31:0] mux_out_2;
assign mux_out_2= (sel2==1'b0) ? a2 : b2;
endmodule
