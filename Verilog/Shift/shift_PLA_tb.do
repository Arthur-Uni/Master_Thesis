onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /shift_PLA_tb_v2/clock
add wave -noupdate /shift_PLA_tb_v2/resetn
add wave -noupdate /shift_PLA_tb_v2/in
add wave -noupdate /shift_PLA_tb_v2/out
add wave -noupdate /shift_PLA_tb_v2/DUT/in
add wave -noupdate /shift_PLA_tb_v2/DUT/out
add wave -noupdate /shift_PLA_tb_v2/DUT/integer_part
add wave -noupdate /shift_PLA_tb_v2/DUT/fractional_part
add wave -noupdate /shift_PLA_tb_v2/DUT/temp
add wave -noupdate /shift_PLA_tb_v2/DUT/sign_bit
add wave -noupdate /shift_PLA_tb_v2/DUT/temp_shift_result
add wave -noupdate /shift_PLA_tb_v2/DUT/shift_result
add wave -noupdate /shift_PLA_tb_v2/DUT/shift_amount_temp
add wave -noupdate /shift_PLA_tb_v2/DUT/shift_amount
add wave -noupdate /shift_PLA_tb_v2/DUT/twos_complement
add wave -noupdate /shift_PLA_tb_v2/DUT/reg_in
add wave -noupdate /shift_PLA_tb_v2/DUT/reg_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {396 ps} 0}
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
WaveRestoreZoom {0 ps} {78 ps}
