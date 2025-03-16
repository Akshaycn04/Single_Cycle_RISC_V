`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Akshaycn04
// 
// Create Date: 2025-03-16 07:30:25
// Design Name: 
// Module Name: riscv_rtype_tb
// Project Name: RISC-V R-Type Comprehensive Testbench
// Target Devices: 
// Tool Versions: 
// Description: Comprehensive testbench for R-type instructions with
//              both wave viewing support and test case verification
// 
// Dependencies: All RISC-V processor modules
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module riscv_rtype_tb;
    // Test signals
    reg clk;
    reg reset;
    integer cycle_count;
    integer errors;
    
    // Clock signal generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock (10ns period)
    end
    
    // Instantiate the processor
    top uut (.clk(clk), .reset(reset));
    
    // Cycle counter for waveform analysis
    always @(posedge clk) begin
        if (reset)
            cycle_count <= 0;
        else
            cycle_count <= cycle_count + 1;
    end
    
    // Main test procedure
    initial begin
        // Initialize variables
        errors = 0;
        cycle_count = 0;
        
        // Display test header
        $display("\n===== RISC-V R-Type Comprehensive Testbench =====");
        $display("Current Date and Time (UTC): 2025-03-16 07:30:25");
        $display("User: Akshaycn04");
        
        // Apply reset
        reset = 1;
        #20;
        reset = 0;
        
        // Load instruction memory with comprehensive R-type test program
        $display("\nLoading Test Program...");
        
        // Setup basic register values with immediate instructions
        uut.INSTR_MEM.I_mem[0]  = 32'h00500093; // addi x1, x0, 5      # x1 = 5
        uut.INSTR_MEM.I_mem[4]  = 32'h00A00113; // addi x2, x0, 10     # x2 = 10
        uut.INSTR_MEM.I_mem[8]  = 32'hFF000193; // addi x3, x0, -16    # x3 = -16
        uut.INSTR_MEM.I_mem[12] = 32'h00300213; // addi x4, x0, 3      # x4 = 3
        
        // R-type ADD/SUB instructions
        uut.INSTR_MEM.I_mem[16] = 32'h002082B3; // add x5, x1, x2      # x5 = 15
        uut.INSTR_MEM.I_mem[20] = 32'h40208333; // sub x6, x1, x2      # x6 = -5
        
        // R-type logical instructions
        uut.INSTR_MEM.I_mem[24] = 32'h0020F3B3; // and x7, x1, x2      # x7 = 0 (5 & 10)
        uut.INSTR_MEM.I_mem[28] = 32'h0020E433; // or x8, x1, x2       # x8 = 15 (5 | 10)
        
        // Display loaded instructions
        $display("Test Program Loaded:");
        $display("0x00: addi x1, x0, 5      # x1 = 5");
        $display("0x04: addi x2, x0, 10     # x2 = 10");
        $display("0x08: addi x3, x0, -16    # x3 = -16");
        $display("0x0C: addi x4, x0, 3      # x4 = 3");
        $display("0x10: add x5, x1, x2      # x5 = 15");
        $display("0x14: sub x6, x1, x2      # x6 = -5");
        $display("0x18: and x7, x1, x2      # x7 = 0");
        $display("0x1C: or x8, x1, x2       # x8 = 15");
        
        // Execute program
        $display("\n===== EXECUTION TRACE =====");
        
        // Wait for all instructions to execute (8 instructions x 1 cycle each + buffer)
        #100;
        
        // Verify results
        verify_results();
        
        // Display wave monitoring tips
        $display("\n===== WAVEFORM ANALYSIS GUIDE =====");
        $display("To analyze functionality in waveform viewer:");
        $display("1. Add these key signals to your waveform:");
        $display("   - clk, reset, cycle_count");
        $display("   - PC_current, instruction");
        $display("   - read_data1, read_data2, ALU_control, alu_result");
        $display("   - RegWrite, ALUOp");
        $display("2. Verify instruction flow (PC increments by 4 each cycle)");
        $display("3. Check that RegWrite is high during register updates");
        $display("4. Observe ALU_control changes for different operations:");
        $display("   - 0010: ADD");
        $display("   - 0110: SUB");
        $display("   - 0000: AND");
        $display("   - 0001: OR");
        
        $finish;
    end
    
    // Task to verify register results
    task verify_results;
        begin
            $display("\n===== REGISTER VERIFICATION =====");
            
            // Check immediate value loading
            verify_reg(1, 32'd5, "addi x1, x0, 5");
            verify_reg(2, 32'd10, "addi x2, x0, 10");
            verify_reg(3, 32'hFFFFFFF0, "addi x3, x0, -16"); // -16 in 2's complement
            verify_reg(4, 32'd3, "addi x4, x0, 3");
            
            // Check R-type operation results
            verify_reg(5, 32'd15, "add x5, x1, x2");
            verify_reg(6, 32'hFFFFFFFB, "sub x6, x1, x2"); // -5 in 2's complement
            verify_reg(7, 32'd0, "and x7, x1, x2");
            verify_reg(8, 32'd15, "or x8, x1, x2");
            
            // Summary
            $display("\n===== TEST SUMMARY =====");
            if (errors == 0) begin
                $display("All tests PASSED! All R-type instructions executed correctly.");
            end else begin
                $display("Some tests FAILED! %0d errors detected.", errors);
            end
        end
    endtask
    
    // Helper task to verify a single register
    task verify_reg;
        input [4:0] reg_num;
        input [31:0] expected;
        input [100*8:1] description;
        begin
            if (uut.register_file.regs[reg_num] === expected) begin
                $display("PASS: Register x%0d = 0x%h (%0d) - %s", 
                    reg_num, uut.register_file.regs[reg_num], 
                    $signed(uut.register_file.regs[reg_num]), description);
            end else begin
                $display("FAIL: Register x%0d = 0x%h (%0d), Expected 0x%h (%0d) - %s", 
                    reg_num, uut.register_file.regs[reg_num], 
                    $signed(uut.register_file.regs[reg_num]),
                    expected, $signed(expected), description);
                errors = errors + 1;
            end
        end
    endtask
    
    // Detailed signal monitoring for text output and waveform correlation
    initial begin
        $monitor("Cycle %0d: PC=0x%h, Instr=0x%h, RegWrite=%b, ALU_control=%b, ALU_result=0x%h", 
                 cycle_count, uut.PC_current, uut.instruction, 
                 uut.RegWrite, uut.ALU_control, uut.alu_result);
    end
    
    // Additional signal monitoring - specifically for ALU operations
    always @(posedge clk) begin
        if (!reset && cycle_count > 3) begin // Only monitor R-type instructions
            case (uut.ALU_control)
                4'b0010: $display("  ALU Operation: ADD - Inputs: %0d, %0d = Result: %0d", 
                           $signed(uut.read_data1), $signed(uut.alu_input2), $signed(uut.alu_result));
                4'b0110: $display("  ALU Operation: SUB - Inputs: %0d, %0d = Result: %0d", 
                           $signed(uut.read_data1), $signed(uut.alu_input2), $signed(uut.alu_result));
                4'b0000: $display("  ALU Operation: AND - Inputs: 0x%h, 0x%h = Result: 0x%h", 
                           uut.read_data1, uut.alu_input2, uut.alu_result);
                4'b0001: $display("  ALU Operation: OR  - Inputs: 0x%h, 0x%h = Result: 0x%h", 
                           uut.read_data1, uut.alu_input2, uut.alu_result);
                default: $display("  ALU Operation: Unknown (%b)", uut.ALU_control);
            endcase
        end
    end
endmodule