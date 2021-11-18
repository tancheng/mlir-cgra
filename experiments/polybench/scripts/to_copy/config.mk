export DESIGN_NICKNAME = kernelname
export DESIGN_NAME = kernelname
export PLATFORM    = nangate45

export VERILOG_FILES = ./kernelname.v 
export SDC_FILE      = ./HLS_output/Synthesis/kernelname.sdc 

# These values must be multiples of placement site
# x=0.19 y=1.4

# Marco's values
# export DIE_AREA    = 0 0 620.15 620.6
# export CORE_AREA   = 10.07 11.2 610.27 610.8

# My calculations
# export DIE_AREA    = 0 0 619.97 620.2
# export CORE_AREA   = 10.07 11.2 609.9 609.0

# My calculations doubled
export DIE_AREA 		= 0 0 1239.94 1240.4
export CORE_AREA 		= 10.07 11.2 1229.87 1229.2

