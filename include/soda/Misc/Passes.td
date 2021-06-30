//===- Passes.td - Pattern Match Optimizations for SODA -*- tablegen -*----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines language-specific pattern match optimizations for SODA using
// Declarative Rewrite Rules (DRR) specified using TableGen records.
//
//===----------------------------------------------------------------------===//

#ifndef SODA_MISC_PASSES
#define SODA_MISC_PASSES

include "mlir/Pass/PassBase.td"

//===----------------------------------------------------------------------===//
// Basic analysis passes
//===----------------------------------------------------------------------===//

def TestPrintOpNesting : Pass<"soda-test-print-nesting"> {
  let summary = "Print op nesting information";
  let description = [{
      Print nested intructure and metadata info associated with mlir operations.
  }];
  let constructor = "mlir::soda::createTestPrintOpNestingPass()";
  let options = [
    Option<"varName", "option-name", "uint64_t", /*default=*/"512",
           "Description of the option">,
  ];
}

def TestArgumentsToXML : Pass<"soda-extract-arguments-to-xml", "ModuleOp"> {
  let summary = "Generate XML files for soda.launch_func and its arguments";
  let description = [{
      Traverses the arguments of a function and generates a xml file
      that can be read by bambu. The generated file contains random inputs with
      the correct sizes supporting the llvm function arguments.

      If option `="using-bare-ptr"` is used, output xml file ignores the memref
      struct members and only generates simple C arrays with the correct size.
      This option is meant to be used with a lowering pipeline that finishes
      with:
        `--convert-std-to-llvm=use-bare-ptr-memref-call-conv`

      Note that the generated file is created at the binary execution
      location and will replace any xml files that have the same name based
      on the kernel name of the soda.launch_func.
  }];
  let constructor = "mlir::soda::createTestArgumentsToXMLPass()";
  let options = [
    Option<"writeToTerminal", "write-to-terminal", "bool", /*default=*/"false",
           "If set, write to terminal instead of a file (default: false)">,
    Option<"usingBarePtr", "using-bare-ptr", "bool", /*default=*/"false",
           "If set, generate test vectors assuming bare ptrs (default: false)">,
  ];
}

/// Note: The DRR definition used for defining patterns is shown below:
///
/// class Pattern<
///    dag sourcePattern, list<dag> resultPatterns,
///    list<dag> additionalConstraints = [],
///    dag benefitsAdded = (addBenefit 0)
/// >;

//===----------------------------------------------------------------------===//
// Basic Pattern-Match and Rewrite
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Pattern-Match and Rewrite with Constraints
//===----------------------------------------------------------------------===//

#endif // SODA_MISC_PASSES
