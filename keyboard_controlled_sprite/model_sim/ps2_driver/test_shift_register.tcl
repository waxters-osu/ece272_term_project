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
    force -deposit clk 0 0, 1 [expr $step / 2] -repeat $step
    force -deposit serial_in 0 0, 1 15, 0 30, 1 45, 0 60, 1 75
    force -freeze serial_in 1 100
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

proc main {} {
    global elapsed_time
    global step

    default_constructor
    trigger_reset   

    set elapsed_time [expr $step * 20]

    default_destructor
}
