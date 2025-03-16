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



module mux3(sel3,a3,b3,mux_out_3);
input sel3;
input [31:0] a3,b3;
output [31:0] mux_out_3;
assign mux_out_3= (sel3==1'b0) ? a3 : b3;
endmodule
