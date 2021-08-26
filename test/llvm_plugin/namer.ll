; RUN: opt %s -load llvmshlibdir/BugpointPasses%pluginext \
; RUN: -S -debug-pass-manager -enable-new-pm=0 -namer
; RUN: -disable-output 2>&1 | FileCheck %s

; ModuleID = '<stdin>'
source_filename = "LLVMDialectModule"

declare i8* @malloc(i64)

declare void @free(i8*)

define void @simple(float* %0, float* %1, i64 %2, i64 %3, i64 %4, float* %5, float* %6, i64 %7, i64 %8, i64 %9) {
  %11 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %0, 0
  %12 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %11, float* %1, 1
  %13 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %12, i64 %2, 2
  %14 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %13, i64 %3, 3, 0
  %15 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %14, i64 %4, 4, 0
  %16 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %5, 0
  %17 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %16, float* %6, 1
  %18 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %17, i64 %7, 2
  %19 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %18, i64 %8, 3, 0
  %20 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %19, i64 %9, 4, 0
  %21 = alloca float, i64 mul (i64 ptrtoint (float* getelementptr (float, float* null, i32 1) to i64), i64 512), align 4
  %22 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } undef, float* %21, 0
  %23 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %22, float* %21, 1
  %24 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %23, i64 0, 2
  %25 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %24, i64 8, 3, 0
  %26 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %25, i64 64, 3, 1
  %27 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %26, i64 64, 4, 0
  %28 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %27, i64 1, 4, 1
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

; CHECK: simple