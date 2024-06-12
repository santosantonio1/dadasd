onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/DUT/reset
add wave -noupdate /tb/DUT/clock
add wave -noupdate /tb/DUT/door
add wave -noupdate /tb/DUT/ignicao
add wave -noupdate /tb/DUT/EA
add wave -noupdate /tb/DUT/d1/EA
add wave -noupdate -radix decimal /tb/DUT/d1/T_DRIVER/count
add wave -noupdate -radix decimal /tb/DUT/d2/T_ARM/count
add wave -noupdate /tb/DUT/armar
add wave -noupdate /tb/DUT/desarmar
add wave -noupdate /tb/DUT/d2/unlock
add wave -noupdate /tb/DUT/alarme
add wave -noupdate /tb/DUT/waited_alarm_on
add wave -noupdate /tb/DUT/stop_alarm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {238 ns} 0}
quietly wave cursor active 1
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
configure wave -timelineunits ns
update
WaveRestoreZoom {10 ns} {92 ns}