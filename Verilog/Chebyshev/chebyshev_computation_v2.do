onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /chebyshev_computation_tb/clock
add wave -noupdate -expand -group TB /chebyshev_computation_tb/resetn
add wave -noupdate -expand -group TB /chebyshev_computation_tb/data_in
add wave -noupdate -expand -group TB /chebyshev_computation_tb/coeff_in
add wave -noupdate -expand -group TB /chebyshev_computation_tb/data_out
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/data_in
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/coeff_in
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/data_out
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/in
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/out
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/temp
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/coeff
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/adder_out
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/coeff_shifted
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/adder_out_shifted
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/mult_out
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/adder_out_trim
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/rounding
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
