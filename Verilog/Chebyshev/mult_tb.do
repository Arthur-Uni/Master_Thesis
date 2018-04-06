onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /mult_tb/WL_A_TB
add wave -noupdate -expand -group TB /mult_tb/WL_B_TB
add wave -noupdate -expand -group TB /mult_tb/clock
add wave -noupdate -expand -group TB /mult_tb/resetn
add wave -noupdate -expand -group TB /mult_tb/in_a
add wave -noupdate -expand -group TB /mult_tb/in_b
add wave -noupdate -expand -group TB /mult_tb/out
add wave -noupdate -expand -group DUT /mult_tb/DUT/WL_A
add wave -noupdate -expand -group DUT /mult_tb/DUT/WL_B
add wave -noupdate -expand -group DUT /mult_tb/DUT/clock
add wave -noupdate -expand -group DUT /mult_tb/DUT/resetn
add wave -noupdate -expand -group DUT /mult_tb/DUT/in_a
add wave -noupdate -expand -group DUT /mult_tb/DUT/in_b
add wave -noupdate -expand -group DUT /mult_tb/DUT/out
add wave -noupdate -expand -group DUT /mult_tb/DUT/a_reg
add wave -noupdate -expand -group DUT /mult_tb/DUT/b_reg
add wave -noupdate -expand -group DUT /mult_tb/DUT/out_reg
add wave -noupdate -expand -group DUT /mult_tb/DUT/mult_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {234 ps}
