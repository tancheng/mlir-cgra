add_llvm_library(VhlsLLVMRewriter MODULE
  VhlsLLVMRewriter.cc
  MemRefToArray.cc
  Utils.cc

  PLUGIN_TOOL
  opt
)