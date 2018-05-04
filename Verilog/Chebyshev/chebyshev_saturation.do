onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /chebyshev_saturation_tb/data_in
add wave -noupdate -expand -group TB /chebyshev_saturation_tb/data_out
add wave -noupdate -expand -group DUT /chebyshev_saturation_tb/DUT/integer_part
add wave -noupdate -expand -group DUT /chebyshev_saturation_tb/DUT/sign_flag
add wave -noupdate -expand -group DUT /chebyshev_saturation_tb/DUT/sign_extension
add wave -noupdate -expand -group DUT /chebyshev_saturation_tb/DUT/saturation_flag
add wave -noupdate -expand -group DUT /chebyshev_saturation_tb/DUT/saturation
add wave -noupdate -expand -group DUT /chebyshev_saturation_tb/DUT/test
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {1 ns}
