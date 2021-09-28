file(GLOB globbed *.cpp)

add_mlir_dialect_library(SODAMisc
    ${globbed}

    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/include/

    DEPENDS
    MLIRSODAMiscPassesIncGen

	LINK_LIBS PUBLIC
	MLIRIR
    MLIRPass
	)
