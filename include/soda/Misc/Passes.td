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

def TestPrintOpNesting : FunctionPass<"soda-test-print-nesting"> {
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

      Note that the generated file is created at the binary execution
      location and will replace any xml files that have the same name based
      on the kernel name of the soda.launch_func.
  }];
  let constructor = "mlir::soda::createTestArgumentsToXMLPass()";
  let options = [
    Option<"writeToTerminal", "write-to-terminal", "bool", /*default=*/"false",
           "If set, write to terminal instead of a file (default: false">,
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
