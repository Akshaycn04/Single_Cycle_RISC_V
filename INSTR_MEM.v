`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2025 21:53:30
// Design Name: 
// Module Name: INSTR_MEM
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


module INSTR_MEM(input clk,input reset,input [31:0] read_addr,output reg [31:0] instr_out);
reg [31:0] I_mem[63:0];
integer k;      
always  @(posedge clk or posedge reset)
begin 
    if(reset)
        begin 
            for(k=0;k<64;k=k+1)begin
                I_mem[k]<=32'b00;
            end
        end    
    else 
         instr_out<= I_mem[read_addr];
end                            
endmodule
