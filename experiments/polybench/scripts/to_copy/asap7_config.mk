
# ASAP7
export DESIGN_NICKNAME = kernelname
export DESIGN_NAME = kernelname
export PLATFORM    = asap7

export VERILOG_FILES = ./kernelname.v 
export SDC_FILE      = ./HLS_output/Synthesis/asap7_constraints.sdc 

# export DIE_AREA="0 0 360 360"
# export CORE_AREA="10.16 10.16 340 340"

export DIE_AREA="0 0 720 720"
export CORE_AREA="20.32 20.32 680 680"

export ABC_AREA               = 1

export CORE_UTILIZATION       = 30
export CORE_ASPECT_RATIO      = 1
export CORE_MARGIN            = 2
export PLACE_DENSITY          = 0.60
