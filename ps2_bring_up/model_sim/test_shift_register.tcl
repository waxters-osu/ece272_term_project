# Referencing https://pages.cs.wisc.edu/~david/courses/cs552/S12/includes/modelsim.html

# set global current simulation time and step size
set elapsed_time 0
set step 10

proc default_constructor {} {
	global elapsed_time
    global step

	restart -force -nowave
	add wave *

    force -deposit reset 0 $elapsed_time
    force -freeze clk 0 0, 1 [expr $step / 2] -repeat $step
}

proc default_destructor {} {
	global elapsed_time
    global step

	run $elapsed_time
    view wave
}

proc trigger_reset {} {
    global elapsed_time
    global step

    #trigger reset for step size
    force -freeze reset 1 $elapsed_time
    set elapsed_time [expr $elapsed_time + $step]
    force -deposit reset 0 $elapsed_time
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
        force -freeze serial_in [expr $i % 2] $elapsed_time
        set elapsed_time [expr $elapsed_time + $step]
    }
}

proc main {} {
    global elapsed_time
    global step

    default_constructor
    trigger_reset   
    assign_data_to_serial_in

    set elapsed_time [expr $step * 12]

    default_destructor
}
