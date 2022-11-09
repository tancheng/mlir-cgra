module attributes {llvm.data_layout = "", soda.bambu.container_module, soda.container_module, tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 1087 : i32}} {
  llvm.func @main_kernel(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %7 = llvm.mlir.constant(32 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %9 = llvm.mlir.constant(4 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %11 = llvm.mlir.constant(8 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %13 = llvm.mlir.constant(8 : index) : i64
    %14 = llvm.insertvalue %13, %12[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.insertvalue %15, %14[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %17 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %18 = llvm.insertvalue %arg1, %17[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %19 = llvm.insertvalue %arg1, %18[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %22 = llvm.mlir.constant(1 : index) : i64
    %23 = llvm.insertvalue %22, %21[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %24 = llvm.mlir.constant(32 : index) : i64
    %25 = llvm.insertvalue %24, %23[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %26 = llvm.mlir.constant(8 : index) : i64
    %27 = llvm.insertvalue %26, %25[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %28 = llvm.mlir.constant(4 : index) : i64
    %29 = llvm.insertvalue %28, %27[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %30 = llvm.mlir.constant(4 : index) : i64
    %31 = llvm.insertvalue %30, %29[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.insertvalue %32, %31[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %34 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %35 = llvm.insertvalue %arg2, %34[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %36 = llvm.insertvalue %arg2, %35[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %37 = llvm.mlir.constant(0 : index) : i64
    %38 = llvm.insertvalue %37, %36[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %39 = llvm.mlir.constant(1 : index) : i64
    %40 = llvm.insertvalue %39, %38[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %41 = llvm.mlir.constant(16 : index) : i64
    %42 = llvm.insertvalue %41, %40[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %43 = llvm.mlir.constant(4 : index) : i64
    %44 = llvm.insertvalue %43, %42[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %45 = llvm.mlir.constant(4 : index) : i64
    %46 = llvm.insertvalue %45, %44[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %47 = llvm.mlir.constant(4 : index) : i64
    %48 = llvm.insertvalue %47, %46[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %49 = llvm.mlir.constant(1 : index) : i64
    %50 = llvm.insertvalue %49, %48[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %51 = llvm.mlir.constant(8 : index) : i64
    %52 = llvm.mlir.constant(4 : index) : i64
    %53 = llvm.mlir.constant(1 : index) : i64
    %54 = llvm.mlir.constant(0 : index) : i64
    llvm.br ^bb1(%54 : i64)
  ^bb1(%55: i64):  // 2 preds: ^bb0, ^bb6
    %56 = llvm.icmp "slt" %55, %52 : i64
    llvm.cond_br %56, ^bb2(%54 : i64), ^bb7
  ^bb2(%57: i64):  // 2 preds: ^bb1, ^bb5
    %58 = llvm.icmp "slt" %57, %52 : i64
    llvm.cond_br %58, ^bb3(%54 : i64), ^bb6
  ^bb3(%59: i64):  // 2 preds: ^bb2, ^bb4
    %60 = llvm.icmp "slt" %59, %51 : i64
    llvm.cond_br %60, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %61 = llvm.extractvalue %16[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %62 = llvm.mlir.constant(32 : index) : i64
    %63 = llvm.mul %54, %62  : i64
    %64 = llvm.mlir.constant(8 : index) : i64
    %65 = llvm.mul %55, %64  : i64
    %66 = llvm.add %63, %65  : i64
    %67 = llvm.add %66, %59  : i64
    %68 = llvm.getelementptr %61[%67] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %69 = llvm.load %68 : !llvm.ptr<f32>
    %70 = llvm.extractvalue %33[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %71 = llvm.mlir.constant(32 : index) : i64
    %72 = llvm.mul %54, %71  : i64
    %73 = llvm.mlir.constant(4 : index) : i64
    %74 = llvm.mul %59, %73  : i64
    %75 = llvm.add %72, %74  : i64
    %76 = llvm.add %75, %57  : i64
    %77 = llvm.getelementptr %70[%76] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %78 = llvm.load %77 : !llvm.ptr<f32>
    %79 = llvm.extractvalue %50[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %80 = llvm.mlir.constant(16 : index) : i64
    %81 = llvm.mul %54, %80  : i64
    %82 = llvm.mlir.constant(4 : index) : i64
    %83 = llvm.mul %55, %82  : i64
    %84 = llvm.add %81, %83  : i64
    %85 = llvm.add %84, %57  : i64
    %86 = llvm.getelementptr %79[%85] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %87 = llvm.load %86 : !llvm.ptr<f32>
    %88 = llvm.fmul %69, %78  : f32
    %89 = llvm.fadd %87, %88  : f32
    %90 = llvm.extractvalue %50[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %91 = llvm.mlir.constant(16 : index) : i64
    %92 = llvm.mul %54, %91  : i64
    %93 = llvm.mlir.constant(4 : index) : i64
    %94 = llvm.mul %55, %93  : i64
    %95 = llvm.add %92, %94  : i64
    %96 = llvm.add %95, %57  : i64
    %97 = llvm.getelementptr %90[%96] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %89, %97 : !llvm.ptr<f32>
    %98 = llvm.add %59, %53  : i64
    llvm.br ^bb3(%98 : i64)
  ^bb5:  // pred: ^bb3
    %99 = llvm.add %57, %53  : i64
    llvm.br ^bb2(%99 : i64)
  ^bb6:  // pred: ^bb2
    %100 = llvm.add %55, %53  : i64
    llvm.br ^bb1(%100 : i64)
  ^bb7:  // pred: ^bb1
    llvm.return
  }
}

