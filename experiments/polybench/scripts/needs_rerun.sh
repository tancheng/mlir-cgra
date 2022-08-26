#!/bin/bash

function is_a_newer_than_b(){
  # Return true if A file is newer than B file
  local A_FILEPATH="${1}"
  local B_FILEPATH="${2}"
  local A_TIME=$(stat $A_FILEPATH)
  local B_TIME=$(stat $A_FILEPATH)

  if [ "$A_FILEPATH" -nt "$B_FILEPATH" ]
  then
    A_IS_NEWER=true
  else
    A_IS_NEWER=false
  fi

}

function needs_rerun_because_existance() {
  # Set RERUN to true if a file in the input list does not exist
  local -n FILES=$1 # $2 represent second argument
  local -n TMP=false
  for FILE_PATH in "${FILES[@]}" ; do
    if [ -f "$FILE_PATH" ]; then
      TMP=false
    else
      TMP=true
    fi

    if [ "$RERUN" = true ] || [ "$TMP" = true ]; then
      # echo "$FILE_PATH does not exist exists. Setting RERUN to true."
      RERUN=true
    fi
  done
}

function needs_rerun_because_newer() {
  # It needs rerun if any A file is newer than a B file
  # Takes two lists of file paths
  local -n A_FILES=$1 # $1 represent first argument
  local -n B_FILES=$2 # $2 represent second argument
  local -n TMP=false
  
  for A_FILE in "${A_FILES[@]}"; do
    for B_FILE in "${B_FILES[@]}" ; do
      is_a_newer_than_b "$A_FILE" "$B_FILE"
      TMP=$A_IS_NEWER
      # echo "Is Newer? $TMP"

      if [ "$RERUN" = true ] || [ "$TMP" = true ]; then
        echo "$A_FILE is newer. Setting RERUN to true."
        RERUN=true
      fi
    done
  done
}

function needs_rerun() {
  # It needs rerun if FILES2 dont exist, otherwise
  # It needs rerun if any in FILES1 is newer than a any in FILES2
  # Takes two lists of file paths
  # Returns on RERUN (true or false)
  local -n FILES1=$1 # $1 represent first argument
  local -n FILES2=$2 # $2 represent second argument

  needs_rerun_because_existance FILES2
  
  # Only check if newer in case all FILES2 exist 
  if ! [ "$RERUN" = true ]; then
    needs_rerun_because_newer FILES1 FILES2
  fi
  
}

## How to use??

# LIST1=(
#   # Generic compilation scripts
#   /working_dir/soda-opt/experiments/polybench/scripts/bambu-config-values.sh
#   /working_dir/soda-opt/experiments/polybench/scripts/bambu-debug-flags.sh
#   /working_dir/soda-opt/experiments/polybench/scripts/needs_rerun.sh
#   /working_dir/soda-opt/experiments/polybench/scripts/outline-affine_for-opt_full-bambu-soft_float-no_ssdcs.sh

#   # Kernel Specfic
#   /working_dir/soda-opt/experiments/polybench/code/syrk/syrk_2.mlir
#   /working_dir/soda-opt/experiments/polybench/code/syr2k/scripts/run-outline-affine_for-opt_full-bambu-soft_float-no_ssdcs.sh
# )
  
# LIST2=(
#   # Output files of the kernel
#   /working_dir/soda-opt/experiments/polybench/code/syr2k/output/syr2k_2/opt_none-soft_float-no_ssdcs/model.ll
#   /working_dir/soda-opt/experiments/polybench/code/syr2k/output/syr2k_2/opt_none-soft_float-no_ssdcs/bambu/results.txt
# )

# RERUN=FALSE
# needs_rerun LIST1 LIST2

# echo "Rerun? $RERUN"
