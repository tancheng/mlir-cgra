
# Nangate45
export DESIGN_NICKNAME = kernelname
export DESIGN_NAME = kernelname
export PLATFORM    = nangate45

export VERILOG_FILES = ./kernelname.v 
export SDC_FILE      = ./HLS_output/Synthesis/nangate45_constraints.sdc 

# These values must be multiples of placement site
# x=0.19 y=1.4

# Marco's values
# export DIE_AREA    = 0 0 620.15 620.6
# export CORE_AREA   = 10.07 11.2 610.27 610.8

# My calculations
# export DIE_AREA    = 0 0 619.97 620.2
# export CORE_AREA   = 10.07 11.2 609.9 609.0

# My calculations doubled
# export DIE_AREA 		= 0 0 1239.94 1240.4
# export CORE_AREA 		= 10.07 11.2 1229.87 1229.2

# My calculations doubled again
# export DIE_AREA 		= 0 0 2479.88 2480.8
# export CORE_AREA 		= 10.07 11.2 2469.81 2469.6

export CORE_UTILIZATION       = 10
export CORE_ASPECT_RATIO      = 1
export CORE_MARGIN            = 2
export PLACE_DENSITY          = 0.10

# DID NOT RUN
# export CORE_UTILIZATION       = 15
# export CORE_ASPECT_RATIO      = 1
# export CORE_MARGIN            = 2
# export PLACE_DENSITY          = 0.30
