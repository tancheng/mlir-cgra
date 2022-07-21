; RUN: opt %s -load %sodashlibdir/XMLWriter%shlibext \
; RUN:   -S -enable-new-pm=0 -xml-mem-writer 
; RUN: FileCheck %s -input-file=memory_allocation.xml --check-prefixes=CHECK_FILE

declare i8* @malloc(i64)

declare void @free(i8*)

define void @main(float* %0, float* %1, i64 %2, i64 %3, i64 %4, float* %5, float* %6, i64 %7, i64 %8, i64 %9, float* %10, float* %11, i64 %12) {
  %14 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %0, 0
  %15 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %14, float* %1, 1
  %16 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %15, i64 %2, 2
  %17 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %16, i64 %3, 3, 0
  %18 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %17, i64 %4, 4, 0
  %19 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %5, 0
  %20 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %19, float* %6, 1
  %21 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, i64 %7, 2
  %22 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %21, i64 %8, 3, 0
  %23 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %22, i64 %9, 4, 0
  %24 = insertvalue { float*, float*, i64 } undef, float* %10, 0
  %25 = insertvalue { float*, float*, i64 } %24, float* %11, 1
  %26 = insertvalue { float*, float*, i64 } %25, i64 %12, 2
  %27 = alloca float, i64 ptrtoint (float* getelementptr (float, float* null, i64 32) to i64), align 4, !annotation !1
  %28 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %27, 0
  %29 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %28, float* %27, 1
  %30 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %29, i64 0, 2
  %31 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, i64 32, 3, 0
  %32 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %31, i64 1, 4, 0
  %33 = alloca float, i64 ptrtoint (float* getelementptr (float, float* null, i64 32) to i64), align 4, !annotation !2
  %34 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %33, 0
  %35 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %34, float* %33, 1
  %36 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %35, i64 0, 2
  %37 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %36, i64 32, 3, 0
  %38 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %37, i64 1, 4, 0
  %39 = alloca float, i64 ptrtoint (float* getelementptr (float, float* null, i64 1) to i64), align 4, !annotation !3
  %40 = insertvalue { float*, float*, i64 } undef, float* %39, 0
  %41 = insertvalue { float*, float*, i64 } %40, float* %39, 1
  %42 = insertvalue { float*, float*, i64 } %41, i64 0, 2
  %43 = extractvalue { float*, float*, i64 } %26, 1
  %44 = load float, float* %43, align 4
  %45 = extractvalue { float*, float*, i64 } %42, 1
  store float %44, float* %45, align 4
  br label %46

46:                                               ; preds = %49, %13
  %47 = phi i64 [ %60, %49 ], [ 0, %13 ]
  %48 = icmp slt i64 %47, 32
  br i1 %48, label %49, label %61

49:                                               ; preds = %46
  %50 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %18, 1
  %51 = getelementptr float, float* %50, i64 %47
  %52 = load float, float* %51, align 4
  %53 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %32, 1
  %54 = getelementptr float, float* %53, i64 %47
  store float %52, float* %54, align 4
  %55 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %23, 1
  %56 = getelementptr float, float* %55, i64 %47
  %57 = load float, float* %56, align 4
  %58 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %38, 1
  %59 = getelementptr float, float* %58, i64 %47
  store float %57, float* %59, align 4
  %60 = add i64 %47, 1
  br label %46

61:                                               ; preds = %46
  br label %62

62:                                               ; preds = %65, %61
  %63 = phi i64 [ %77, %65 ], [ 0, %61 ]
  %64 = icmp slt i64 %63, 32
  br i1 %64, label %65, label %78

65:                                               ; preds = %62
  %66 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %32, 1
  %67 = getelementptr float, float* %66, i64 %63
  %68 = load float, float* %67, align 4
  %69 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %38, 1
  %70 = getelementptr float, float* %69, i64 %63
  %71 = load float, float* %70, align 4
  %72 = extractvalue { float*, float*, i64 } %42, 1
  %73 = load float, float* %72, align 4
  %74 = fmul float %68, %71
  %75 = fadd float %73, %74
  %76 = extractvalue { float*, float*, i64 } %42, 1
  store float %75, float* %76, align 4
  %77 = add i64 %63, 1
  br label %62

78:                                               ; preds = %62
  %79 = extractvalue { float*, float*, i64 } %42, 1
  %80 = load float, float* %79, align 4
  %81 = extractvalue { float*, float*, i64 } %26, 1
  store float %80, float* %81, align 4
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{!"alloca_main0"}
!2 = !{!"alloca_main1"}
!3 = !{!"alloca_main2"}

; CHECK_FILE: <?xml version="1.0"?>
; CHECK_FILE: <memory>
; CHECK_FILE:  <memory_allocation>
; CHECK_FILE:   <object scope="main" name="alloca_main0" is_internal="F"/>
; CHECK_FILE:   <object scope="main" name="alloca_main1" is_internal="F"/>
; CHECK_FILE:   <object scope="main" name="alloca_main2" is_internal="T"/>
; CHECK_FILE:  </memory_allocation>
; CHECK_FILE: </memory>