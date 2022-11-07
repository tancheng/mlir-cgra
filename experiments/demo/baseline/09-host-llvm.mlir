module attributes {llvm.data_layout = "", llvm.target_triple = "x86_64-unknown-linux-gnu", soda.container_module} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @cgra_generic_0(!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64) attributes {sym_visibility = "private"}
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
    %42 = llvm.mlir.constant(16 : index) : i64
    %43 = llvm.mlir.constant(0 : index) : i64
    %44 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %45 = llvm.mlir.constant(16 : index) : i64
    %46 = llvm.mlir.constant(16 : index) : i64
    %47 = llvm.mlir.constant(1 : index) : i64
    %48 = llvm.mlir.constant(256 : index) : i64
    %49 = llvm.mlir.null : !llvm.ptr<f32>
    %50 = llvm.getelementptr %49[%48] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %51 = llvm.ptrtoint %50 : !llvm.ptr<f32> to i64
    %52 = llvm.mlir.constant(128 : index) : i64
    %53 = llvm.add %51, %52  : i64
    %54 = llvm.call @malloc(%53) : (i64) -> !llvm.ptr<i8>
    %55 = llvm.bitcast %54 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %56 = llvm.ptrtoint %55 : !llvm.ptr<f32> to i64
    %57 = llvm.mlir.constant(1 : index) : i64
    %58 = llvm.sub %52, %57  : i64
    %59 = llvm.add %56, %58  : i64
    %60 = llvm.urem %59, %52  : i64
    %61 = llvm.sub %59, %60  : i64
    %62 = llvm.inttoptr %61 : i64 to !llvm.ptr<f32>
    %63 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %64 = llvm.insertvalue %55, %63[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %65 = llvm.insertvalue %62, %64[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %66 = llvm.mlir.constant(0 : index) : i64
    %67 = llvm.insertvalue %66, %65[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %68 = llvm.insertvalue %45, %67[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %69 = llvm.insertvalue %46, %68[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %70 = llvm.insertvalue %46, %69[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %71 = llvm.insertvalue %47, %70[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.br ^bb1(%43 : i64)
  ^bb1(%72: i64):  // 2 preds: ^bb0, ^bb9
    %73 = llvm.icmp "slt" %72, %42 : i64
    llvm.cond_br %73, ^bb2(%43 : i64), ^bb10
  ^bb2(%74: i64):  // 2 preds: ^bb1, ^bb8
    %75 = llvm.icmp "slt" %74, %42 : i64
    llvm.cond_br %75, ^bb3, ^bb9
  ^bb3:  // pred: ^bb2
    %76 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %77 = llvm.insertvalue %55, %76[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %78 = llvm.insertvalue %62, %77[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %79 = llvm.mul %72, %46  : i64
    %80 = llvm.add %66, %79  : i64
    %81 = llvm.mul %74, %47  : i64
    %82 = llvm.add %80, %81  : i64
    %83 = llvm.insertvalue %82, %78[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %84 = llvm.mlir.constant(4 : i64) : i64
    %85 = llvm.mlir.constant(1 : i64) : i64
    %86 = llvm.insertvalue %84, %83[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %87 = llvm.insertvalue %85, %86[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %88 = llvm.mlir.constant(4 : i64) : i64
    %89 = llvm.mlir.constant(16 : i64) : i64
    %90 = llvm.insertvalue %88, %87[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %91 = llvm.insertvalue %89, %90[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.br ^bb4(%43 : i64)
  ^bb4(%92: i64):  // 2 preds: ^bb3, ^bb7
    %93 = llvm.icmp "slt" %92, %41 : i64
    llvm.cond_br %93, ^bb5(%43 : i64), ^bb8
  ^bb5(%94: i64):  // 2 preds: ^bb4, ^bb6
    %95 = llvm.icmp "slt" %94, %41 : i64
    llvm.cond_br %95, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %96 = llvm.mlir.constant(16 : index) : i64
    %97 = llvm.mul %92, %96  : i64
    %98 = llvm.add %82, %97  : i64
    %99 = llvm.add %98, %94  : i64
    %100 = llvm.getelementptr %62[%99] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %44, %100 : !llvm.ptr<f32>
    %101 = llvm.add %94, %40  : i64
    llvm.br ^bb5(%101 : i64)
  ^bb7:  // pred: ^bb5
    %102 = llvm.add %92, %40  : i64
    llvm.br ^bb4(%102 : i64)
  ^bb8:  // pred: ^bb4
    %103 = llvm.add %74, %41  : i64
    llvm.br ^bb2(%103 : i64)
  ^bb9:  // pred: ^bb2
    %104 = llvm.add %72, %41  : i64
    llvm.br ^bb1(%104 : i64)
  ^bb10:  // pred: ^bb1
    %105 = llvm.mlir.constant(16 : index) : i64
    %106 = llvm.mlir.constant(16 : index) : i64
    %107 = llvm.mlir.constant(1 : index) : i64
    %108 = llvm.mlir.constant(256 : index) : i64
    %109 = llvm.mlir.null : !llvm.ptr<f32>
    %110 = llvm.getelementptr %109[%108] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %111 = llvm.ptrtoint %110 : !llvm.ptr<f32> to i64
    %112 = llvm.mlir.constant(128 : index) : i64
    %113 = llvm.add %111, %112  : i64
    %114 = llvm.call @malloc(%113) : (i64) -> !llvm.ptr<i8>
    %115 = llvm.bitcast %114 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %116 = llvm.ptrtoint %115 : !llvm.ptr<f32> to i64
    %117 = llvm.mlir.constant(1 : index) : i64
    %118 = llvm.sub %112, %117  : i64
    %119 = llvm.add %116, %118  : i64
    %120 = llvm.urem %119, %112  : i64
    %121 = llvm.sub %119, %120  : i64
    %122 = llvm.inttoptr %121 : i64 to !llvm.ptr<f32>
    %123 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %124 = llvm.insertvalue %115, %123[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %125 = llvm.insertvalue %122, %124[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %126 = llvm.mlir.constant(0 : index) : i64
    %127 = llvm.insertvalue %126, %125[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %128 = llvm.insertvalue %105, %127[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %129 = llvm.insertvalue %106, %128[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %130 = llvm.insertvalue %106, %129[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %131 = llvm.insertvalue %107, %130[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %132 = llvm.mlir.constant(1 : index) : i64
    %133 = llvm.mul %132, %45  : i64
    %134 = llvm.mul %133, %46  : i64
    %135 = llvm.mlir.null : !llvm.ptr<f32>
    %136 = llvm.mlir.constant(1 : index) : i64
    %137 = llvm.getelementptr %135[%136] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %138 = llvm.ptrtoint %137 : !llvm.ptr<f32> to i64
    %139 = llvm.mul %134, %138  : i64
    %140 = llvm.getelementptr %62[%66] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %141 = llvm.getelementptr %122[%126] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %142 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%141, %140, %139, %142) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i1) -> ()
    %143 = llvm.bitcast %55 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%143) : (!llvm.ptr<i8>) -> ()
    llvm.br ^bb11(%43 : i64)
  ^bb11(%144: i64):  // 2 preds: ^bb10, ^bb14
    %145 = llvm.icmp "slt" %144, %42 : i64
    llvm.cond_br %145, ^bb12(%43 : i64), ^bb15
  ^bb12(%146: i64):  // 2 preds: ^bb11, ^bb13
    %147 = llvm.icmp "slt" %146, %42 : i64
    llvm.cond_br %147, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %148 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %149 = llvm.extractvalue %7[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %150 = llvm.insertvalue %149, %148[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %151 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %152 = llvm.insertvalue %151, %150[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %153 = llvm.extractvalue %7[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %154 = llvm.extractvalue %7[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %155 = llvm.extractvalue %7[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %156 = llvm.mul %144, %153  : i64
    %157 = llvm.add %155, %156  : i64
    %158 = llvm.mlir.constant(0 : i64) : i64
    %159 = llvm.mul %158, %154  : i64
    %160 = llvm.add %157, %159  : i64
    %161 = llvm.insertvalue %160, %152[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %162 = llvm.mlir.constant(32 : i64) : i64
    %163 = llvm.mlir.constant(1 : i64) : i64
    %164 = llvm.insertvalue %162, %161[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %165 = llvm.insertvalue %163, %164[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %166 = llvm.mlir.constant(4 : i64) : i64
    %167 = llvm.mlir.constant(32 : i64) : i64
    %168 = llvm.insertvalue %166, %165[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %169 = llvm.insertvalue %167, %168[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %170 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %171 = llvm.extractvalue %15[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %172 = llvm.insertvalue %171, %170[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %173 = llvm.extractvalue %15[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %174 = llvm.insertvalue %173, %172[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %175 = llvm.extractvalue %15[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %176 = llvm.extractvalue %15[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %177 = llvm.extractvalue %15[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %178 = llvm.mlir.constant(0 : i64) : i64
    %179 = llvm.mul %178, %175  : i64
    %180 = llvm.add %177, %179  : i64
    %181 = llvm.mul %146, %176  : i64
    %182 = llvm.add %180, %181  : i64
    %183 = llvm.insertvalue %182, %174[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %184 = llvm.mlir.constant(4 : i64) : i64
    %185 = llvm.mlir.constant(1 : i64) : i64
    %186 = llvm.insertvalue %184, %183[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %187 = llvm.insertvalue %185, %186[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %188 = llvm.mlir.constant(32 : i64) : i64
    %189 = llvm.mlir.constant(16 : i64) : i64
    %190 = llvm.insertvalue %188, %187[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %191 = llvm.insertvalue %189, %190[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %192 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %193 = llvm.insertvalue %115, %192[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %194 = llvm.insertvalue %122, %193[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %195 = llvm.mul %144, %106  : i64
    %196 = llvm.add %126, %195  : i64
    %197 = llvm.mul %146, %107  : i64
    %198 = llvm.add %196, %197  : i64
    %199 = llvm.insertvalue %198, %194[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %200 = llvm.mlir.constant(4 : i64) : i64
    %201 = llvm.mlir.constant(1 : i64) : i64
    %202 = llvm.insertvalue %200, %199[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %203 = llvm.insertvalue %201, %202[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %204 = llvm.mlir.constant(4 : i64) : i64
    %205 = llvm.mlir.constant(16 : i64) : i64
    %206 = llvm.insertvalue %204, %203[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %207 = llvm.insertvalue %205, %206[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.call @cgra_matmul(%149, %151, %160, %166, %162, %167, %163, %171, %173, %182, %188, %184, %189, %185, %115, %122, %198, %204, %200, %205, %201) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64) -> ()
    %208 = llvm.add %146, %41  : i64
    llvm.br ^bb12(%208 : i64)
  ^bb14:  // pred: ^bb12
    %209 = llvm.add %144, %41  : i64
    llvm.br ^bb11(%209 : i64)
  ^bb15:  // pred: ^bb11
    %210 = llvm.mlir.constant(16 : index) : i64
    %211 = llvm.mlir.constant(16 : index) : i64
    %212 = llvm.mlir.constant(1 : index) : i64
    %213 = llvm.mlir.constant(256 : index) : i64
    %214 = llvm.mlir.null : !llvm.ptr<f32>
    %215 = llvm.getelementptr %214[%213] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %216 = llvm.ptrtoint %215 : !llvm.ptr<f32> to i64
    %217 = llvm.mlir.constant(128 : index) : i64
    %218 = llvm.add %216, %217  : i64
    %219 = llvm.call @malloc(%218) : (i64) -> !llvm.ptr<i8>
    %220 = llvm.bitcast %219 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %221 = llvm.ptrtoint %220 : !llvm.ptr<f32> to i64
    %222 = llvm.mlir.constant(1 : index) : i64
    %223 = llvm.sub %217, %222  : i64
    %224 = llvm.add %221, %223  : i64
    %225 = llvm.urem %224, %217  : i64
    %226 = llvm.sub %224, %225  : i64
    %227 = llvm.inttoptr %226 : i64 to !llvm.ptr<f32>
    %228 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %229 = llvm.insertvalue %220, %228[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %230 = llvm.insertvalue %227, %229[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %231 = llvm.mlir.constant(0 : index) : i64
    %232 = llvm.insertvalue %231, %230[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %233 = llvm.insertvalue %210, %232[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %234 = llvm.insertvalue %211, %233[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %235 = llvm.insertvalue %211, %234[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %236 = llvm.insertvalue %212, %235[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.br ^bb16(%43 : i64)
  ^bb16(%237: i64):  // 2 preds: ^bb15, ^bb19
    %238 = llvm.icmp "slt" %237, %42 : i64
    llvm.cond_br %238, ^bb17(%43 : i64), ^bb20
  ^bb17(%239: i64):  // 2 preds: ^bb16, ^bb18
    %240 = llvm.icmp "slt" %239, %42 : i64
    llvm.cond_br %240, ^bb18, ^bb19
  ^bb18:  // pred: ^bb17
    %241 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %242 = llvm.insertvalue %115, %241[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %243 = llvm.insertvalue %122, %242[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %244 = llvm.mul %237, %106  : i64
    %245 = llvm.add %126, %244  : i64
    %246 = llvm.mul %239, %107  : i64
    %247 = llvm.add %245, %246  : i64
    %248 = llvm.insertvalue %247, %243[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %249 = llvm.mlir.constant(4 : i64) : i64
    %250 = llvm.mlir.constant(1 : i64) : i64
    %251 = llvm.insertvalue %249, %248[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %252 = llvm.insertvalue %250, %251[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %253 = llvm.mlir.constant(4 : i64) : i64
    %254 = llvm.mlir.constant(16 : i64) : i64
    %255 = llvm.insertvalue %253, %252[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %256 = llvm.insertvalue %254, %255[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %257 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %258 = llvm.extractvalue %23[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %259 = llvm.insertvalue %258, %257[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %260 = llvm.extractvalue %23[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %261 = llvm.insertvalue %260, %259[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %262 = llvm.extractvalue %23[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %263 = llvm.extractvalue %23[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %264 = llvm.extractvalue %23[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %265 = llvm.mul %237, %262  : i64
    %266 = llvm.add %264, %265  : i64
    %267 = llvm.mul %239, %263  : i64
    %268 = llvm.add %266, %267  : i64
    %269 = llvm.insertvalue %268, %261[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %270 = llvm.mlir.constant(4 : i64) : i64
    %271 = llvm.mlir.constant(1 : i64) : i64
    %272 = llvm.insertvalue %270, %269[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %273 = llvm.insertvalue %271, %272[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %274 = llvm.mlir.constant(4 : i64) : i64
    %275 = llvm.mlir.constant(16 : i64) : i64
    %276 = llvm.insertvalue %274, %273[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %277 = llvm.insertvalue %275, %276[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %278 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %279 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %280 = llvm.insertvalue %279, %278[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %281 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %282 = llvm.insertvalue %281, %280[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %283 = llvm.extractvalue %31[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %284 = llvm.extractvalue %31[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %285 = llvm.extractvalue %31[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %286 = llvm.mul %237, %283  : i64
    %287 = llvm.add %285, %286  : i64
    %288 = llvm.mul %239, %284  : i64
    %289 = llvm.add %287, %288  : i64
    %290 = llvm.insertvalue %289, %282[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %291 = llvm.mlir.constant(4 : i64) : i64
    %292 = llvm.mlir.constant(1 : i64) : i64
    %293 = llvm.insertvalue %291, %290[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %294 = llvm.insertvalue %292, %293[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %295 = llvm.mlir.constant(4 : i64) : i64
    %296 = llvm.mlir.constant(16 : i64) : i64
    %297 = llvm.insertvalue %295, %294[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %298 = llvm.insertvalue %296, %297[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %299 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %300 = llvm.insertvalue %220, %299[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %301 = llvm.insertvalue %227, %300[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %302 = llvm.mul %237, %211  : i64
    %303 = llvm.add %231, %302  : i64
    %304 = llvm.mul %239, %212  : i64
    %305 = llvm.add %303, %304  : i64
    %306 = llvm.insertvalue %305, %301[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %307 = llvm.mlir.constant(4 : i64) : i64
    %308 = llvm.mlir.constant(1 : i64) : i64
    %309 = llvm.insertvalue %307, %306[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %310 = llvm.insertvalue %308, %309[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %311 = llvm.mlir.constant(4 : i64) : i64
    %312 = llvm.mlir.constant(16 : i64) : i64
    %313 = llvm.insertvalue %311, %310[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %314 = llvm.insertvalue %312, %313[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    llvm.call @cgra_generic_0(%115, %122, %247, %253, %249, %254, %250, %258, %260, %268, %274, %270, %275, %271, %279, %281, %289, %295, %291, %296, %292, %220, %227, %305, %311, %307, %312, %308) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64) -> ()
    %315 = llvm.add %239, %41  : i64
    llvm.br ^bb17(%315 : i64)
  ^bb19:  // pred: ^bb17
    %316 = llvm.add %237, %41  : i64
    llvm.br ^bb16(%316 : i64)
  ^bb20:  // pred: ^bb16
    %317 = llvm.bitcast %115 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%317) : (!llvm.ptr<i8>) -> ()
    %318 = llvm.mlir.constant(1 : index) : i64
    %319 = llvm.mul %318, %210  : i64
    %320 = llvm.mul %319, %211  : i64
    %321 = llvm.mlir.null : !llvm.ptr<f32>
    %322 = llvm.mlir.constant(1 : index) : i64
    %323 = llvm.getelementptr %321[%322] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %324 = llvm.ptrtoint %323 : !llvm.ptr<f32> to i64
    %325 = llvm.mul %320, %324  : i64
    %326 = llvm.getelementptr %227[%231] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %327 = llvm.extractvalue %39[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %328 = llvm.extractvalue %39[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %329 = llvm.getelementptr %327[%328] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %330 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%329, %326, %325, %330) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i1) -> ()
    llvm.return
  }
}

