; ModuleID = 'main.cpp'
source_filename = "main.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%struct.MemRefDescriptor = type { float*, float*, i64, [2 x i64], [2 x i64] }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@_ZSt4cout = external dso_local global %"class.std::basic_ostream", align 8
@.str = private unnamed_addr constant [15 x i8] c"check result: \00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\09\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_main.cpp, i8* null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull dereferenceable(1) @_ZStL8__ioinit)
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3
  ret void
}

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: noinline norecurse optnone uwtable mustprogress
define dso_local i32 @main(i32 %0, i8** %1) #4 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca float*, align 8
  %7 = alloca float*, align 8
  %8 = alloca float*, align 8
  %9 = alloca float*, align 8
  %10 = alloca float*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca %struct.MemRefDescriptor, align 8
  %17 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %18 = call noalias nonnull i8* @_Znam(i64 2048) #6
  %19 = bitcast i8* %18 to float*
  store float* %19, float** %6, align 8
  %20 = call noalias nonnull i8* @_Znam(i64 2048) #6
  %21 = bitcast i8* %20 to float*
  store float* %21, float** %7, align 8
  %22 = call noalias nonnull i8* @_Znam(i64 1024) #6
  %23 = bitcast i8* %22 to float*
  store float* %23, float** %8, align 8
  %24 = call noalias nonnull i8* @_Znam(i64 1024) #6
  %25 = bitcast i8* %24 to float*
  store float* %25, float** %9, align 8
  %26 = call noalias nonnull i8* @_Znam(i64 1024) #6
  %27 = bitcast i8* %26 to float*
  store float* %27, float** %10, align 8
  store i32 0, i32* %11, align 4
  br label %28

28:                                               ; preds = %38, %2
  %29 = load i32, i32* %11, align 4
  %30 = icmp slt i32 %29, 512
  br i1 %30, label %31, label %41

31:                                               ; preds = %28
  %32 = load i32, i32* %11, align 4
  %33 = sitofp i32 %32 to float
  %34 = load float*, float** %6, align 8
  %35 = load i32, i32* %11, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds float, float* %34, i64 %36
  store float %33, float* %37, align 4
  br label %38

38:                                               ; preds = %31
  %39 = load i32, i32* %11, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, i32* %11, align 4
  br label %28, !llvm.loop !2

41:                                               ; preds = %28
  store i32 0, i32* %12, align 4
  br label %42

42:                                               ; preds = %59, %41
  %43 = load i32, i32* %12, align 4
  %44 = icmp slt i32 %43, 512
  br i1 %44, label %45, label %62

45:                                               ; preds = %42
  %46 = load i32, i32* %12, align 4
  %47 = sdiv i32 %46, 16
  store i32 %47, i32* %13, align 4
  %48 = load i32, i32* %12, align 4
  %49 = srem i32 %48, 16
  store i32 %49, i32* %14, align 4
  %50 = load i32, i32* %13, align 4
  %51 = load i32, i32* %14, align 4
  %52 = icmp eq i32 %50, %51
  br i1 %52, label %53, label %58

53:                                               ; preds = %45
  %54 = load float*, float** %7, align 8
  %55 = load i32, i32* %12, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds float, float* %54, i64 %56
  store float 1.000000e+00, float* %57, align 4
  br label %58

58:                                               ; preds = %53, %45
  br label %59

59:                                               ; preds = %58
  %60 = load i32, i32* %12, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, i32* %12, align 4
  br label %42, !llvm.loop !4

62:                                               ; preds = %42
  store i32 0, i32* %15, align 4
  br label %63

63:                                               ; preds = %71, %62
  %64 = load i32, i32* %15, align 4
  %65 = icmp slt i32 %64, 256
  br i1 %65, label %66, label %74

66:                                               ; preds = %63
  %67 = load float*, float** %9, align 8
  %68 = load i32, i32* %15, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds float, float* %67, i64 %69
  store float 1.000000e+00, float* %70, align 4
  br label %71

71:                                               ; preds = %66
  %72 = load i32, i32* %15, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, i32* %15, align 4
  br label %63, !llvm.loop !5

74:                                               ; preds = %63
  %75 = getelementptr inbounds %struct.MemRefDescriptor, %struct.MemRefDescriptor* %16, i32 0, i32 0
  %76 = load float*, float** %6, align 8
  store float* %76, float** %75, align 8
  %77 = getelementptr inbounds %struct.MemRefDescriptor, %struct.MemRefDescriptor* %16, i32 0, i32 1
  %78 = load float*, float** %6, align 8
  store float* %78, float** %77, align 8
  %79 = getelementptr inbounds %struct.MemRefDescriptor, %struct.MemRefDescriptor* %16, i32 0, i32 2
  store i64 0, i64* %79, align 8
  %80 = getelementptr inbounds %struct.MemRefDescriptor, %struct.MemRefDescriptor* %16, i32 0, i32 3
  %81 = getelementptr inbounds [2 x i64], [2 x i64]* %80, i64 0, i64 0
  store i64 16, i64* %81, align 8
  %82 = getelementptr inbounds i64, i64* %81, i64 1
  store i64 32, i64* %82, align 8
  %83 = getelementptr inbounds %struct.MemRefDescriptor, %struct.MemRefDescriptor* %16, i32 0, i32 4
  %84 = getelementptr inbounds [2 x i64], [2 x i64]* %83, i64 0, i64 0
  store i64 1, i64* %84, align 8
  %85 = getelementptr inbounds i64, i64* %84, i64 1
  store i64 1, i64* %85, align 8
  %86 = load float*, float** %6, align 8
  %87 = load float*, float** %6, align 8
  %88 = load float*, float** %7, align 8
  %89 = load float*, float** %7, align 8
  %90 = load float*, float** %8, align 8
  %91 = load float*, float** %8, align 8
  %92 = load float*, float** %9, align 8
  %93 = load float*, float** %9, align 8
  %94 = load float*, float** %10, align 8
  %95 = load float*, float** %10, align 8
  %96 = call i8* @main_graph(float* %86, float* %87, i64 0, i64 16, i64 32, i64 1, i64 1, float* %88, float* %89, i64 0, i64 32, i64 16, i64 1, i64 1, float* %90, float* %91, i64 0, i64 16, i64 16, i64 1, i64 1, float* %92, float* %93, i64 0, i64 16, i64 16, i64 1, i64 1, float* %94, float* %95, i64 0, i64 16, i64 16, i64 1, i64 1)
  %97 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  %98 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* nonnull dereferenceable(8) %97, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
  store i32 0, i32* %17, align 4
  br label %99

99:                                               ; preds = %116, %74
  %100 = load i32, i32* %17, align 4
  %101 = icmp slt i32 %100, 256
  br i1 %101, label %102, label %119

102:                                              ; preds = %99
  %103 = load float*, float** %10, align 8
  %104 = load i32, i32* %17, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds float, float* %103, i64 %105
  %107 = load float, float* %106, align 4
  %108 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEf(%"class.std::basic_ostream"* nonnull dereferenceable(8) @_ZSt4cout, float %107)
  %109 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %108, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
  %110 = load i32, i32* %17, align 4
  %111 = srem i32 %110, 16
  %112 = icmp eq i32 %111, 15
  br i1 %112, label %113, label %115

113:                                              ; preds = %102
  %114 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* nonnull dereferenceable(8) @_ZSt4cout, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
  br label %115

115:                                              ; preds = %113, %102
  br label %116

116:                                              ; preds = %115
  %117 = load i32, i32* %17, align 4
  %118 = add nsw i32 %117, 1
  store i32 %118, i32* %17, align 4
  br label %99, !llvm.loop !6

119:                                              ; preds = %99
  ret i32 0
}

; Function Attrs: nobuiltin allocsize(0)
declare dso_local nonnull i8* @_Znam(i64) #5

declare dso_local i8* @main_graph(float*, float*, i64, i64, i64, i64, i64, float*, float*, i64, i64, i64, i64, i64, float*, float*, i64, i64, i64, i64, i64, float*, float*, i64, i64, i64, i64, i64, float*, float*, i64, i64, i64, i64, i64) #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8*) #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* nonnull dereferenceable(8), %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)*) #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8)) #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEf(%"class.std::basic_ostream"* nonnull dereferenceable(8), float) #1

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_main.cpp() #0 section ".text.startup" {
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noinline norecurse optnone uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nobuiltin allocsize(0) "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { builtin allocsize(0) }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
!5 = distinct !{!5, !3}
!6 = distinct !{!6, !3}
