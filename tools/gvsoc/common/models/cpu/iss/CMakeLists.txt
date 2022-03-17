# generate decoder files
function(gen_decoder)
    cmake_parse_arguments(
        ISS
        ""
        "TARGET"
        "FLAGS"
        ${ARGN}
    )

    add_custom_command(
        OUTPUT iss_wrapper/${ISS_TARGET}_decoder_gen.hpp
        COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/isa_gen/isa_riscv_gen.py
        --source-file=iss_wrapper/${ISS_TARGET}_decoder_gen.cpp
        --header-file=iss_wrapper/${ISS_TARGET}_decoder_gen.hpp ${ISS_FLAGS}
        COMMENT "Generate ${ISS_TARGET} decoder hpp"
    )

    add_custom_command(
        OUTPUT iss_wrapper/${ISS_TARGET}_decoder_gen.cpp
        COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/isa_gen/isa_riscv_gen.py
        --source-file=iss_wrapper/${ISS_TARGET}_decoder_gen.cpp
        --header-file=iss_wrapper/${ISS_TARGET}_decoder_gen.hpp ${ISS_FLAGS}
        COMMENT "Generate ${ISS_TARGET} decoder cpp"
    )
endfunction()

gen_decoder(
    TARGET riscy
)

gen_decoder(
    TARGET zeroriscy
    FLAGS --implem=zeroriscy
)

# define vp model from iss_class
function(define_iss)
    cmake_parse_arguments(
        ISS
        ""
        ""
        "TARGETS"
        ${ARGN}
    )

    file(GLOB COMMON_SRCS
        cpu/iss/vp/src/iss_wrapper.cpp
        cpu/iss/src/iss.cpp
        cpu/iss/src/insn_cache.cpp
        cpu/iss/src/csr.cpp
        cpu/iss/src/decoder.cpp cpu/iss/src/trace.cpp
        cpu/iss/flexfloat/flexfloat.c
    )

    set(INCLUDE_DIRS
        include
        vp/include
        flexfloat
    )

    set(COMMON_CFLAGS -DRISCV=1 -DRISCY -march=native -fno-strict-aliasing)

    if("iss_zeroriscy" IN_LIST ISS_TARGETS)
        vp_model(
            NAME iss_zeroriscy
            DEST cpu/iss
            SOURCES
                ${COMMON_SRCS}
                iss_wrapper/zeroriscy_decoder_gen.cpp
            INCLUDE_DIRS ${INCLUDE_DIRS}
            CFLAGS
                ${COMMON_CFLAGS}
                -DPIPELINE_STAGES=1
                -DISS_SINGLE_REGFILE
        )
    endif()

    if("iss_riscy_single_regfile" IN_LIST ISS_TARGETS)
        vp_model(
            NAME iss_riscy_single_regfile
            DEST cpu/iss
            SOURCES
                ${COMMON_SRCS}
                iss_wrapper/riscy_decoder_gen.cpp
            INCLUDE_DIRS ${INCLUDE_DIRS}
            CFLAGS
                ${COMMON_CFLAGS}
                -DPIPELINE_STAGES=2
                -DISS_SINGLE_REGFILE
        )
    endif()

    if("iss_riscy_v2_5_single_regfile" IN_LIST ISS_TARGETS)
        vp_model(
            NAME iss_riscy_v2_5_single_regfile
            DEST cpu/iss
            SOURCES
                ${COMMON_SRCS}
                iss_wrapper/riscy_decoder_gen.cpp
            INCLUDE_DIRS ${INCLUDE_DIRS}
            CFLAGS
                ${COMMON_CFLAGS}
                -DPIPELINE_STAGES=2
                -DISS_SINGLE_REGFILE
                -DPCER_VERSION_2
                -DPRIV_1_10
        )
    endif()

    if("iss_riscy_v2_5" IN_LIST ISS_TARGETS)
        vp_model(
            NAME iss_riscy_v2_5
            DEST cpu/iss
            SOURCES
                ${COMMON_SRCS}
                iss_wrapper/riscy_decoder_gen.cpp
            INCLUDE_DIRS ${INCLUDE_DIRS}
            CFLAGS
                ${COMMON_CFLAGS}
                -DPIPELINE_STAGES=2
                -DPCER_VERSION_2
                -DPRIV_1_10
        )
    endif()

    if("iss_riscy" IN_LIST ISS_TARGETS)
        vp_model(
            NAME iss_riscy
            DEST cpu/iss
            SOURCES
                ${COMMON_SRCS}
                iss_wrapper/riscy_decoder_gen.cpp
            INCLUDE_DIRS ${INCLUDE_DIRS}
            CFLAGS
                ${COMMON_CFLAGS}
                -DPIPELINE_STAGES
        )
    endif()
endfunction()

define_iss(
    TARGETS
        ${fc/iss_class}
        ${pe/iss_class}
)