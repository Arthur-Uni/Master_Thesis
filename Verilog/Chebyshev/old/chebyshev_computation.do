onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB -radix decimal -radixenum numeric /chebyshev_computation_tb/WL_A_TB
add wave -noupdate -expand -group TB -radix decimal -radixenum numeric /chebyshev_computation_tb/WL_B_TB
add wave -noupdate -expand -group TB -radix decimal -radixenum numeric /chebyshev_computation_tb/clock
add wave -noupdate -expand -group TB -radix decimal -radixenum numeric /chebyshev_computation_tb/resetn
add wave -noupdate -expand -group TB -radix decimal -radixenum numeric /chebyshev_computation_tb/data_in
add wave -noupdate -expand -group TB -radix decimal -radixenum numeric /chebyshev_computation_tb/coeff_in
add wave -noupdate -expand -group TB -radix decimal -radixenum numeric /chebyshev_computation_tb/data_out
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/data_in
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/coeff_in
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/data_out
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/in
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/out
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/temp
add wave -noupdate -expand -group DUT -radix decimal -childformat {{{/chebyshev_computation_tb/DUT/coeff[3]} -radix decimal} {{/chebyshev_computation_tb/DUT/coeff[2]} -radix decimal} {{/chebyshev_computation_tb/DUT/coeff[1]} -radix decimal} {{/chebyshev_computation_tb/DUT/coeff[0]} -radix decimal}} -radixenum numeric -expand -subitemconfig {{/chebyshev_computation_tb/DUT/coeff[3]} {-height 15 -radix decimal -radixenum numeric} {/chebyshev_computation_tb/DUT/coeff[2]} {-height 15 -radix decimal -radixenum numeric} {/chebyshev_computation_tb/DUT/coeff[1]} {-height 15 -radix decimal -radixenum numeric} {/chebyshev_computation_tb/DUT/coeff[0]} {-height 15 -radix decimal -radixenum numeric}} /chebyshev_computation_tb/DUT/coeff
add wave -noupdate -expand -group DUT -expand /chebyshev_computation_tb/DUT/coeff_shifted
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/adder_out
add wave -noupdate -expand -group DUT /chebyshev_computation_tb/DUT/adder_out_shifted
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/mult_out
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/adder_out_trim
add wave -noupdate -expand -group DUT -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/rounding
add wave -noupdate -expand -group DUT_M -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/m/in_a
add wave -noupdate -expand -group DUT_M -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/m/in_b
add wave -noupdate -expand -group DUT_M -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/m/out
add wave -noupdate -expand -group DUT_M -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/m/a_reg
add wave -noupdate -expand -group DUT_M -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/m/b_reg
add wave -noupdate -expand -group DUT_M -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/m/out_reg
add wave -noupdate -expand -group DUT_M -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/m/mult_out
add wave -noupdate -expand -group DUT_A -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/a/in_a
add wave -noupdate -expand -group DUT_A -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/a/in_b
add wave -noupdate -expand -group DUT_A -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/a/out
add wave -noupdate -expand -group DUT_A -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/a/a_reg
add wave -noupdate -expand -group DUT_A -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/a/b_reg
add wave -noupdate -expand -group DUT_A -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/a/out_reg
add wave -noupdate -expand -group DUT_A -radix decimal -radixenum numeric /chebyshev_computation_tb/DUT/a/adder_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42 ps} 0}
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
WaveRestoreZoom {0 ps} {172 ps}
