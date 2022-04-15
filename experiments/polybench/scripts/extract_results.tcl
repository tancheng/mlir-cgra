proc dump_statistics { name } {
  set util_rpt [report_utilization -return_string]
  set LUTFFPairs 0
  set SliceRegisters 0
  set Slice 0
  set SliceLUTs 0
  set SliceLUTs1 0
  set BRAMFIFO36 0
  set BRAMFIFO18 0
  set BRAMFIFO36_star 0
  set BRAMFIFO18_star 0
  set BRAM18 0
  set BRAMFIFO 0
  set DSPs 0
  set design_slack 0
  set design_req 0
  set design_delay 0
  set tot_cycles 0
  regexp --  {\s*LUT Flip Flop Pairs\s*\|\s*([^[:blank:]]+)} $util_rpt ignore LUTFFPairs
  regexp --  {\s*Slice Registers\s*\|\s*([^[:blank:]]+)} $util_rpt ignore SliceRegisters
  regexp --  {\s*Slice\s*\|\s*([^[:blank:]]+)} $util_rpt ignore Slice
  regexp --  {\s*Slice LUTs\s*\|\s*([^[:blank:]]+)} $util_rpt ignore SliceLUTs
  regexp --  {\s*Slice LUTs\*\s*\|\s*([^[:blank:]]+)} $util_rpt ignore SliceLUTs1
  if { [expr {$SliceLUTs1 == 0}] } {
    set SliceLUTs1 $SliceLUTs
  }
  if { [expr {$LUTFFPairs == 0}] } {
    set LUTFFPairs $SliceLUTs1
    puts $SliceLUTs1
  }
  if { [expr {$SliceLUTs == 0}] } {
    set SliceLUTs $SliceLUTs1
  }
  regexp --  {\s*RAMB36/FIFO36\s*\|\s*([^[:blank:]]+)} $util_rpt ignore BRAMFIFO36
  regexp --  {\s*RAMB18/FIFO18\s*\|\s*([^[:blank:]]+)} $util_rpt ignore BRAMFIFO18
  regexp --  {\s*RAMB36/FIFO\*\s*\|\s*([^[:blank:]]+)} $util_rpt ignore BRAMFIFO36_star
  regexp --  {\s*RAMB18/FIFO\*\s*\|\s*([^[:blank:]]+)} $util_rpt ignore BRAMFIFO18_star
  regexp --  {\s*RAMB18\s*\|\s*([^[:blank:]]+)} $util_rpt ignore BRAM18
  set BRAMFIFO [expr {(2 *$BRAMFIFO36) + $BRAMFIFO18 + (2*$BRAMFIFO36_star) + $BRAMFIFO18_star + $BRAM18}]
  regexp --  {\s*DSPs\s*\|\s*([^[:blank:]]+)} $util_rpt ignore DSPs
  set Timing_Paths [get_timing_paths -max_paths 1 -nworst 1 -setup]
  if { [expr {$Timing_Paths == ""}] } {
    set design_slack 0
    set design_req 0
  } else {
    set design_slack [get_property SLACK $Timing_Paths]
    set design_req [get_property REQUIREMENT  $Timing_Paths]
  }
  if { [expr {$design_slack == ""}] } {
    set design_slack 0
  }
  if { [expr {$design_req == ""}] } {
    set design_req 0
  }
  set design_delay [expr {$design_req - $design_slack}]
  set design_freq [expr {1000/$design_delay}]
  set rfile_cycles [open proj/solution1/sim/report/verilog/result.transaction.rpt r]
  set cycle_rpt [read $rfile_cycles]
  regexp --  {\s*transaction\s*0\:\s*([^[:blank:]]+)} $cycle_rpt ignore tot_cycles
  file delete -force kernel_report.xml 
  set ofile_report [open kernel_report.xml w]
  puts $ofile_report "<?xml version=\"1.0\"?>"
  puts $ofile_report "<vitis_results benchmark_name=\"$name\">>"
  puts $ofile_report "  <SLICE value=\"$Slice\"/>"
  puts $ofile_report "  <REGISTERS value=\"$SliceRegisters\"/>"
  puts $ofile_report "  <SLICE_LUTS value=\"$SliceLUTs\"/>"
  puts $ofile_report "  <BRAMS value=\"$BRAMFIFO\"/>"
  puts $ofile_report "  <DSPS value=\"$DSPs\"/>"
  puts $ofile_report "  <PERIOD value=\"$design_delay\"/>"
  puts $ofile_report "  <CLOCK_SLACK value=\"$design_slack\"/>"
  puts $ofile_report "  <FREQUENCY value=\"$design_freq\"/>"
  puts $ofile_report "  <CYCLES value=\"$tot_cycles\"/>"
  puts $ofile_report "  <TOTAL_CYCLES value=\"$tot_cycles\"/>"
  puts $ofile_report "</vitis_results>"
  close $ofile_report
}; #END PROC

set name [lindex $argv 0]
open_checkpoint proj/solution1/impl/verilog/project.runs/impl_1/bd_0_wrapper_routed.dcp
dump_statistics $name
close_project
