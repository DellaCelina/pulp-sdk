vp_model(
    NAME ne16
    DEST pulp/ne16
    SOURCES
        src/ne16.cpp
        src/ne16_fsm.cpp
        src/ne16_stream.cpp
        src/ne16_regfile.cpp
        src/ne16_clear.cpp
        src/ne16_load.cpp
        src/ne16_streamin.cpp
        src/ne16_matrixvec.cpp
        src/ne16_streamout.cpp
        src/ne16_normquant.cpp
        src/ne16_index.cpp
        src/ne16_debug.cpp
    INCLUDE_DIRS
        include
    CFLAGS
        -DXTENSOR_USE_XSIMD
        -isystem ${XTENSOR_INCLUDE_DIR}
        -march=native
)