# Referencing https://pages.cs.wisc.edu/~david/courses/cs552/S12/includes/modelsim.html
# set global current simulation time and step size
set elapsed_time 0
set step 10000

proc default_constructor {} {
	global elapsed_time
    global step

	restart -force -nowave
	add wave *

    force -deposit reset 0 $elapsed_time

    force -freeze fast_clk 0 0, 1 1 -repeat 2
    force -freeze slow_clk 0 0, 1 5000 -repeat 10000
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

    set elapsed_time 500000

    default_destructor
}
