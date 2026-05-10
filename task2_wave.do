onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /binarySearch_tb/clk
add wave -noupdate /binarySearch_tb/reset
add wave -noupdate /binarySearch_tb/s
add wave -noupdate /binarySearch_tb/done
add wave -noupdate /binarySearch_tb/i
add wave -noupdate /binarySearch_tb/A
add wave -noupdate /binarySearch_tb/Loc
add wave -noupdate /binarySearch_tb/found
add wave -noupdate -color Cyan -radix unsigned /binarySearch_tb/dut/d_init/mid
add wave -noupdate -radix unsigned /binarySearch_tb/dut/d_init/high
add wave -noupdate -radix unsigned /binarySearch_tb/dut/d_init/low
add wave -noupdate /binarySearch_tb/dut/c_unit/val_found
add wave -noupdate /binarySearch_tb/dut/c_unit/ns
add wave -noupdate /binarySearch_tb/dut/c_unit/ps
add wave -noupdate /binarySearch_tb/dut/d_init/low_gteq_high
add wave -noupdate /binarySearch_tb/dut/c_unit/val_gt_mid
add wave -noupdate /binarySearch_tb/dut/c_unit/val_lt_mid
add wave -noupdate /binarySearch_tb/dut/mem_data
add wave -noupdate /binarySearch_tb/dut/d_init/set_mid
add wave -noupdate /binarySearch_tb/dut/d_init/update_high
add wave -noupdate /binarySearch_tb/dut/d_init/update_low
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5896 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {5362 ps} {6642 ps}
