; RUN: opt -load %sodashlibdir/LLVMNamer%shlibext -namer \
; RUN:     -S -enable-new-pm=0 -disable-output < %s 2>&1 | FileCheck %s

; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare i8* @malloc(i64)

declare void @free(i8*)

define void @main(float* %0, float* %1, i64 %2, i64 %3, i64 %4, float* %5, float* %6, i64 %7, i64 %8, i64 %9, float* %10, float* %11, i64 %12) !dbg !3 {
  %14 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %0, 0, !dbg !7
  %15 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %14, float* %1, 1, !dbg !9
  %16 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %15, i64 %2, 2, !dbg !10
  %17 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %16, i64 %3, 3, 0, !dbg !11
  %18 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %17, i64 %4, 4, 0, !dbg !12
  %19 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %5, 0, !dbg !13
  %20 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %19, float* %6, 1, !dbg !14
  %21 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, i64 %7, 2, !dbg !15
  %22 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %21, i64 %8, 3, 0, !dbg !16
  %23 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %22, i64 %9, 4, 0, !dbg !17
  %24 = insertvalue { float*, float*, i64 } undef, float* %10, 0, !dbg !18
  %25 = insertvalue { float*, float*, i64 } %24, float* %11, 1, !dbg !19
  %26 = insertvalue { float*, float*, i64 } %25, i64 %12, 2, !dbg !20
  %27 = alloca float, i64 ptrtoint (float* getelementptr (float, float* null, i64 32) to i64), align 4, !dbg !21
  %28 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %27, 0, !dbg !22
  %29 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %28, float* %27, 1, !dbg !23
  %30 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %29, i64 0, 2, !dbg !24
  %31 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, i64 32, 3, 0, !dbg !25
  %32 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %31, i64 1, 4, 0, !dbg !26
  %33 = alloca float, i64 ptrtoint (float* getelementptr (float, float* null, i64 32) to i64), align 4, !dbg !27
  %34 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %33, 0, !dbg !28
  %35 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %34, float* %33, 1, !dbg !29
  %36 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %35, i64 0, 2, !dbg !30
  %37 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %36, i64 32, 3, 0, !dbg !31
  %38 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %37, i64 1, 4, 0, !dbg !32
  %39 = alloca float, i64 ptrtoint (float* getelementptr (float, float* null, i64 1) to i64), align 4, !dbg !33
  %40 = insertvalue { float*, float*, i64 } undef, float* %39, 0, !dbg !34
  %41 = insertvalue { float*, float*, i64 } %40, float* %39, 1, !dbg !35
  %42 = insertvalue { float*, float*, i64 } %41, i64 0, 2, !dbg !36
  %43 = extractvalue { float*, float*, i64 } %26, 1, !dbg !37
  %44 = load float, float* %43, align 4, !dbg !38
  %45 = extractvalue { float*, float*, i64 } %42, 1, !dbg !39
  store float %44, float* %45, align 4, !dbg !40
  br label %46, !dbg !41

46:                                               ; preds = %49, %13
  %47 = phi i64 [ %60, %49 ], [ 0, %13 ]
  %48 = icmp slt i64 %47, 32, !dbg !42
  br i1 %48, label %49, label %61, !dbg !43

49:                                               ; preds = %46
  %50 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %18, 1, !dbg !44
  %51 = getelementptr float, float* %50, i64 %47, !dbg !45
  %52 = load float, float* %51, align 4, !dbg !46
  %53 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %32, 1, !dbg !47
  %54 = getelementptr float, float* %53, i64 %47, !dbg !48
  store float %52, float* %54, align 4, !dbg !49
  %55 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %23, 1, !dbg !50
  %56 = getelementptr float, float* %55, i64 %47, !dbg !51
  %57 = load float, float* %56, align 4, !dbg !52
  %58 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %38, 1, !dbg !53
  %59 = getelementptr float, float* %58, i64 %47, !dbg !54
  store float %57, float* %59, align 4, !dbg !55
  %60 = add i64 %47, 1, !dbg !56
  br label %46, !dbg !57

61:                                               ; preds = %46
  br label %62, !dbg !58

62:                                               ; preds = %65, %61
  %63 = phi i64 [ %77, %65 ], [ 0, %61 ]
  %64 = icmp slt i64 %63, 32, !dbg !59
  br i1 %64, label %65, label %78, !dbg !60

65:                                               ; preds = %62
  %66 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %32, 1, !dbg !61
  %67 = getelementptr float, float* %66, i64 %63, !dbg !62
  %68 = load float, float* %67, align 4, !dbg !63
  %69 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %38, 1, !dbg !64
  %70 = getelementptr float, float* %69, i64 %63, !dbg !65
  %71 = load float, float* %70, align 4, !dbg !66
  %72 = extractvalue { float*, float*, i64 } %42, 1, !dbg !67
  %73 = load float, float* %72, align 4, !dbg !68
  %74 = fmul float %68, %71, !dbg !69
  %75 = fadd float %73, %74, !dbg !70
  %76 = extractvalue { float*, float*, i64 } %42, 1, !dbg !71
  store float %75, float* %76, align 4, !dbg !72
  %77 = add i64 %63, 1, !dbg !73
  br label %62, !dbg !74

78:                                               ; preds = %62
  %79 = extractvalue { float*, float*, i64 } %42, 1, !dbg !75
  %80 = load float, float* %79, align 4, !dbg !76
  %81 = extractvalue { float*, float*, i64 } %26, 1, !dbg !77
  store float %80, float* %81, align 4, !dbg !78
  ret void, !dbg !79
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "main", linkageName: "main", scope: null, file: !4, line: 2, type: !5, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "<stdin>", directory: "/home/nico/Development/soda/examples/samples/other/dot")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 4, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 5, column: 10, scope: !8)
!10 = !DILocation(line: 6, column: 10, scope: !8)
!11 = !DILocation(line: 7, column: 10, scope: !8)
!12 = !DILocation(line: 8, column: 10, scope: !8)
!13 = !DILocation(line: 10, column: 10, scope: !8)
!14 = !DILocation(line: 11, column: 10, scope: !8)
!15 = !DILocation(line: 12, column: 10, scope: !8)
!16 = !DILocation(line: 13, column: 11, scope: !8)
!17 = !DILocation(line: 14, column: 11, scope: !8)
!18 = !DILocation(line: 16, column: 11, scope: !8)
!19 = !DILocation(line: 17, column: 11, scope: !8)
!20 = !DILocation(line: 18, column: 11, scope: !8)
!21 = !DILocation(line: 24, column: 11, scope: !8)
!22 = !DILocation(line: 26, column: 11, scope: !8)
!23 = !DILocation(line: 27, column: 11, scope: !8)
!24 = !DILocation(line: 29, column: 11, scope: !8)
!25 = !DILocation(line: 30, column: 11, scope: !8)
!26 = !DILocation(line: 31, column: 11, scope: !8)
!27 = !DILocation(line: 37, column: 11, scope: !8)
!28 = !DILocation(line: 39, column: 11, scope: !8)
!29 = !DILocation(line: 40, column: 11, scope: !8)
!30 = !DILocation(line: 42, column: 11, scope: !8)
!31 = !DILocation(line: 43, column: 11, scope: !8)
!32 = !DILocation(line: 44, column: 11, scope: !8)
!33 = !DILocation(line: 49, column: 11, scope: !8)
!34 = !DILocation(line: 51, column: 11, scope: !8)
!35 = !DILocation(line: 52, column: 11, scope: !8)
!36 = !DILocation(line: 54, column: 11, scope: !8)
!37 = !DILocation(line: 55, column: 11, scope: !8)
!38 = !DILocation(line: 56, column: 11, scope: !8)
!39 = !DILocation(line: 57, column: 11, scope: !8)
!40 = !DILocation(line: 58, column: 5, scope: !8)
!41 = !DILocation(line: 62, column: 5, scope: !8)
!42 = !DILocation(line: 64, column: 11, scope: !8)
!43 = !DILocation(line: 65, column: 5, scope: !8)
!44 = !DILocation(line: 67, column: 11, scope: !8)
!45 = !DILocation(line: 68, column: 11, scope: !8)
!46 = !DILocation(line: 69, column: 11, scope: !8)
!47 = !DILocation(line: 70, column: 11, scope: !8)
!48 = !DILocation(line: 71, column: 11, scope: !8)
!49 = !DILocation(line: 72, column: 5, scope: !8)
!50 = !DILocation(line: 73, column: 11, scope: !8)
!51 = !DILocation(line: 74, column: 11, scope: !8)
!52 = !DILocation(line: 75, column: 11, scope: !8)
!53 = !DILocation(line: 76, column: 11, scope: !8)
!54 = !DILocation(line: 77, column: 11, scope: !8)
!55 = !DILocation(line: 78, column: 5, scope: !8)
!56 = !DILocation(line: 79, column: 11, scope: !8)
!57 = !DILocation(line: 80, column: 5, scope: !8)
!58 = !DILocation(line: 85, column: 5, scope: !8)
!59 = !DILocation(line: 87, column: 11, scope: !8)
!60 = !DILocation(line: 88, column: 5, scope: !8)
!61 = !DILocation(line: 90, column: 11, scope: !8)
!62 = !DILocation(line: 91, column: 11, scope: !8)
!63 = !DILocation(line: 92, column: 11, scope: !8)
!64 = !DILocation(line: 93, column: 11, scope: !8)
!65 = !DILocation(line: 94, column: 11, scope: !8)
!66 = !DILocation(line: 95, column: 11, scope: !8)
!67 = !DILocation(line: 96, column: 11, scope: !8)
!68 = !DILocation(line: 97, column: 11, scope: !8)
!69 = !DILocation(line: 98, column: 11, scope: !8)
!70 = !DILocation(line: 99, column: 11, scope: !8)
!71 = !DILocation(line: 100, column: 11, scope: !8)
!72 = !DILocation(line: 101, column: 5, scope: !8)
!73 = !DILocation(line: 102, column: 11, scope: !8)
!74 = !DILocation(line: 103, column: 5, scope: !8)
!75 = !DILocation(line: 105, column: 11, scope: !8)
!76 = !DILocation(line: 106, column: 11, scope: !8)
!77 = !DILocation(line: 107, column: 11, scope: !8)
!78 = !DILocation(line: 108, column: 5, scope: !8)
!79 = !DILocation(line: 109, column: 5, scope: !8)

; CHECK: !annotation !22
; CHECK: !annotation !29
; CHECK: !annotation !36
; CHECK: !22 = !{!"alloca_main0"}
; CHECK: !29 = !{!"alloca_main1"}
; CHECK: !36 = !{!"alloca_main2"}