# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./bitCounter_controller.sv"
vlog "./bitCounter_datapath.sv"
vlog "./bitCounter.sv"
vlog "./bitCounter_tb.sv"
vlog "./DE1_SoC.sv"
vlog "./binarySearch_controller.sv"
vlog "./binarySearch_datapath.sv"
vlog "./binarySearch.sv"
vlog "./binarySearch_tb.sv"
vlog "./DE1_SoC_tb.sv"
vlog "./ram32x8.v"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work binarySearch_tb -Lf altera_mf_ver

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do task2_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
