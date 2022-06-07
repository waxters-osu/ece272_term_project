# Referencing https://pages.cs.wisc.edu/~david/courses/cs552/S12/includes/modelsim.html

# set global current simulation time and step size
set elapsed_time 0
set step 10000

proc default_constructor {} {
	global elapsed_time
    global step

	restart -force -nowave
	add wave *

    force -deposit sys_reset 0 $elapsed_time

    # Hardware Clk oscillates at 50MHz period of 0.02 mircoseconds.
    force -freeze hardware_clk_50MHz 0 0, 1 1 -repeat 2
    # PS2 Clk oscillates at 10 to 16.7 KHz period of 0.1 to 0.06 milliseconds

    # put ps2_data into default state
    force -deposit ps2_data 1 $elapsed_time
    # put ps2_clk into default state
    force -deposit ps2_clk 1 $elapsed_time
}

proc default_destructor {} {
	global elapsed_time
    global step

    add wave -position end sim:/ps2_bring_up/b2v_inst3/*
	run $elapsed_time
    view wave
}

proc trigger_reset {} {
    global elapsed_time
    global step

    #trigger reset for step size
    force -freeze sys_reset 1 $elapsed_time
    set elapsed_time [expr $elapsed_time + $step]
    force -deposit sys_reset 0 $elapsed_time
}

proc send_ps2_msg {value} {
    global elapsed_time
    global step

    # start oscilating ps2_clock
    set ps2_clk_elapsed_time $elapsed_time
    for {set i 0} {$i < 11} {incr i} {
        force -freeze ps2_clk 0 $ps2_clk_elapsed_time, 1 [expr $ps2_clk_elapsed_time + ($step/2)] 
        set ps2_clk_elapsed_time [expr $ps2_clk_elapsed_time + $step]
    }

    # put intial bit onto ps2_data (always 0)
    force -freeze ps2_data 0 $elapsed_time
    set elapsed_time [expr $elapsed_time + $step]

    # put value onto ps2_data
    for {set i 0} {$i < 8} {incr i} {
        force -freeze ps2_data [expr [expr $value & [expr 1 << $i]] >> $i] $elapsed_time
        set elapsed_time [expr $elapsed_time + $step]
    }

    # put parity bit onto ps2_data (0 for "a")
    force -freeze ps2_data 0 $elapsed_time
    set elapsed_time [expr $elapsed_time + $step]

    # put end bit onto ps2_data (always 1)
    force -freeze ps2_data 1 $elapsed_time
    set elapsed_time [expr $elapsed_time + $step]

    # put ps2_data into default state
    force -deposit ps2_data 1 $elapsed_time

    # put ps2_clk into default state
    force -deposit ps2_clk 1 $elapsed_time
}

proc main {} {
    global elapsed_time
    global step

    ######
    # initialize system
    ######
    default_constructor
    trigger_reset   
    set elapsed_time 100000

    ######
    # setup tests
    ######
    # press "a"
    send_ps2_msg 28
    set elapsed_time [expr $elapsed_time + ($step*10)]

    # release "a"
    send_ps2_msg 240
    set elapsed_time [expr $elapsed_time + ($step*10)]
    send_ps2_msg 28
    set elapsed_time [expr $elapsed_time + ($step*10)]

    # press "a" again
    send_ps2_msg 28
    set elapsed_time [expr $elapsed_time + ($step*10)]

    # press "s"
    send_ps2_msg 29
    set elapsed_time [expr $elapsed_time + ($step*10)]

    # press "s"
    send_ps2_msg 29
    set elapsed_time [expr $elapsed_time + ($step*10)]

    ######
    # run tests
    ######
    set elapsed_time 1500000
    default_destructor
}
