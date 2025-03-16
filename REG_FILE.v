`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2025 22:27:15
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE(input clk,reset, RegWrite,input [4:0] rs1,rs2,rd, 
    input [31:0] write_data, output [31:0] read_data1, read_data2);
reg [31:0] regs [63:0];
integer k;
always @(posedge clk or posedge reset)
begin
if(reset)
    begin
        for(k=0;k<32;k=k+1)begin
        regs[k]=32'b00;
        end
    end
else
    regs[rd]<=write_data;
end 
assign read_data1 = regs[rs1];
assign read_dta2 = regs[rs2];        
endmodule
