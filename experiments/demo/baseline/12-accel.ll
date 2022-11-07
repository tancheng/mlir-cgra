; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @generic_0(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20, ptr %21, ptr %22, i64 %23, i64 %24, i64 %25, i64 %26, i64 %27) !dbg !3 {
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0, !dbg !7
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, ptr %1, 1, !dbg !9
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 %2, 2, !dbg !10
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 %3, 3, 0, !dbg !11
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 %5, 4, 0, !dbg !12
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 %4, 3, 1, !dbg !13
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 %6, 4, 1, !dbg !14
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %7, 0, !dbg !15
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, ptr %8, 1, !dbg !16
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %9, 2, !dbg !17
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %10, 3, 0, !dbg !18
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 %12, 4, 0, !dbg !19
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %11, 3, 1, !dbg !20
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %13, 4, 1, !dbg !21
  %43 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0, !dbg !22
  %44 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %43, ptr %15, 1, !dbg !23
  %45 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %44, i64 %16, 2, !dbg !24
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, i64 %17, 3, 0, !dbg !25
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, i64 %19, 4, 0, !dbg !26
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, i64 %18, 3, 1, !dbg !27
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 %20, 4, 1, !dbg !28
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %21, 0, !dbg !29
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, ptr %22, 1, !dbg !30
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 %23, 2, !dbg !31
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 %24, 3, 0, !dbg !32
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 %26, 4, 0, !dbg !33
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 %25, 3, 1, !dbg !34
  %56 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, i64 %27, 4, 1, !dbg !35
  br label %57, !dbg !36

57:                                               ; preds = %97, %28
  %58 = phi i64 [ %98, %97 ], [ 0, %28 ]
  %59 = icmp slt i64 %58, 4, !dbg !37
  br i1 %59, label %60, label %99, !dbg !38

60:                                               ; preds = %63, %57
  %61 = phi i64 [ %96, %63 ], [ 0, %57 ]
  %62 = icmp slt i64 %61, 4, !dbg !39
  br i1 %62, label %63, label %97, !dbg !40

63:                                               ; preds = %60
  %64 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 1, !dbg !41
  %65 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 2, !dbg !42
  %66 = mul i64 %58, 16, !dbg !43
  %67 = add i64 %65, %66, !dbg !44
  %68 = add i64 %67, %61, !dbg !45
  %69 = getelementptr float, ptr %64, i64 %68, !dbg !46
  %70 = load float, ptr %69, align 4, !dbg !47
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 1, !dbg !48
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 2, !dbg !49
  %73 = mul i64 %58, 16, !dbg !50
  %74 = add i64 %72, %73, !dbg !51
  %75 = add i64 %74, %61, !dbg !52
  %76 = getelementptr float, ptr %71, i64 %75, !dbg !53
  %77 = load float, ptr %76, align 4, !dbg !54
  %78 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, 1, !dbg !55
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, 2, !dbg !56
  %80 = mul i64 %58, 16, !dbg !57
  %81 = add i64 %79, %80, !dbg !58
  %82 = add i64 %81, %61, !dbg !59
  %83 = getelementptr float, ptr %78, i64 %82, !dbg !60
  %84 = load float, ptr %83, align 4, !dbg !61
  %85 = fadd float %70, %77, !dbg !62
  %86 = fcmp ugt float %85, 0.000000e+00, !dbg !63
  %87 = select i1 %86, float %85, float 0.000000e+00, !dbg !64
  %88 = select i1 false, float 0.000000e+00, float %87, !dbg !65
  %89 = fadd float %88, %84, !dbg !66
  %90 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, 1, !dbg !67
  %91 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, 2, !dbg !68
  %92 = mul i64 %58, 16, !dbg !69
  %93 = add i64 %91, %92, !dbg !70
  %94 = add i64 %93, %61, !dbg !71
  %95 = getelementptr float, ptr %90, i64 %94, !dbg !72
  store float %89, ptr %95, align 4, !dbg !73
  %96 = add i64 %61, 1, !dbg !74
  br label %60, !dbg !75

97:                                               ; preds = %60
  %98 = add i64 %58, 1, !dbg !76
  br label %57, !dbg !77

99:                                               ; preds = %57
  ret void, !dbg !78
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "generic_0", linkageName: "generic_0", scope: null, file: !4, line: 2, type: !5, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "10-accel-llvm.mlir", directory: "/home/tancheng/workspace/ml/mlir-cgra/mlir-cgra/experiments/demo/baseline")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 4, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 5, column: 10, scope: !8)
!10 = !DILocation(line: 6, column: 10, scope: !8)
!11 = !DILocation(line: 7, column: 10, scope: !8)
!12 = !DILocation(line: 8, column: 10, scope: !8)
!13 = !DILocation(line: 9, column: 10, scope: !8)
!14 = !DILocation(line: 10, column: 10, scope: !8)
!15 = !DILocation(line: 12, column: 10, scope: !8)
!16 = !DILocation(line: 13, column: 11, scope: !8)
!17 = !DILocation(line: 14, column: 11, scope: !8)
!18 = !DILocation(line: 15, column: 11, scope: !8)
!19 = !DILocation(line: 16, column: 11, scope: !8)
!20 = !DILocation(line: 17, column: 11, scope: !8)
!21 = !DILocation(line: 18, column: 11, scope: !8)
!22 = !DILocation(line: 20, column: 11, scope: !8)
!23 = !DILocation(line: 21, column: 11, scope: !8)
!24 = !DILocation(line: 22, column: 11, scope: !8)
!25 = !DILocation(line: 23, column: 11, scope: !8)
!26 = !DILocation(line: 24, column: 11, scope: !8)
!27 = !DILocation(line: 25, column: 11, scope: !8)
!28 = !DILocation(line: 26, column: 11, scope: !8)
!29 = !DILocation(line: 28, column: 11, scope: !8)
!30 = !DILocation(line: 29, column: 11, scope: !8)
!31 = !DILocation(line: 30, column: 11, scope: !8)
!32 = !DILocation(line: 31, column: 11, scope: !8)
!33 = !DILocation(line: 32, column: 11, scope: !8)
!34 = !DILocation(line: 33, column: 11, scope: !8)
!35 = !DILocation(line: 34, column: 11, scope: !8)
!36 = !DILocation(line: 39, column: 5, scope: !8)
!37 = !DILocation(line: 41, column: 11, scope: !8)
!38 = !DILocation(line: 42, column: 5, scope: !8)
!39 = !DILocation(line: 44, column: 11, scope: !8)
!40 = !DILocation(line: 45, column: 5, scope: !8)
!41 = !DILocation(line: 47, column: 11, scope: !8)
!42 = !DILocation(line: 48, column: 11, scope: !8)
!43 = !DILocation(line: 50, column: 11, scope: !8)
!44 = !DILocation(line: 51, column: 11, scope: !8)
!45 = !DILocation(line: 52, column: 11, scope: !8)
!46 = !DILocation(line: 53, column: 11, scope: !8)
!47 = !DILocation(line: 54, column: 11, scope: !8)
!48 = !DILocation(line: 55, column: 11, scope: !8)
!49 = !DILocation(line: 56, column: 11, scope: !8)
!50 = !DILocation(line: 58, column: 11, scope: !8)
!51 = !DILocation(line: 59, column: 11, scope: !8)
!52 = !DILocation(line: 60, column: 11, scope: !8)
!53 = !DILocation(line: 61, column: 11, scope: !8)
!54 = !DILocation(line: 62, column: 11, scope: !8)
!55 = !DILocation(line: 63, column: 11, scope: !8)
!56 = !DILocation(line: 64, column: 11, scope: !8)
!57 = !DILocation(line: 66, column: 11, scope: !8)
!58 = !DILocation(line: 67, column: 11, scope: !8)
!59 = !DILocation(line: 68, column: 11, scope: !8)
!60 = !DILocation(line: 69, column: 11, scope: !8)
!61 = !DILocation(line: 70, column: 11, scope: !8)
!62 = !DILocation(line: 71, column: 11, scope: !8)
!63 = !DILocation(line: 72, column: 11, scope: !8)
!64 = !DILocation(line: 73, column: 11, scope: !8)
!65 = !DILocation(line: 75, column: 11, scope: !8)
!66 = !DILocation(line: 76, column: 11, scope: !8)
!67 = !DILocation(line: 77, column: 11, scope: !8)
!68 = !DILocation(line: 78, column: 11, scope: !8)
!69 = !DILocation(line: 80, column: 11, scope: !8)
!70 = !DILocation(line: 81, column: 11, scope: !8)
!71 = !DILocation(line: 82, column: 11, scope: !8)
!72 = !DILocation(line: 83, column: 11, scope: !8)
!73 = !DILocation(line: 84, column: 5, scope: !8)
!74 = !DILocation(line: 85, column: 11, scope: !8)
!75 = !DILocation(line: 86, column: 5, scope: !8)
!76 = !DILocation(line: 88, column: 11, scope: !8)
!77 = !DILocation(line: 89, column: 5, scope: !8)
!78 = !DILocation(line: 91, column: 5, scope: !8)
