if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ./a/driver.v
vlog -work work ./a/timer.v
vlog -work work ./a/top.v
vlog -work work ./a/arm.v
vlog -work work ./a/tb.v

vsim -voptargs=+acc=lprn -t ns work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do 

run 1 us