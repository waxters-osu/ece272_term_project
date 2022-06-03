# Referencing https://pages.cs.wisc.edu/~david/courses/cs552/S12/includes/modelsim.html

# set global current simulation time and step size
set elapsed_time 0
set step 10

proc default_constructor {} {
	global elapsed_time
    global step

	restart -force -nowave
	add wave *

    force -deposit sys_reset 0 $elapsed_time

    # Hardware Clk oscillates at 50MHz period of 0.02 mircoseconds.
    force -freeze hardware_clk_50MHz 0 0, 1 1 -repeat 2
    # PS2 Clk oscillates at 10 to 16.7 KHz period of 0.1 to 0.06 milliseconds
    force -freeze ps2_clk 0 0, 1 5000 -repeat 10000
}

proc default_destructor {} {
	global elapsed_time
    global step

    add wave -position end sim:/ps2_bring_up/b2v_inst4/*
    add wave -position end sim:/ps2_bring_up/b2v_inst5/*
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

proc assign_data_to_serial_in {} {
    global elapsed_time
    global step

    #####
    # push data on serial_in line
    #####
    # offset elapsed time
    set elapsed_time [expr $elapsed_time + ($step / 4)]
    for {set i 0} {$i < 8} {incr i} {
        force -freeze ps2_data [expr $i % 2] $elapsed_time
        set elapsed_time [expr $elapsed_time + $step]
    }
}

proc main {} {
    global elapsed_time
    global step

    default_constructor
    trigger_reset   
    assign_data_to_serial_in

    set elapsed_time 100000

    default_destructor
}
