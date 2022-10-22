; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

declare void @cgra_fusion(ptr, ptr, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64)

declare void @cgra_matmul(ptr, ptr, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64)

define void @main_graph(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20, ptr %21, ptr %22, i64 %23, i64 %24, i64 %25, i64 %26, i64 %27, ptr %28, ptr %29, i64 %30, i64 %31, i64 %32, i64 %33, i64 %34) !dbg !3 {
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0, !dbg !7
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, ptr %1, 1, !dbg !9
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %2, 2, !dbg !10
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %3, 3, 0, !dbg !11
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 %5, 4, 0, !dbg !12
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %4, 3, 1, !dbg !13
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %6, 4, 1, !dbg !14
  %43 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %7, 0, !dbg !15
  %44 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %43, ptr %8, 1, !dbg !16
  %45 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %44, i64 %9, 2, !dbg !17
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, i64 %10, 3, 0, !dbg !18
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, i64 %12, 4, 0, !dbg !19
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, i64 %11, 3, 1, !dbg !20
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 %13, 4, 1, !dbg !21
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0, !dbg !22
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, ptr %15, 1, !dbg !23
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 %16, 2, !dbg !24
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 %17, 3, 0, !dbg !25
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 %19, 4, 0, !dbg !26
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 %18, 3, 1, !dbg !27
  %56 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, i64 %20, 4, 1, !dbg !28
  %57 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %21, 0, !dbg !29
  %58 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %57, ptr %22, 1, !dbg !30
  %59 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %58, i64 %23, 2, !dbg !31
  %60 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %59, i64 %24, 3, 0, !dbg !32
  %61 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, i64 %26, 4, 0, !dbg !33
  %62 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %61, i64 %25, 3, 1, !dbg !34
  %63 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %62, i64 %27, 4, 1, !dbg !35
  %64 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %28, 0, !dbg !36
  %65 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %64, ptr %29, 1, !dbg !37
  %66 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, i64 %30, 2, !dbg !38
  %67 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, i64 %31, 3, 0, !dbg !39
  %68 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %67, i64 %33, 4, 0, !dbg !40
  %69 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, i64 %32, 3, 1, !dbg !41
  %70 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, i64 %34, 4, 1, !dbg !42
  %71 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i64 256) to i64), i64 128)), !dbg !43
  %72 = ptrtoint ptr %71 to i64, !dbg !44
  %73 = add i64 %72, 127, !dbg !45
  %74 = urem i64 %73, 128, !dbg !46
  %75 = sub i64 %73, %74, !dbg !47
  %76 = inttoptr i64 %75 to ptr, !dbg !48
  %77 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %71, 0, !dbg !49
  %78 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, ptr %76, 1, !dbg !50
  %79 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %78, i64 0, 2, !dbg !51
  %80 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %79, i64 16, 3, 0, !dbg !52
  %81 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %80, i64 16, 3, 1, !dbg !53
  %82 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %81, i64 16, 4, 0, !dbg !54
  %83 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, i64 1, 4, 1, !dbg !55
  br label %84, !dbg !56

84:                                               ; preds = %118, %35
  %85 = phi i64 [ %119, %118 ], [ 0, %35 ]
  %86 = icmp slt i64 %85, 16, !dbg !57
  br i1 %86, label %87, label %120, !dbg !58

87:                                               ; preds = %116, %84
  %88 = phi i64 [ %117, %116 ], [ 0, %84 ]
  %89 = icmp slt i64 %88, 16, !dbg !59
  br i1 %89, label %90, label %118, !dbg !60

90:                                               ; preds = %87
  %91 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %71, 0, !dbg !61
  %92 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %91, ptr %76, 1, !dbg !62
  %93 = mul i64 %85, 16, !dbg !63
  %94 = add i64 0, %93, !dbg !64
  %95 = mul i64 %88, 1, !dbg !65
  %96 = add i64 %94, %95, !dbg !66
  %97 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %92, i64 %96, 2, !dbg !67
  %98 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %97, i64 8, 3, 1, !dbg !68
  %99 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %98, i64 1, 4, 1, !dbg !69
  %100 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %99, i64 4, 3, 0, !dbg !70
  %101 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %100, i64 16, 4, 0, !dbg !71
  br label %102, !dbg !72

102:                                              ; preds = %114, %90
  %103 = phi i64 [ %115, %114 ], [ 0, %90 ]
  %104 = icmp slt i64 %103, 4, !dbg !73
  br i1 %104, label %105, label %116, !dbg !74

105:                                              ; preds = %108, %102
  %106 = phi i64 [ %113, %108 ], [ 0, %102 ]
  %107 = icmp slt i64 %106, 8, !dbg !75
  br i1 %107, label %108, label %114, !dbg !76

108:                                              ; preds = %105
  %109 = mul i64 %103, 16, !dbg !77
  %110 = add i64 %96, %109, !dbg !78
  %111 = add i64 %110, %106, !dbg !79
  %112 = getelementptr float, ptr %76, i64 %111, !dbg !80
  store float 0.000000e+00, ptr %112, align 4, !dbg !81
  %113 = add i64 %106, 1, !dbg !82
  br label %105, !dbg !83

114:                                              ; preds = %105
  %115 = add i64 %103, 1, !dbg !84
  br label %102, !dbg !85

116:                                              ; preds = %102
  %117 = add i64 %88, 8, !dbg !86
  br label %87, !dbg !87

118:                                              ; preds = %87
  %119 = add i64 %85, 4, !dbg !88
  br label %84, !dbg !89

120:                                              ; preds = %84
  %121 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i64 256) to i64), i64 128)), !dbg !90
  %122 = ptrtoint ptr %121 to i64, !dbg !91
  %123 = add i64 %122, 127, !dbg !92
  %124 = urem i64 %123, 128, !dbg !93
  %125 = sub i64 %123, %124, !dbg !94
  %126 = inttoptr i64 %125 to ptr, !dbg !95
  %127 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %121, 0, !dbg !96
  %128 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %127, ptr %126, 1, !dbg !97
  %129 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %128, i64 0, 2, !dbg !98
  %130 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %129, i64 16, 3, 0, !dbg !99
  %131 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %130, i64 16, 3, 1, !dbg !100
  %132 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %131, i64 16, 4, 0, !dbg !101
  %133 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %132, i64 1, 4, 1, !dbg !102
  %134 = getelementptr float, ptr %76, i64 0, !dbg !103
  %135 = getelementptr float, ptr %126, i64 0, !dbg !104
  call void @llvm.memcpy.p0.p0.i64(ptr %135, ptr %134, i64 mul (i64 ptrtoint (ptr getelementptr (float, ptr null, i64 1) to i64), i64 256), i1 false), !dbg !105
  call void @free(ptr %71), !dbg !106
  br label %136, !dbg !107

136:                                              ; preds = %187, %120
  %137 = phi i64 [ %188, %187 ], [ 0, %120 ]
  %138 = icmp slt i64 %137, 16, !dbg !108
  br i1 %138, label %139, label %189, !dbg !109

139:                                              ; preds = %142, %136
  %140 = phi i64 [ %186, %142 ], [ 0, %136 ]
  %141 = icmp slt i64 %140, 16, !dbg !110
  br i1 %141, label %142, label %187, !dbg !111

142:                                              ; preds = %139
  %143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 0, !dbg !112
  %144 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %143, 0, !dbg !113
  %145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 1, !dbg !114
  %146 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %144, ptr %145, 1, !dbg !115
  %147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 4, 0, !dbg !116
  %148 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 4, 1, !dbg !117
  %149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 2, !dbg !118
  %150 = mul i64 %137, %147, !dbg !119
  %151 = add i64 %149, %150, !dbg !120
  %152 = mul i64 0, %148, !dbg !121
  %153 = add i64 %151, %152, !dbg !122
  %154 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %146, i64 %153, 2, !dbg !123
  %155 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %154, i64 32, 3, 1, !dbg !124
  %156 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %155, i64 1, 4, 1, !dbg !125
  %157 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %156, i64 4, 3, 0, !dbg !126
  %158 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %157, i64 32, 4, 0, !dbg !127
  %159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, 0, !dbg !128
  %160 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %159, 0, !dbg !129
  %161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, 1, !dbg !130
  %162 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %160, ptr %161, 1, !dbg !131
  %163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, 4, 0, !dbg !132
  %164 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, 4, 1, !dbg !133
  %165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, 2, !dbg !134
  %166 = mul i64 0, %163, !dbg !135
  %167 = add i64 %165, %166, !dbg !136
  %168 = mul i64 %140, %164, !dbg !137
  %169 = add i64 %167, %168, !dbg !138
  %170 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, i64 %169, 2, !dbg !139
  %171 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %170, i64 8, 3, 1, !dbg !140
  %172 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %171, i64 1, 4, 1, !dbg !141
  %173 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %172, i64 32, 3, 0, !dbg !142
  %174 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %173, i64 16, 4, 0, !dbg !143
  %175 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %121, 0, !dbg !144
  %176 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %175, ptr %126, 1, !dbg !145
  %177 = mul i64 %137, 16, !dbg !146
  %178 = add i64 0, %177, !dbg !147
  %179 = mul i64 %140, 1, !dbg !148
  %180 = add i64 %178, %179, !dbg !149
  %181 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %176, i64 %180, 2, !dbg !150
  %182 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %181, i64 8, 3, 1, !dbg !151
  %183 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %182, i64 1, 4, 1, !dbg !152
  %184 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %183, i64 4, 3, 0, !dbg !153
  %185 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %184, i64 16, 4, 0, !dbg !154
  call void @cgra_matmul(ptr %143, ptr %145, i64 %153, i64 4, i64 32, i64 32, i64 1, ptr %159, ptr %161, i64 %169, i64 32, i64 8, i64 16, i64 1, ptr %121, ptr %126, i64 %180, i64 4, i64 8, i64 16, i64 1), !dbg !155
  %186 = add i64 %140, 8, !dbg !156
  br label %139, !dbg !157

187:                                              ; preds = %139
  %188 = add i64 %137, 4, !dbg !158
  br label %136, !dbg !159

189:                                              ; preds = %136
  %190 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i64 256) to i64), i64 128)), !dbg !160
  %191 = ptrtoint ptr %190 to i64, !dbg !161
  %192 = add i64 %191, 127, !dbg !162
  %193 = urem i64 %192, 128, !dbg !163
  %194 = sub i64 %192, %193, !dbg !164
  %195 = inttoptr i64 %194 to ptr, !dbg !165
  %196 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %190, 0, !dbg !166
  %197 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %196, ptr %195, 1, !dbg !167
  %198 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %197, i64 0, 2, !dbg !168
  %199 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %198, i64 16, 3, 0, !dbg !169
  %200 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %199, i64 16, 3, 1, !dbg !170
  %201 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %200, i64 16, 4, 0, !dbg !171
  %202 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %201, i64 1, 4, 1, !dbg !172
  br label %203, !dbg !173

203:                                              ; preds = %265, %189
  %204 = phi i64 [ %266, %265 ], [ 0, %189 ]
  %205 = icmp slt i64 %204, 16, !dbg !174
  br i1 %205, label %206, label %267, !dbg !175

206:                                              ; preds = %209, %203
  %207 = phi i64 [ %264, %209 ], [ 0, %203 ]
  %208 = icmp slt i64 %207, 16, !dbg !176
  br i1 %208, label %209, label %265, !dbg !177

209:                                              ; preds = %206
  %210 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %121, 0, !dbg !178
  %211 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %210, ptr %126, 1, !dbg !179
  %212 = mul i64 %204, 16, !dbg !180
  %213 = add i64 0, %212, !dbg !181
  %214 = mul i64 %207, 1, !dbg !182
  %215 = add i64 %213, %214, !dbg !183
  %216 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %211, i64 %215, 2, !dbg !184
  %217 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %216, i64 8, 3, 1, !dbg !185
  %218 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %217, i64 1, 4, 1, !dbg !186
  %219 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %218, i64 4, 3, 0, !dbg !187
  %220 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %219, i64 16, 4, 0, !dbg !188
  %221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, 0, !dbg !189
  %222 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %221, 0, !dbg !190
  %223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, 1, !dbg !191
  %224 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %222, ptr %223, 1, !dbg !192
  %225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, 4, 0, !dbg !193
  %226 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, 4, 1, !dbg !194
  %227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, 2, !dbg !195
  %228 = mul i64 %204, %225, !dbg !196
  %229 = add i64 %227, %228, !dbg !197
  %230 = mul i64 %207, %226, !dbg !198
  %231 = add i64 %229, %230, !dbg !199
  %232 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %224, i64 %231, 2, !dbg !200
  %233 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %232, i64 8, 3, 1, !dbg !201
  %234 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %233, i64 1, 4, 1, !dbg !202
  %235 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %234, i64 4, 3, 0, !dbg !203
  %236 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %235, i64 16, 4, 0, !dbg !204
  %237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 0, !dbg !205
  %238 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %237, 0, !dbg !206
  %239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 1, !dbg !207
  %240 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %238, ptr %239, 1, !dbg !208
  %241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 4, 0, !dbg !209
  %242 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 4, 1, !dbg !210
  %243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 2, !dbg !211
  %244 = mul i64 %204, %241, !dbg !212
  %245 = add i64 %243, %244, !dbg !213
  %246 = mul i64 %207, %242, !dbg !214
  %247 = add i64 %245, %246, !dbg !215
  %248 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %240, i64 %247, 2, !dbg !216
  %249 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %248, i64 8, 3, 1, !dbg !217
  %250 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %249, i64 1, 4, 1, !dbg !218
  %251 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %250, i64 4, 3, 0, !dbg !219
  %252 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %251, i64 16, 4, 0, !dbg !220
  %253 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %190, 0, !dbg !221
  %254 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %253, ptr %195, 1, !dbg !222
  %255 = mul i64 %204, 16, !dbg !223
  %256 = add i64 0, %255, !dbg !224
  %257 = mul i64 %207, 1, !dbg !225
  %258 = add i64 %256, %257, !dbg !226
  %259 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %254, i64 %258, 2, !dbg !227
  %260 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %259, i64 8, 3, 1, !dbg !228
  %261 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %260, i64 1, 4, 1, !dbg !229
  %262 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %261, i64 4, 3, 0, !dbg !230
  %263 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %262, i64 16, 4, 0, !dbg !231
  call void @cgra_fusion(ptr %121, ptr %126, i64 %215, i64 4, i64 8, i64 16, i64 1, ptr %221, ptr %223, i64 %231, i64 4, i64 8, i64 16, i64 1, ptr %237, ptr %239, i64 %247, i64 4, i64 8, i64 16, i64 1, ptr %190, ptr %195, i64 %258, i64 4, i64 8, i64 16, i64 1), !dbg !232
  %264 = add i64 %207, 8, !dbg !233
  br label %206, !dbg !234

265:                                              ; preds = %206
  %266 = add i64 %204, 4, !dbg !235
  br label %203, !dbg !236

267:                                              ; preds = %203
  call void @free(ptr %121), !dbg !237
  %268 = getelementptr float, ptr %195, i64 0, !dbg !238
  %269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %70, 1, !dbg !239
  %270 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %70, 2, !dbg !240
  %271 = getelementptr float, ptr %269, i64 %270, !dbg !241
  call void @llvm.memcpy.p0.p0.i64(ptr %271, ptr %268, i64 mul (i64 ptrtoint (ptr getelementptr (float, ptr null, i64 1) to i64), i64 256), i1 false), !dbg !242
  ret void, !dbg !243
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { argmemonly nofree nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "main_graph", linkageName: "main_graph", scope: null, file: !4, line: 6, type: !5, scopeLine: 6, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "gemmreluadd.cgra.llvm.mlir", directory: "/home/tancheng/workspace/ml/mlir-cgra/mlir-cgra/dev/integration_test")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 8, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 9, column: 10, scope: !8)
!10 = !DILocation(line: 10, column: 10, scope: !8)
!11 = !DILocation(line: 11, column: 10, scope: !8)
!12 = !DILocation(line: 12, column: 10, scope: !8)
!13 = !DILocation(line: 13, column: 10, scope: !8)
!14 = !DILocation(line: 14, column: 10, scope: !8)
!15 = !DILocation(line: 16, column: 10, scope: !8)
!16 = !DILocation(line: 17, column: 11, scope: !8)
!17 = !DILocation(line: 18, column: 11, scope: !8)
!18 = !DILocation(line: 19, column: 11, scope: !8)
!19 = !DILocation(line: 20, column: 11, scope: !8)
!20 = !DILocation(line: 21, column: 11, scope: !8)
!21 = !DILocation(line: 22, column: 11, scope: !8)
!22 = !DILocation(line: 24, column: 11, scope: !8)
!23 = !DILocation(line: 25, column: 11, scope: !8)
!24 = !DILocation(line: 26, column: 11, scope: !8)
!25 = !DILocation(line: 27, column: 11, scope: !8)
!26 = !DILocation(line: 28, column: 11, scope: !8)
!27 = !DILocation(line: 29, column: 11, scope: !8)
!28 = !DILocation(line: 30, column: 11, scope: !8)
!29 = !DILocation(line: 32, column: 11, scope: !8)
!30 = !DILocation(line: 33, column: 11, scope: !8)
!31 = !DILocation(line: 34, column: 11, scope: !8)
!32 = !DILocation(line: 35, column: 11, scope: !8)
!33 = !DILocation(line: 36, column: 11, scope: !8)
!34 = !DILocation(line: 37, column: 11, scope: !8)
!35 = !DILocation(line: 38, column: 11, scope: !8)
!36 = !DILocation(line: 40, column: 11, scope: !8)
!37 = !DILocation(line: 41, column: 11, scope: !8)
!38 = !DILocation(line: 42, column: 11, scope: !8)
!39 = !DILocation(line: 43, column: 11, scope: !8)
!40 = !DILocation(line: 44, column: 11, scope: !8)
!41 = !DILocation(line: 45, column: 11, scope: !8)
!42 = !DILocation(line: 46, column: 11, scope: !8)
!43 = !DILocation(line: 62, column: 11, scope: !8)
!44 = !DILocation(line: 64, column: 11, scope: !8)
!45 = !DILocation(line: 67, column: 11, scope: !8)
!46 = !DILocation(line: 68, column: 11, scope: !8)
!47 = !DILocation(line: 69, column: 11, scope: !8)
!48 = !DILocation(line: 70, column: 11, scope: !8)
!49 = !DILocation(line: 72, column: 11, scope: !8)
!50 = !DILocation(line: 73, column: 11, scope: !8)
!51 = !DILocation(line: 75, column: 11, scope: !8)
!52 = !DILocation(line: 76, column: 11, scope: !8)
!53 = !DILocation(line: 77, column: 11, scope: !8)
!54 = !DILocation(line: 78, column: 11, scope: !8)
!55 = !DILocation(line: 79, column: 11, scope: !8)
!56 = !DILocation(line: 80, column: 5, scope: !8)
!57 = !DILocation(line: 82, column: 11, scope: !8)
!58 = !DILocation(line: 83, column: 5, scope: !8)
!59 = !DILocation(line: 85, column: 11, scope: !8)
!60 = !DILocation(line: 86, column: 5, scope: !8)
!61 = !DILocation(line: 89, column: 11, scope: !8)
!62 = !DILocation(line: 90, column: 11, scope: !8)
!63 = !DILocation(line: 91, column: 11, scope: !8)
!64 = !DILocation(line: 92, column: 11, scope: !8)
!65 = !DILocation(line: 93, column: 11, scope: !8)
!66 = !DILocation(line: 94, column: 11, scope: !8)
!67 = !DILocation(line: 95, column: 11, scope: !8)
!68 = !DILocation(line: 98, column: 11, scope: !8)
!69 = !DILocation(line: 99, column: 11, scope: !8)
!70 = !DILocation(line: 102, column: 11, scope: !8)
!71 = !DILocation(line: 103, column: 11, scope: !8)
!72 = !DILocation(line: 104, column: 5, scope: !8)
!73 = !DILocation(line: 106, column: 11, scope: !8)
!74 = !DILocation(line: 107, column: 5, scope: !8)
!75 = !DILocation(line: 109, column: 11, scope: !8)
!76 = !DILocation(line: 110, column: 5, scope: !8)
!77 = !DILocation(line: 113, column: 11, scope: !8)
!78 = !DILocation(line: 114, column: 11, scope: !8)
!79 = !DILocation(line: 115, column: 12, scope: !8)
!80 = !DILocation(line: 116, column: 12, scope: !8)
!81 = !DILocation(line: 117, column: 5, scope: !8)
!82 = !DILocation(line: 118, column: 12, scope: !8)
!83 = !DILocation(line: 119, column: 5, scope: !8)
!84 = !DILocation(line: 121, column: 12, scope: !8)
!85 = !DILocation(line: 122, column: 5, scope: !8)
!86 = !DILocation(line: 124, column: 12, scope: !8)
!87 = !DILocation(line: 125, column: 5, scope: !8)
!88 = !DILocation(line: 127, column: 12, scope: !8)
!89 = !DILocation(line: 128, column: 5, scope: !8)
!90 = !DILocation(line: 139, column: 12, scope: !8)
!91 = !DILocation(line: 141, column: 12, scope: !8)
!92 = !DILocation(line: 144, column: 12, scope: !8)
!93 = !DILocation(line: 145, column: 12, scope: !8)
!94 = !DILocation(line: 146, column: 12, scope: !8)
!95 = !DILocation(line: 147, column: 12, scope: !8)
!96 = !DILocation(line: 149, column: 12, scope: !8)
!97 = !DILocation(line: 150, column: 12, scope: !8)
!98 = !DILocation(line: 152, column: 12, scope: !8)
!99 = !DILocation(line: 153, column: 12, scope: !8)
!100 = !DILocation(line: 154, column: 12, scope: !8)
!101 = !DILocation(line: 155, column: 12, scope: !8)
!102 = !DILocation(line: 156, column: 12, scope: !8)
!103 = !DILocation(line: 165, column: 12, scope: !8)
!104 = !DILocation(line: 166, column: 12, scope: !8)
!105 = !DILocation(line: 168, column: 5, scope: !8)
!106 = !DILocation(line: 170, column: 5, scope: !8)
!107 = !DILocation(line: 171, column: 5, scope: !8)
!108 = !DILocation(line: 173, column: 12, scope: !8)
!109 = !DILocation(line: 174, column: 5, scope: !8)
!110 = !DILocation(line: 176, column: 12, scope: !8)
!111 = !DILocation(line: 177, column: 5, scope: !8)
!112 = !DILocation(line: 180, column: 12, scope: !8)
!113 = !DILocation(line: 181, column: 12, scope: !8)
!114 = !DILocation(line: 182, column: 12, scope: !8)
!115 = !DILocation(line: 183, column: 12, scope: !8)
!116 = !DILocation(line: 184, column: 12, scope: !8)
!117 = !DILocation(line: 185, column: 12, scope: !8)
!118 = !DILocation(line: 186, column: 12, scope: !8)
!119 = !DILocation(line: 187, column: 12, scope: !8)
!120 = !DILocation(line: 188, column: 12, scope: !8)
!121 = !DILocation(line: 190, column: 12, scope: !8)
!122 = !DILocation(line: 191, column: 12, scope: !8)
!123 = !DILocation(line: 192, column: 12, scope: !8)
!124 = !DILocation(line: 195, column: 12, scope: !8)
!125 = !DILocation(line: 196, column: 12, scope: !8)
!126 = !DILocation(line: 199, column: 12, scope: !8)
!127 = !DILocation(line: 200, column: 12, scope: !8)
!128 = !DILocation(line: 202, column: 12, scope: !8)
!129 = !DILocation(line: 203, column: 12, scope: !8)
!130 = !DILocation(line: 204, column: 12, scope: !8)
!131 = !DILocation(line: 205, column: 12, scope: !8)
!132 = !DILocation(line: 206, column: 12, scope: !8)
!133 = !DILocation(line: 207, column: 12, scope: !8)
!134 = !DILocation(line: 208, column: 12, scope: !8)
!135 = !DILocation(line: 210, column: 12, scope: !8)
!136 = !DILocation(line: 211, column: 12, scope: !8)
!137 = !DILocation(line: 212, column: 12, scope: !8)
!138 = !DILocation(line: 213, column: 12, scope: !8)
!139 = !DILocation(line: 214, column: 12, scope: !8)
!140 = !DILocation(line: 217, column: 12, scope: !8)
!141 = !DILocation(line: 218, column: 12, scope: !8)
!142 = !DILocation(line: 221, column: 12, scope: !8)
!143 = !DILocation(line: 222, column: 12, scope: !8)
!144 = !DILocation(line: 224, column: 12, scope: !8)
!145 = !DILocation(line: 225, column: 12, scope: !8)
!146 = !DILocation(line: 226, column: 12, scope: !8)
!147 = !DILocation(line: 227, column: 12, scope: !8)
!148 = !DILocation(line: 228, column: 12, scope: !8)
!149 = !DILocation(line: 229, column: 12, scope: !8)
!150 = !DILocation(line: 230, column: 12, scope: !8)
!151 = !DILocation(line: 233, column: 12, scope: !8)
!152 = !DILocation(line: 234, column: 12, scope: !8)
!153 = !DILocation(line: 237, column: 12, scope: !8)
!154 = !DILocation(line: 238, column: 12, scope: !8)
!155 = !DILocation(line: 239, column: 5, scope: !8)
!156 = !DILocation(line: 240, column: 12, scope: !8)
!157 = !DILocation(line: 241, column: 5, scope: !8)
!158 = !DILocation(line: 243, column: 12, scope: !8)
!159 = !DILocation(line: 244, column: 5, scope: !8)
!160 = !DILocation(line: 255, column: 12, scope: !8)
!161 = !DILocation(line: 257, column: 12, scope: !8)
!162 = !DILocation(line: 260, column: 12, scope: !8)
!163 = !DILocation(line: 261, column: 12, scope: !8)
!164 = !DILocation(line: 262, column: 12, scope: !8)
!165 = !DILocation(line: 263, column: 12, scope: !8)
!166 = !DILocation(line: 265, column: 12, scope: !8)
!167 = !DILocation(line: 266, column: 12, scope: !8)
!168 = !DILocation(line: 268, column: 12, scope: !8)
!169 = !DILocation(line: 269, column: 12, scope: !8)
!170 = !DILocation(line: 270, column: 12, scope: !8)
!171 = !DILocation(line: 271, column: 12, scope: !8)
!172 = !DILocation(line: 272, column: 12, scope: !8)
!173 = !DILocation(line: 273, column: 5, scope: !8)
!174 = !DILocation(line: 275, column: 12, scope: !8)
!175 = !DILocation(line: 276, column: 5, scope: !8)
!176 = !DILocation(line: 278, column: 12, scope: !8)
!177 = !DILocation(line: 279, column: 5, scope: !8)
!178 = !DILocation(line: 282, column: 12, scope: !8)
!179 = !DILocation(line: 283, column: 12, scope: !8)
!180 = !DILocation(line: 284, column: 12, scope: !8)
!181 = !DILocation(line: 285, column: 12, scope: !8)
!182 = !DILocation(line: 286, column: 12, scope: !8)
!183 = !DILocation(line: 287, column: 12, scope: !8)
!184 = !DILocation(line: 288, column: 12, scope: !8)
!185 = !DILocation(line: 291, column: 12, scope: !8)
!186 = !DILocation(line: 292, column: 12, scope: !8)
!187 = !DILocation(line: 295, column: 12, scope: !8)
!188 = !DILocation(line: 296, column: 12, scope: !8)
!189 = !DILocation(line: 298, column: 12, scope: !8)
!190 = !DILocation(line: 299, column: 12, scope: !8)
!191 = !DILocation(line: 300, column: 12, scope: !8)
!192 = !DILocation(line: 301, column: 12, scope: !8)
!193 = !DILocation(line: 302, column: 12, scope: !8)
!194 = !DILocation(line: 303, column: 12, scope: !8)
!195 = !DILocation(line: 304, column: 12, scope: !8)
!196 = !DILocation(line: 305, column: 12, scope: !8)
!197 = !DILocation(line: 306, column: 12, scope: !8)
!198 = !DILocation(line: 307, column: 12, scope: !8)
!199 = !DILocation(line: 308, column: 12, scope: !8)
!200 = !DILocation(line: 309, column: 12, scope: !8)
!201 = !DILocation(line: 312, column: 12, scope: !8)
!202 = !DILocation(line: 313, column: 12, scope: !8)
!203 = !DILocation(line: 316, column: 12, scope: !8)
!204 = !DILocation(line: 317, column: 12, scope: !8)
!205 = !DILocation(line: 319, column: 12, scope: !8)
!206 = !DILocation(line: 320, column: 12, scope: !8)
!207 = !DILocation(line: 321, column: 12, scope: !8)
!208 = !DILocation(line: 322, column: 12, scope: !8)
!209 = !DILocation(line: 323, column: 12, scope: !8)
!210 = !DILocation(line: 324, column: 12, scope: !8)
!211 = !DILocation(line: 325, column: 12, scope: !8)
!212 = !DILocation(line: 326, column: 12, scope: !8)
!213 = !DILocation(line: 327, column: 12, scope: !8)
!214 = !DILocation(line: 328, column: 12, scope: !8)
!215 = !DILocation(line: 329, column: 12, scope: !8)
!216 = !DILocation(line: 330, column: 12, scope: !8)
!217 = !DILocation(line: 333, column: 12, scope: !8)
!218 = !DILocation(line: 334, column: 12, scope: !8)
!219 = !DILocation(line: 337, column: 12, scope: !8)
!220 = !DILocation(line: 338, column: 12, scope: !8)
!221 = !DILocation(line: 340, column: 12, scope: !8)
!222 = !DILocation(line: 341, column: 12, scope: !8)
!223 = !DILocation(line: 342, column: 12, scope: !8)
!224 = !DILocation(line: 343, column: 12, scope: !8)
!225 = !DILocation(line: 344, column: 12, scope: !8)
!226 = !DILocation(line: 345, column: 12, scope: !8)
!227 = !DILocation(line: 346, column: 12, scope: !8)
!228 = !DILocation(line: 349, column: 12, scope: !8)
!229 = !DILocation(line: 350, column: 12, scope: !8)
!230 = !DILocation(line: 353, column: 12, scope: !8)
!231 = !DILocation(line: 354, column: 12, scope: !8)
!232 = !DILocation(line: 355, column: 5, scope: !8)
!233 = !DILocation(line: 356, column: 12, scope: !8)
!234 = !DILocation(line: 357, column: 5, scope: !8)
!235 = !DILocation(line: 359, column: 12, scope: !8)
!236 = !DILocation(line: 360, column: 5, scope: !8)
!237 = !DILocation(line: 363, column: 5, scope: !8)
!238 = !DILocation(line: 372, column: 12, scope: !8)
!239 = !DILocation(line: 373, column: 12, scope: !8)
!240 = !DILocation(line: 374, column: 12, scope: !8)
!241 = !DILocation(line: 375, column: 12, scope: !8)
!242 = !DILocation(line: 377, column: 5, scope: !8)
!243 = !DILocation(line: 378, column: 5, scope: !8)
