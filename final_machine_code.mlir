module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @abort()
  llvm.func @puts(!llvm.ptr)
  llvm.mlir.global private constant @assert_msg(dense<[117, 110, 105, 109, 112, 108, 101, 109, 101, 110, 116, 101, 100, 58, 32, 116, 101, 110, 115, 111, 114, 32, 119, 105, 116, 104, 32, 122, 101, 114, 111, 32, 101, 108, 101, 109, 101, 110, 116, 0]> : tensor<40xi8>) {addr_space = 0 : i32} : !llvm.array<40 x i8>
  llvm.func @main(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(3 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.mlir.constant(3 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.constant(3 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %14 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.constant(3 : index) : i64
    %17 = llvm.mlir.constant(0 : index) : i64
    %18 = llvm.mlir.constant(3 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.zero : !llvm.ptr
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %22 = llvm.ptrtoint %21 : !llvm.ptr to i64
    %23 = llvm.mlir.constant(64 : index) : i64
    %24 = llvm.add %22, %23 : i64
    %25 = llvm.call @malloc(%24) : (i64) -> !llvm.ptr
    %26 = llvm.ptrtoint %25 : !llvm.ptr to i64
    %27 = llvm.mlir.constant(1 : index) : i64
    %28 = llvm.sub %23, %27 : i64
    %29 = llvm.add %26, %28 : i64
    %30 = llvm.urem %29, %23 : i64
    %31 = llvm.sub %29, %30 : i64
    %32 = llvm.inttoptr %31 : i64 to !llvm.ptr
    %33 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %34 = llvm.insertvalue %25, %33[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %32, %34[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.mlir.constant(0 : index) : i64
    %37 = llvm.insertvalue %36, %35[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.insertvalue %18, %37[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.insertvalue %19, %38[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%17 : i64)
  ^bb1(%40: i64):  // 2 preds: ^bb0, ^bb2
    %41 = llvm.icmp "slt" %40, %16 : i64
    llvm.cond_br %41, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %42 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.getelementptr inbounds|nuw %42[%40] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %14, %43 : f32, !llvm.ptr
    %44 = llvm.add %40, %15 : i64
    llvm.br ^bb1(%44 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%17 : i64)
  ^bb4(%45: i64):  // 2 preds: ^bb3, ^bb8
    %46 = llvm.icmp "slt" %45, %16 : i64
    llvm.cond_br %46, ^bb5, ^bb9
  ^bb5:  // pred: ^bb4
    llvm.br ^bb6(%17 : i64)
  ^bb6(%47: i64):  // 2 preds: ^bb5, ^bb7
    %48 = llvm.icmp "slt" %47, %16 : i64
    llvm.cond_br %48, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %49 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.mlir.constant(3 : index) : i64
    %51 = llvm.mul %45, %50 overflow<nsw, nuw> : i64
    %52 = llvm.add %51, %47 overflow<nsw, nuw> : i64
    %53 = llvm.getelementptr inbounds|nuw %49[%52] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %54 = llvm.load %53 : !llvm.ptr -> f32
    %55 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %56 = llvm.getelementptr inbounds|nuw %55[%45] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %57 = llvm.load %56 : !llvm.ptr -> f32
    %58 = llvm.fadd %54, %57 : f32
    %59 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %60 = llvm.getelementptr inbounds|nuw %59[%45] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %58, %60 : f32, !llvm.ptr
    %61 = llvm.add %47, %15 : i64
    llvm.br ^bb6(%61 : i64)
  ^bb8:  // pred: ^bb6
    %62 = llvm.add %45, %15 : i64
    llvm.br ^bb4(%62 : i64)
  ^bb9:  // pred: ^bb4
    llvm.br ^bb10(%17 : i64)
  ^bb10(%63: i64):  // 2 preds: ^bb9, ^bb12
    %64 = llvm.icmp "slt" %63, %16 : i64
    llvm.cond_br %64, ^bb11, ^bb13
  ^bb11:  // pred: ^bb10
    %65 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %66 = llvm.getelementptr inbounds|nuw %65[%63] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %67 = llvm.load %66 : !llvm.ptr -> f32
    %68 = llvm.fcmp "one" %67, %14 : f32
    llvm.cond_br %68, ^bb12, ^bb14
  ^bb12:  // pred: ^bb11
    %69 = llvm.fdiv %13, %67 : f32
    %70 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %71 = llvm.getelementptr inbounds|nuw %70[%63] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %69, %71 : f32, !llvm.ptr
    %72 = llvm.add %63, %15 : i64
    llvm.br ^bb10(%72 : i64)
  ^bb13:  // pred: ^bb10
    llvm.return
  ^bb14:  // pred: ^bb11
    %73 = llvm.mlir.addressof @assert_msg : !llvm.ptr
    %74 = llvm.getelementptr %73[0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<40 x i8>
    llvm.call @puts(%74) : (!llvm.ptr) -> ()
    llvm.call @abort() : () -> ()
    llvm.unreachable
  }
}

