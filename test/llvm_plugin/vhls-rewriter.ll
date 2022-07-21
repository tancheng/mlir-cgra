; RUN: opt -load %sodashlibdir/VhlsLLVMRewriter%shlibext -mem2arr -xlnname -xlnanno -xlntop gemm_2_kernel \
; RUN:     -xlntbgen -xlntbdummynames="gemm.dummy.c" -xlntbtclnames="gemm.run.tcl" \
; RUN:     -xlnllvm="test.ll" -xlnpath=test_path \
; RUN:     -clock-period-ns=10 -target=test_board \
; RUN:     -S -enable-new-pm=0 < %s 2>&1 | FileCheck %s
; RUN: FileCheck %s -input-file=gemm.run.tcl --check-prefixes=CHECK_TCL
; RUN: FileCheck %s -input-file=gemm.dummy.c --check-prefixes=CHECK_TB

declare i8* @malloc(i64)

declare void @free(i8*)

define void @gemm_2_kernel(float* %0, float %1, float* %2, float* %3, float %4) {
  %6 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } undef, float* %0, 0
  %7 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %6, float* %0, 1
  %8 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %7, i64 0, 2
  %9 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %8, i64 2, 3, 0
  %10 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %9, i64 2, 4, 0
  %11 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %10, i64 2, 3, 1
  %12 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %11, i64 1, 4, 1
  %13 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } undef, float* %2, 0
  %14 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %13, float* %2, 1
  %15 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %14, i64 0, 2
  %16 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %15, i64 2, 3, 0
  %17 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %16, i64 2, 4, 0
  %18 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %17, i64 2, 3, 1
  %19 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %18, i64 1, 4, 1
  %20 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } undef, float* %3, 0
  %21 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %20, float* %3, 1
  %22 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %21, i64 0, 2
  %23 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %22, i64 2, 3, 0
  %24 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %23, i64 2, 4, 0
  %25 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %24, i64 2, 3, 1
  %26 = insertvalue { float*, float*, i64, [2 x i64], [2 x i64] } %25, i64 1, 4, 1
  br label %27

27:                                               ; preds = %73, %5
  %28 = phi i64 [ %74, %73 ], [ 0, %5 ]
  %29 = icmp slt i64 %28, 2
  br i1 %29, label %30, label %75

30:                                               ; preds = %71, %27
  %31 = phi i64 [ %72, %71 ], [ 0, %27 ]
  %32 = icmp slt i64 %31, 2
  br i1 %32, label %33, label %73

33:                                               ; preds = %30
  %34 = extractvalue { float*, float*, i64, [2 x i64], [2 x i64] } %12, 1
  %35 = mul i64 %28, 2
  %36 = add i64 %35, %31
  %37 = getelementptr float, float* %34, i64 %36
  %38 = load float, float* %37, align 4
  %39 = fmul float %1, %38
  %40 = extractvalue { float*, float*, i64, [2 x i64], [2 x i64] } %12, 1
  %41 = mul i64 %28, 2
  %42 = add i64 %41, %31
  %43 = getelementptr float, float* %40, i64 %42
  store float %39, float* %43, align 4
  br label %44

44:                                               ; preds = %47, %33
  %45 = phi i64 [ %70, %47 ], [ 0, %33 ]
  %46 = icmp slt i64 %45, 2
  br i1 %46, label %47, label %71

47:                                               ; preds = %44
  %48 = extractvalue { float*, float*, i64, [2 x i64], [2 x i64] } %19, 1
  %49 = mul i64 %28, 2
  %50 = add i64 %49, %45
  %51 = getelementptr float, float* %48, i64 %50
  %52 = load float, float* %51, align 4
  %53 = extractvalue { float*, float*, i64, [2 x i64], [2 x i64] } %26, 1
  %54 = mul i64 %45, 2
  %55 = add i64 %54, %31
  %56 = getelementptr float, float* %53, i64 %55
  %57 = load float, float* %56, align 4
  %58 = extractvalue { float*, float*, i64, [2 x i64], [2 x i64] } %12, 1
  %59 = mul i64 %28, 2
  %60 = add i64 %59, %31
  %61 = getelementptr float, float* %58, i64 %60
  %62 = load float, float* %61, align 4
  %63 = fmul float %4, %52
  %64 = fmul float %63, %57
  %65 = fadd float %62, %64
  %66 = extractvalue { float*, float*, i64, [2 x i64], [2 x i64] } %12, 1
  %67 = mul i64 %28, 2
  %68 = add i64 %67, %31
  %69 = getelementptr float, float* %66, i64 %68
  store float %65, float* %69, align 4
  %70 = add i64 %45, 1
  br label %44

71:                                               ; preds = %44
  %72 = add i64 %31, 1
  br label %30

73:                                               ; preds = %30
  %74 = add i64 %28, 1
  br label %27

75:                                               ; preds = %27
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

; CHECK: define void @gemm_2_kernel(float %arg_2, float %arg_3, [2 x [2 x float]]* %arg_4, [2 x [2 x float]]* %arg_5, [2 x [2 x float]]* %arg_6) #0 {
; CHECK: br label %bb_1
; CHECK: attributes #0 = { noinline "fpga.top.func"="gemm_2_kernel" }

; CHECK_TCL: open_project -reset proj
; CHECK_TCL: add_files gemm.dummy.c
; CHECK_TCL: add_files -tb gemm.dummy.c
; CHECK_TCL: set_top gemm_2_kernel
; CHECK_TCL: open_solution -reset solution1
; CHECK_TCL: set_part test_board
; CHECK_TCL: create_clock -period 10
; CHECK_TCL: set ::LLVM_CUSTOM_OPT test_path
; CHECK_TCL: set ::LLVM_CUSTOM_CMD {$LLVM_CUSTOM_OPT test.ll -o $LLVM_CUSTOM_OUTPUT}
; CHECK_TCL: csynth_design
; CHECK_TCL: cosim_design
; CHECK_TCL: export_design -format syn_dcp -flow impl

; CHECK_TB: void gemm_2_kernel(float arg_2, float arg_3, float arg_4[2][2], float arg_5[2][2], float arg_6[2][2]) {
; CHECK_TB: }
; CHECK_TB:   int main() {
; CHECK_TB:     static float arg_2;
; CHECK_TB:     static float arg_3;
; CHECK_TB:     static float arg_4[2][2];
; CHECK_TB:     static float arg_5[2][2];
; CHECK_TB:     static float arg_6[2][2];
; CHECK_TB:     gemm_2_kernel(arg_2, arg_3, arg_4, arg_5, arg_6);
; CHECK_TB:     return 0;
; CHECK_TB:   }