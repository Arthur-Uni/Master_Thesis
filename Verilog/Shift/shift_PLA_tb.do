onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /shift_PLA_tb/clock
add wave -noupdate -expand -group TB /shift_PLA_tb/resetn
add wave -noupdate -expand -group TB /shift_PLA_tb/in
add wave -noupdate -expand -group TB /shift_PLA_tb/out
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/in
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/out
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/integer_part
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/fractional_part
add wave -noupdate -expand -group DUT -radix binary /shift_PLA_tb/DUT/temp
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/sign_bit
add wave -noupdate -expand -group DUT -radix binary /shift_PLA_tb/DUT/temp_shift_result
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/shift_result
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/shift_amount
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/saturation
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/twos_complement
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/reg_in
add wave -noupdate -expand -group DUT /shift_PLA_tb/DUT/reg_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35 ps} 0}
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
WaveRestoreZoom {0 ps} {64 ps}
