onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /t1_tb/clk
add wave -noupdate /t1_tb/reset
add wave -noupdate /t1_tb/s
add wave -noupdate /t1_tb/done
add wave -noupdate /t1_tb/A
add wave -noupdate /t1_tb/dut/t1_d/clk
add wave -noupdate /t1_tb/dut/t1_d/reset
add wave -noupdate /t1_tb/dut/t1_d/shiftA
add wave -noupdate /t1_tb/dut/t1_d/loadA
add wave -noupdate /t1_tb/dut/t1_d/incr_result
add wave -noupdate /t1_tb/dut/t1_d/clr_result
add wave -noupdate /t1_tb/dut/t1_d/A
add wave -noupdate /t1_tb/dut/t1_d/result
add wave -noupdate /t1_tb/dut/t1_d/A_eq_0
add wave -noupdate /t1_tb/dut/t1_d/a0
add wave -noupdate /t1_tb/dut/t1_d/A1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {545 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 194
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {420 ps} {1368 ps}
