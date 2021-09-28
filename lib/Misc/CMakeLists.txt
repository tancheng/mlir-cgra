add_mlir_dialect_library(SODAMisc
    MiscPasses.cpp
    AffineDataCopyGen.cpp
    MemrefEraseDealloc.cpp

    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/include/

    DEPENDS
    MLIRSODAMiscPassesIncGen

	LINK_LIBS PUBLIC
	MLIRIR
    MLIRPass
	)
