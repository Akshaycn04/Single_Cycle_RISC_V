`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 19:39:34
// Design Name: 
// Module Name: DATA_MEM
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


module DATA_MEM(clk, reset,memwrite,memread,read_address,write_data,memdata_out);
input clk, reset, memwrite, memread;
input [31:0] read_address, write_data;
output [31:0] memdata_out;

integer k;
reg [31:0] D_memory[63:0];

always @(posedge clk or posedge reset)
begin 
if(reset)
    begin 
    for(k=0;k<64;k=k+1)begin
    D_memory[k]<=32'b00;
        end
    end 
else if(memwrite)
    begin
    D_memory[read_address]<= write_data;
   end
end
   assign memdata_out=(memread)? D_memory[read_address]:32'b00; 
endmodule
