module attributes {llvm.data_layout = "", llvm.target_triple = "x86_64-unknown-linux-gnu", soda.bambu.container_module, soda.container_module} {
  llvm.func @generic_0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr<f32>, %arg8: !llvm.ptr<f32>, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr<f32>, %arg15: !llvm.ptr<f32>, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64, %arg21: !llvm.ptr<f32>, %arg22: !llvm.ptr<f32>, %arg23: i64, %arg24: i64, %arg25: i64, %arg26: i64, %arg27: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %8 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %arg7, %8[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.insertvalue %arg8, %9[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %11 = llvm.insertvalue %arg9, %10[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %12 = llvm.insertvalue %arg10, %11[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %13 = llvm.insertvalue %arg12, %12[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %14 = llvm.insertvalue %arg11, %13[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %15 = llvm.insertvalue %arg13, %14[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %16 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.insertvalue %arg14, %16[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %18 = llvm.insertvalue %arg15, %17[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %19 = llvm.insertvalue %arg16, %18[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %20 = llvm.insertvalue %arg17, %19[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %21 = llvm.insertvalue %arg19, %20[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %22 = llvm.insertvalue %arg18, %21[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %23 = llvm.insertvalue %arg20, %22[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %24 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %25 = llvm.insertvalue %arg21, %24[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %26 = llvm.insertvalue %arg22, %25[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %27 = llvm.insertvalue %arg23, %26[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %28 = llvm.insertvalue %arg24, %27[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %29 = llvm.insertvalue %arg26, %28[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %30 = llvm.insertvalue %arg25, %29[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %31 = llvm.insertvalue %arg27, %30[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.mlir.constant(4 : index) : i64
    %34 = llvm.mlir.constant(0 : index) : i64
    %35 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.br ^bb1(%34 : i64)
  ^bb1(%36: i64):  // 2 preds: ^bb0, ^bb4
    %37 = llvm.icmp "slt" %36, %33 : i64
    llvm.cond_br %37, ^bb2(%34 : i64), ^bb5
  ^bb2(%38: i64):  // 2 preds: ^bb1, ^bb3
    %39 = llvm.icmp "slt" %38, %33 : i64
    llvm.cond_br %39, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %40 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %41 = llvm.extractvalue %7[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %42 = llvm.mlir.constant(16 : index) : i64
    %43 = llvm.mul %36, %42  : i64
    %44 = llvm.add %41, %43  : i64
    %45 = llvm.add %44, %38  : i64
    %46 = llvm.getelementptr %40[%45] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %47 = llvm.load %46 : !llvm.ptr<f32>
    %48 = llvm.extractvalue %15[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %49 = llvm.extractvalue %15[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %50 = llvm.mlir.constant(16 : index) : i64
    %51 = llvm.mul %36, %50  : i64
    %52 = llvm.add %49, %51  : i64
    %53 = llvm.add %52, %38  : i64
    %54 = llvm.getelementptr %48[%53] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %55 = llvm.load %54 : !llvm.ptr<f32>
    %56 = llvm.extractvalue %23[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %57 = llvm.extractvalue %23[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %58 = llvm.mlir.constant(16 : index) : i64
    %59 = llvm.mul %36, %58  : i64
    %60 = llvm.add %57, %59  : i64
    %61 = llvm.add %60, %38  : i64
    %62 = llvm.getelementptr %56[%61] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %63 = llvm.load %62 : !llvm.ptr<f32>
    %64 = llvm.fadd %47, %55  : f32
    %65 = llvm.fcmp "ugt" %64, %35 : f32
    %66 = llvm.select %65, %64, %35 : i1, f32
    %67 = llvm.mlir.constant(false) : i1
    %68 = llvm.select %67, %35, %66 : i1, f32
    %69 = llvm.fadd %68, %63  : f32
    %70 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %71 = llvm.extractvalue %31[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %72 = llvm.mlir.constant(16 : index) : i64
    %73 = llvm.mul %36, %72  : i64
    %74 = llvm.add %71, %73  : i64
    %75 = llvm.add %74, %38  : i64
    %76 = llvm.getelementptr %70[%75] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %69, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %32  : i64
    llvm.br ^bb2(%77 : i64)
  ^bb4:  // pred: ^bb2
    %78 = llvm.add %36, %32  : i64
    llvm.br ^bb1(%78 : i64)
  ^bb5:  // pred: ^bb1
    llvm.return
  }
}

