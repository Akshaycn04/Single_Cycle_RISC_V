## Constraints file for Single-Cycle RISC-V Processor
## Board: Basys3 (Artix-7) or similar
## Created: 2025-03-15
## Author: Akshaycn04

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Reset button
set_property PACKAGE_PIN U18 [get_ports reset]						
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## LEDs for Program Counter output (low 8 bits)
set_property PACKAGE_PIN U16 [get_ports {PC_out[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[0]}]
set_property PACKAGE_PIN E19 [get_ports {PC_out[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[1]}]
set_property PACKAGE_PIN U19 [get_ports {PC_out[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[2]}]
set_property PACKAGE_PIN V19 [get_ports {PC_out[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[3]}]
set_property PACKAGE_PIN W18 [get_ports {PC_out[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[4]}]
set_property PACKAGE_PIN U15 [get_ports {PC_out[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[5]}]
set_property PACKAGE_PIN U14 [get_ports {PC_out[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[6]}]
set_property PACKAGE_PIN V14 [get_ports {PC_out[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {PC_out[7]}]

## LEDs for ALU result output (low 8 bits)
set_property PACKAGE_PIN V13 [get_ports {alu_result_out[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[0]}]
set_property PACKAGE_PIN V3 [get_ports {alu_result_out[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[1]}]
set_property PACKAGE_PIN W3 [get_ports {alu_result_out[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[2]}]
set_property PACKAGE_PIN U3 [get_ports {alu_result_out[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[3]}]
set_property PACKAGE_PIN P3 [get_ports {alu_result_out[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[4]}]
set_property PACKAGE_PIN N3 [get_ports {alu_result_out[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[5]}]
set_property PACKAGE_PIN P1 [get_ports {alu_result_out[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[6]}]
set_property PACKAGE_PIN L1 [get_ports {alu_result_out[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {alu_result_out[7]}]

## Config options
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## Hierarchy preservation - these are the important lines
set_property KEEP_HIERARCHY TRUE [get_cells -hierarchical *]
# The following non-standard constraints help preserve hierarchy during synthesis
# These must be included in your XDC file for structural synthesis view
set_property KEEP TRUE [get_cells -hierarchical *]
set_property DONT_TOUCH TRUE [get_cells -hierarchical *]

## False paths for reset synchronization
set_false_path -from [get_ports reset] -to [all_registers]
# Add these lines to your constraints file
set_property -dict {KEEP_HIERARCHY true} [get_cells -hierarchical *]
set_property IOB false [get_ports {PC_out[*]}]
set_property IOB false [get_ports {instr_out[*]}]
set_property IOB false [get_ports {alu_result_out[*]}]

# Or use this to apply to all output ports
set_property IOB false [all_outputs]
# Force debug signals to remain visible in the hierarchy
set_property DONT_TOUCH true [get_cells -hier *DEBUG_MONITOR*]
set_property MARK_DEBUG true [get_nets -hier *PC_current*]
set_property MARK_DEBUG true [get_nets -hier *instruction*]
set_property MARK_DEBUG true [get_nets -hier *alu_result*]