`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Akshaycn04
// 
// Create Date: 2025-03-15 20:02:34
// Design Name: 
// Module Name: top
// Project Name: Single-Cycle RISC-V Processor
// Target Devices: 
// Tool Versions: 
// Description: Structural implementation of a single-cycle RISC-V processor
//              with no output port monitoring to maintain pure structural view
// 
// Dependencies: All component modules
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

(* keep_hierarchy = "yes" *) 
module top(
    input clk, 
    input reset
    // Removed all output ports to avoid OBUF elements in the schematic
);
    // Internal wires for connecting components
    (* keep = "true" *)
    wire [31:0] PC_current;
    (* keep = "true" *)
    wire [31:0] instruction;
    (* keep = "true" *)
    wire [31:0] read_data1;
    (* keep = "true" *)
    wire [31:0] read_data2; 
    (* keep = "true" *)
    wire [31:0] imm_ext;
    (* keep = "true" *)
    wire [31:0] alu_input2;
    (* keep = "true" *)
    wire [31:0] alu_result;
    (* keep = "true" *)
    wire [31:0] PC_plus4;
    (* keep = "true" *)
    wire [31:0] branch_target;
    (* keep = "true" *)
    wire [31:0] next_PC;
    (* keep = "true" *)
    wire [31:0] mem_data;
    (* keep = "true" *)
    wire [31:0] write_back_data;
    
    (* keep = "true" *)
    wire RegWrite, MemRead, MemWrite, ALUSrc, MemtoReg, Branch;
    (* keep = "true" *)
    wire [1:0] ALUOp;
    (* keep = "true" *)
    wire [3:0] ALU_control;
    (* keep = "true" *)
    wire zero, branch_taken;

    // PC Register
    (* keep_hierarchy = "yes" *)
    PC program_counter(
        .clk(clk),
        .reset(reset),
        .PC_in(next_PC),
        .PC_out(PC_current)
    );

    // PC Increment
    (* keep_hierarchy = "yes" *)
    ADD_PC_4 pc_plus_4(
        .fromPC(PC_current),
        .nextoPC(PC_plus4)
    );

    // Instruction Memory
    (* keep_hierarchy = "yes" *)
            INSTR_MEM INSTR_MEM(
        .clk(clk),
        .reset(reset),
        .read_addr(PC_current),
        .instr_out(instruction)
    );

    // Control Unit
    (* keep_hierarchy = "yes" *)
    CNTRL control_unit(
        .instr(instruction[6:0]),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .ALUop(ALUOp)
    );

    // Register File
    (* keep_hierarchy = "yes" *)
    REG_FILE register_file(
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(write_back_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Immediate Generator
    (* keep_hierarchy = "yes" *)
    IMMGEN immediate_generator(
        .opcode(instruction[6:0]),
        .instr(instruction),
        .immext(imm_ext)
    );

    // ALU Control Unit
    (* keep_hierarchy = "yes" *)
    ALU_CNTRL alu_control_unit(
        .ALUop(ALUOp),
        .fun7(instruction[30]),
        .fun3(instruction[14:12]),
        .control_out(ALU_control)
    );

    // ALU Input Multiplexer
    (* keep_hierarchy = "yes" *)
    mux1 alu_src_mux(
        .sel1(ALUSrc),
        .a1(read_data2),
        .b1(imm_ext),
        .mux_out(alu_input2)
    );

    // Arithmetic Logic Unit
    (* keep_hierarchy = "yes" *)
    ALU arithmetic_logic_unit(
        .a(read_data1),
        .b(alu_input2),
        .control_in(ALU_control),
        .alu_result(alu_result),
        .zero(zero)
    );

    // Branch Target Adder
    (* keep_hierarchy = "yes" *)
    ADDER branch_adder(
        .in1(PC_current),
        .in2(imm_ext),
        .sum_out(branch_target)
    );

    // Branch Decision
    (* keep_hierarchy = "yes" *)
    AND branch_and(
        .branch(Branch),
        .zero(zero),
        .and_out(branch_taken)
    );

    // PC Multiplexer
    (* keep_hierarchy = "yes" *)
    mux2 pc_mux(
        .sel2(branch_taken),
        .a2(PC_plus4),
        .b2(branch_target),
        .mux_out_2(next_PC)
    );

    // Data Memory
    (* keep_hierarchy = "yes" *)
    DATA_MEM DATA_MEM(
        .clk(clk),
        .reset(reset),
        .memwrite(MemWrite),
        .memread(MemRead),
        .read_address(alu_result),
        .write_data(read_data2),
        .memdata_out(mem_data)
    );

    // Write Back Multiplexer
    (* keep_hierarchy = "yes" *)
    mux3 writeback_mux(
        .sel3(MemtoReg),
        .a3(alu_result),
        .b3(mem_data),
        .mux_out_3(write_back_data)
    );

    // No output assignments - all signals remain internal for clean structural view

endmodule