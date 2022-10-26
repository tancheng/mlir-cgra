module attributes {llvm.data_layout = "", llvm.target_triple = "x86_64-unknown-linux-gnu", soda.container_module} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @cgra_fusion_add_max_add(!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64) attributes {sym_visibility = "private"}
  llvm.func @cgra_matmul(!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64) attributes {sym_visibility = "private"}
  llvm.func @main_graph(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr<f32>, %arg8: !llvm.ptr<f32>, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr<f32>, %arg15: !llvm.ptr<f32>, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64, %arg21: !llvm.ptr<f32>, %arg22: !llvm.ptr<f32>, %arg23: i64, %arg24: i64, %arg25: i64, %arg26: i64, %arg27: i64, %arg28: !llvm.ptr<f32>, %arg29: !llvm.ptr<f32>, %arg30: i64, %arg31: i64, %arg32: i64, %arg33: i64, %arg34: i64) attributes {input_names = ["X0", "X1", "X2", "X3"], output_names = ["Z0"]} {
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
    %32 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %33 = llvm.insertvalue %arg28, %32[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %34 = llvm.insertvalue %arg29, %33[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %35 = llvm.insertvalue %arg30, %34[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %36 = llvm.insertvalue %arg31, %35[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %37 = llvm.insertvalue %arg33, %36[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %38 = llvm.insertvalue %arg32, %37[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %39 = llvm.insertvalue %arg34, %38[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(4 : index) : i64
    %42 = llvm.mlir.constant(8 : index) : i64
    %43 = llvm.mlir.constant(16 : index) : i64
    %44 = llvm.mlir.constant(0 : index) : i64
    %45 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %46 = llvm.mlir.constant(16 : index) : i64
    %47 = llvm.mlir.constant(16 : index) : i64
    %48 = llvm.mlir.constant(1 : index) : i64
    %49 = llvm.mlir.constant(256 : index) : i64
    %50 = llvm.mlir.null : !llvm.ptr<f32>
    %51 = llvm.getelementptr %50[%49] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %52 = llvm.ptrtoint %51 : !llvm.ptr<f32> to i64
    %53 = llvm.mlir.constant(128 : index) : i64
    %54 = llvm.add %52, %53  : i64
    %55 = llvm.call @malloc(%54) : (i64) -> !llvm.ptr<i8>
    %56 = llvm.bitcast %55 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %57 = llvm.ptrtoint %56 : !llvm.ptr<f32> to i64
    %58 = llvm.mlir.constant(1 : index) : i64
    %59 = llvm.sub %53, %58  : i64
    %60 = llvm.add %57, %59  : i64
    %61 = llvm.urem %60, %53  : i64
    %62 = llvm.sub %60, %61  : i64
    %63 = llvm.inttoptr %62 : i64 to !llvm.ptr<f32>
    %64 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %65 = llvm.insertvalue %56, %64[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %66 = llvm.insertvalue %63, %65[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %67 = llvm.mlir.constant(0 : index) : i64
    %68 = llvm.insertvalue %67, %66[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %69 = llvm.insertvalue %46, %68[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %70 = llvm.insertvalue %47, %69[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %71 = llvm.insertvalue %47, %70[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %72 = llvm.insertvalue %48, %71[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.br ^bb1(%44 : i64)
  ^bb1(%73: i64):  // 2 preds: ^bb0, ^bb9
    %74 = llvm.icmp "slt" %73, %43 : i64
    llvm.cond_br %74, ^bb2(%44 : i64), ^bb10
  ^bb2(%75: i64):  // 2 preds: ^bb1, ^bb8
    %76 = llvm.icmp "slt" %75, %43 : i64
    llvm.cond_br %76, ^bb3, ^bb9
  ^bb3:  // pred: ^bb2
    %77 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %78 = llvm.insertvalue %56, %77[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %79 = llvm.insertvalue %63, %78[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %80 = llvm.mul %73, %47  : i64
    %81 = llvm.add %67, %80  : i64
    %82 = llvm.mul %75, %48  : i64
    %83 = llvm.add %81, %82  : i64
    %84 = llvm.insertvalue %83, %79[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %85 = llvm.mlir.constant(8 : i64) : i64
    %86 = llvm.mlir.constant(1 : i64) : i64
    %87 = llvm.insertvalue %85, %84[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %88 = llvm.insertvalue %86, %87[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %89 = llvm.mlir.constant(4 : i64) : i64
    %90 = llvm.mlir.constant(16 : i64) : i64
    %91 = llvm.insertvalue %89, %88[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %92 = llvm.insertvalue %90, %91[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.br ^bb4(%44 : i64)
  ^bb4(%93: i64):  // 2 preds: ^bb3, ^bb7
    %94 = llvm.icmp "slt" %93, %41 : i64
    llvm.cond_br %94, ^bb5(%44 : i64), ^bb8
  ^bb5(%95: i64):  // 2 preds: ^bb4, ^bb6
    %96 = llvm.icmp "slt" %95, %42 : i64
    llvm.cond_br %96, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %97 = llvm.mlir.constant(16 : index) : i64
    %98 = llvm.mul %93, %97  : i64
    %99 = llvm.add %83, %98  : i64
    %100 = llvm.add %99, %95  : i64
    %101 = llvm.getelementptr %63[%100] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %45, %101 : !llvm.ptr<f32>
    %102 = llvm.add %95, %40  : i64
    llvm.br ^bb5(%102 : i64)
  ^bb7:  // pred: ^bb5
    %103 = llvm.add %93, %40  : i64
    llvm.br ^bb4(%103 : i64)
  ^bb8:  // pred: ^bb4
    %104 = llvm.add %75, %42  : i64
    llvm.br ^bb2(%104 : i64)
  ^bb9:  // pred: ^bb2
    %105 = llvm.add %73, %41  : i64
    llvm.br ^bb1(%105 : i64)
  ^bb10:  // pred: ^bb1
    %106 = llvm.mlir.constant(16 : index) : i64
    %107 = llvm.mlir.constant(16 : index) : i64
    %108 = llvm.mlir.constant(1 : index) : i64
    %109 = llvm.mlir.constant(256 : index) : i64
    %110 = llvm.mlir.null : !llvm.ptr<f32>
    %111 = llvm.getelementptr %110[%109] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %112 = llvm.ptrtoint %111 : !llvm.ptr<f32> to i64
    %113 = llvm.mlir.constant(128 : index) : i64
    %114 = llvm.add %112, %113  : i64
    %115 = llvm.call @malloc(%114) : (i64) -> !llvm.ptr<i8>
    %116 = llvm.bitcast %115 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %117 = llvm.ptrtoint %116 : !llvm.ptr<f32> to i64
    %118 = llvm.mlir.constant(1 : index) : i64
    %119 = llvm.sub %113, %118  : i64
    %120 = llvm.add %117, %119  : i64
    %121 = llvm.urem %120, %113  : i64
    %122 = llvm.sub %120, %121  : i64
    %123 = llvm.inttoptr %122 : i64 to !llvm.ptr<f32>
    %124 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %125 = llvm.insertvalue %116, %124[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %126 = llvm.insertvalue %123, %125[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %127 = llvm.mlir.constant(0 : index) : i64
    %128 = llvm.insertvalue %127, %126[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %129 = llvm.insertvalue %106, %128[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %130 = llvm.insertvalue %107, %129[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %131 = llvm.insertvalue %107, %130[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %132 = llvm.insertvalue %108, %131[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %133 = llvm.mlir.constant(1 : index) : i64
    %134 = llvm.mul %133, %46  : i64
    %135 = llvm.mul %134, %47  : i64
    %136 = llvm.mlir.null : !llvm.ptr<f32>
    %137 = llvm.mlir.constant(1 : index) : i64
    %138 = llvm.getelementptr %136[%137] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %139 = llvm.ptrtoint %138 : !llvm.ptr<f32> to i64
    %140 = llvm.mul %135, %139  : i64
    %141 = llvm.getelementptr %63[%67] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %142 = llvm.getelementptr %123[%127] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %143 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%142, %141, %140, %143) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i1) -> ()
    %144 = llvm.bitcast %56 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%144) : (!llvm.ptr<i8>) -> ()
    llvm.br ^bb11(%44 : i64)
  ^bb11(%145: i64):  // 2 preds: ^bb10, ^bb14
    %146 = llvm.icmp "slt" %145, %43 : i64
    llvm.cond_br %146, ^bb12(%44 : i64), ^bb15
  ^bb12(%147: i64):  // 2 preds: ^bb11, ^bb13
    %148 = llvm.icmp "slt" %147, %43 : i64
    llvm.cond_br %148, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %149 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %150 = llvm.extractvalue %7[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %151 = llvm.insertvalue %150, %149[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %152 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %153 = llvm.insertvalue %152, %151[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %154 = llvm.extractvalue %7[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %155 = llvm.extractvalue %7[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %156 = llvm.extractvalue %7[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %157 = llvm.mul %145, %154  : i64
    %158 = llvm.add %156, %157  : i64
    %159 = llvm.mlir.constant(0 : i64) : i64
    %160 = llvm.mul %159, %155  : i64
    %161 = llvm.add %158, %160  : i64
    %162 = llvm.insertvalue %161, %153[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %163 = llvm.mlir.constant(32 : i64) : i64
    %164 = llvm.mlir.constant(1 : i64) : i64
    %165 = llvm.insertvalue %163, %162[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %166 = llvm.insertvalue %164, %165[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %167 = llvm.mlir.constant(4 : i64) : i64
    %168 = llvm.mlir.constant(32 : i64) : i64
    %169 = llvm.insertvalue %167, %166[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %170 = llvm.insertvalue %168, %169[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %171 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %172 = llvm.extractvalue %15[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %173 = llvm.insertvalue %172, %171[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %174 = llvm.extractvalue %15[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %175 = llvm.insertvalue %174, %173[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %176 = llvm.extractvalue %15[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %177 = llvm.extractvalue %15[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %178 = llvm.extractvalue %15[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %179 = llvm.mlir.constant(0 : i64) : i64
    %180 = llvm.mul %179, %176  : i64
    %181 = llvm.add %178, %180  : i64
    %182 = llvm.mul %147, %177  : i64
    %183 = llvm.add %181, %182  : i64
    %184 = llvm.insertvalue %183, %175[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %185 = llvm.mlir.constant(8 : i64) : i64
    %186 = llvm.mlir.constant(1 : i64) : i64
    %187 = llvm.insertvalue %185, %184[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %188 = llvm.insertvalue %186, %187[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %189 = llvm.mlir.constant(32 : i64) : i64
    %190 = llvm.mlir.constant(16 : i64) : i64
    %191 = llvm.insertvalue %189, %188[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %192 = llvm.insertvalue %190, %191[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %193 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %194 = llvm.insertvalue %116, %193[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %195 = llvm.insertvalue %123, %194[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %196 = llvm.mul %145, %107  : i64
    %197 = llvm.add %127, %196  : i64
    %198 = llvm.mul %147, %108  : i64
    %199 = llvm.add %197, %198  : i64
    %200 = llvm.insertvalue %199, %195[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %201 = llvm.mlir.constant(8 : i64) : i64
    %202 = llvm.mlir.constant(1 : i64) : i64
    %203 = llvm.insertvalue %201, %200[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %204 = llvm.insertvalue %202, %203[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %205 = llvm.mlir.constant(4 : i64) : i64
    %206 = llvm.mlir.constant(16 : i64) : i64
    %207 = llvm.insertvalue %205, %204[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %208 = llvm.insertvalue %206, %207[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.call @cgra_matmul(%150, %152, %161, %167, %163, %168, %164, %172, %174, %183, %189, %185, %190, %186, %116, %123, %199, %205, %201, %206, %202) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64) -> ()
    %209 = llvm.add %147, %42  : i64
    llvm.br ^bb12(%209 : i64)
  ^bb14:  // pred: ^bb12
    %210 = llvm.add %145, %41  : i64
    llvm.br ^bb11(%210 : i64)
  ^bb15:  // pred: ^bb11
    %211 = llvm.mlir.constant(16 : index) : i64
    %212 = llvm.mlir.constant(16 : index) : i64
    %213 = llvm.mlir.constant(1 : index) : i64
    %214 = llvm.mlir.constant(256 : index) : i64
    %215 = llvm.mlir.null : !llvm.ptr<f32>
    %216 = llvm.getelementptr %215[%214] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %217 = llvm.ptrtoint %216 : !llvm.ptr<f32> to i64
    %218 = llvm.mlir.constant(128 : index) : i64
    %219 = llvm.add %217, %218  : i64
    %220 = llvm.call @malloc(%219) : (i64) -> !llvm.ptr<i8>
    %221 = llvm.bitcast %220 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %222 = llvm.ptrtoint %221 : !llvm.ptr<f32> to i64
    %223 = llvm.mlir.constant(1 : index) : i64
    %224 = llvm.sub %218, %223  : i64
    %225 = llvm.add %222, %224  : i64
    %226 = llvm.urem %225, %218  : i64
    %227 = llvm.sub %225, %226  : i64
    %228 = llvm.inttoptr %227 : i64 to !llvm.ptr<f32>
    %229 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %230 = llvm.insertvalue %221, %229[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %231 = llvm.insertvalue %228, %230[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %232 = llvm.mlir.constant(0 : index) : i64
    %233 = llvm.insertvalue %232, %231[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %234 = llvm.insertvalue %211, %233[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %235 = llvm.insertvalue %212, %234[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %236 = llvm.insertvalue %212, %235[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %237 = llvm.insertvalue %213, %236[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.br ^bb16(%44 : i64)
  ^bb16(%238: i64):  // 2 preds: ^bb15, ^bb19
    %239 = llvm.icmp "slt" %238, %43 : i64
    llvm.cond_br %239, ^bb17(%44 : i64), ^bb20
  ^bb17(%240: i64):  // 2 preds: ^bb16, ^bb18
    %241 = llvm.icmp "slt" %240, %43 : i64
    llvm.cond_br %241, ^bb18, ^bb19
  ^bb18:  // pred: ^bb17
    %242 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %243 = llvm.insertvalue %116, %242[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %244 = llvm.insertvalue %123, %243[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %245 = llvm.mul %238, %107  : i64
    %246 = llvm.add %127, %245  : i64
    %247 = llvm.mul %240, %108  : i64
    %248 = llvm.add %246, %247  : i64
    %249 = llvm.insertvalue %248, %244[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %250 = llvm.mlir.constant(8 : i64) : i64
    %251 = llvm.mlir.constant(1 : i64) : i64
    %252 = llvm.insertvalue %250, %249[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %253 = llvm.insertvalue %251, %252[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %254 = llvm.mlir.constant(4 : i64) : i64
    %255 = llvm.mlir.constant(16 : i64) : i64
    %256 = llvm.insertvalue %254, %253[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %257 = llvm.insertvalue %255, %256[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %258 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %259 = llvm.extractvalue %23[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %260 = llvm.insertvalue %259, %258[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %261 = llvm.extractvalue %23[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %262 = llvm.insertvalue %261, %260[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %263 = llvm.extractvalue %23[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %264 = llvm.extractvalue %23[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %265 = llvm.extractvalue %23[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %266 = llvm.mul %238, %263  : i64
    %267 = llvm.add %265, %266  : i64
    %268 = llvm.mul %240, %264  : i64
    %269 = llvm.add %267, %268  : i64
    %270 = llvm.insertvalue %269, %262[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %271 = llvm.mlir.constant(8 : i64) : i64
    %272 = llvm.mlir.constant(1 : i64) : i64
    %273 = llvm.insertvalue %271, %270[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %274 = llvm.insertvalue %272, %273[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %275 = llvm.mlir.constant(4 : i64) : i64
    %276 = llvm.mlir.constant(16 : i64) : i64
    %277 = llvm.insertvalue %275, %274[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %278 = llvm.insertvalue %276, %277[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %279 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %280 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %281 = llvm.insertvalue %280, %279[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %282 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %283 = llvm.insertvalue %282, %281[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %284 = llvm.extractvalue %31[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %285 = llvm.extractvalue %31[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %286 = llvm.extractvalue %31[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %287 = llvm.mul %238, %284  : i64
    %288 = llvm.add %286, %287  : i64
    %289 = llvm.mul %240, %285  : i64
    %290 = llvm.add %288, %289  : i64
    %291 = llvm.insertvalue %290, %283[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %292 = llvm.mlir.constant(8 : i64) : i64
    %293 = llvm.mlir.constant(1 : i64) : i64
    %294 = llvm.insertvalue %292, %291[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %295 = llvm.insertvalue %293, %294[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %296 = llvm.mlir.constant(4 : i64) : i64
    %297 = llvm.mlir.constant(16 : i64) : i64
    %298 = llvm.insertvalue %296, %295[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %299 = llvm.insertvalue %297, %298[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %300 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %301 = llvm.insertvalue %221, %300[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %302 = llvm.insertvalue %228, %301[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %303 = llvm.mul %238, %212  : i64
    %304 = llvm.add %232, %303  : i64
    %305 = llvm.mul %240, %213  : i64
    %306 = llvm.add %304, %305  : i64
    %307 = llvm.insertvalue %306, %302[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %308 = llvm.mlir.constant(8 : i64) : i64
    %309 = llvm.mlir.constant(1 : i64) : i64
    %310 = llvm.insertvalue %308, %307[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %311 = llvm.insertvalue %309, %310[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %312 = llvm.mlir.constant(4 : i64) : i64
    %313 = llvm.mlir.constant(16 : i64) : i64
    %314 = llvm.insertvalue %312, %311[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %315 = llvm.insertvalue %313, %314[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.call @cgra_fusion_add_max_add(%116, %123, %248, %254, %250, %255, %251, %259, %261, %269, %275, %271, %276, %272, %280, %282, %290, %296, %292, %297, %293, %221, %228, %306, %312, %308, %313, %309) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64) -> ()
    %316 = llvm.add %240, %42  : i64
    llvm.br ^bb17(%316 : i64)
  ^bb19:  // pred: ^bb17
    %317 = llvm.add %238, %41  : i64
    llvm.br ^bb16(%317 : i64)
  ^bb20:  // pred: ^bb16
    %318 = llvm.bitcast %116 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%318) : (!llvm.ptr<i8>) -> ()
    %319 = llvm.mlir.constant(1 : index) : i64
    %320 = llvm.mul %319, %211  : i64
    %321 = llvm.mul %320, %212  : i64
    %322 = llvm.mlir.null : !llvm.ptr<f32>
    %323 = llvm.mlir.constant(1 : index) : i64
    %324 = llvm.getelementptr %322[%323] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %325 = llvm.ptrtoint %324 : !llvm.ptr<f32> to i64
    %326 = llvm.mul %321, %325  : i64
    %327 = llvm.getelementptr %228[%232] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %328 = llvm.extractvalue %39[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %329 = llvm.extractvalue %39[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %330 = llvm.getelementptr %328[%329] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %331 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%330, %327, %326, %331) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i1) -> ()
    llvm.return
  }
}

