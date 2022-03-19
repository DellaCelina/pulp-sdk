function(pmsis_build_app)
    cmake_parse_arguments(
        PULP 
        ""
        "APP;PLATFORM"
        "SOURCES;INCLUDE_DIRS;LIBRARIES;CFLAGS;LDFLAGS;RUNNER_CONFIG;RUNNER_ARGS"
        ${ARGN}
    )

    if(NOT DEFINED ENV{BOARD_NAME})
        message(FATAL_ERROR "Need BOARD_NAME environment variable")
    endif()
    set(BOARD_NAME $ENV{BOARD_NAME})

    set(PULP_TOOLCHAIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/toolchain)

    # default platform
    if(NOT DEFINED PULP_PLATFORM)
        set(PULP_PLATFORM gvsoc)
    endif()

    if(DEFINED PULP_RUNNER_CONFIG)
        list(APPEND config_args --config-ini=${PULP_RUNNER_CONFIG})
    endif

    if(DEFINED PULP_RUNNER_ARGS)
        set(ENV{GVSOC_OPTIONS} ${PULP_RUNNER_ARGS})
    endif

    set(PULP_MARCHI rv32imcxgap9)

    # setconfigs
    set(CONFIG_IO_UART_ITF 0)
    set(CONFIG_IO_UART_BAUDRATE 115200)
    set(CONFIG_IO_UART 0)
    set(CONFIG_TRACE_LEVEL 3)
    set(CONFIG_LOG_LOCAL_LEVEL 2)

    set(PULP_CC ${PULP_TOOLCHAIN_DIR}/bin/riscv32-unknown-elf-gcc)
    set(PULP_AR ${PULP_TOOLCHAIN_DIR}/bin/riscv32-unknown-elf-ar)
    set(PULP_LD ${PULP_TOOLCHAIN_DIR}/bin/riscv32-unknown-elf-gcc)
    set(PULP_OBJDUMP ${PULP_TOOLCHAIN_DIR}/bin/riscv32-unknown-elf-objdump)

    list(APPEND PULP_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/pulpos/include
        ${CMAKE_CURRENT_SOURCE_DIR}/pmsis/include
    )

    list(APPEND PULP_LIBRARIES
        gcc
    )

    list(APPEND PULP_CFLAGS
        -MMD
        -MP
        -D__riscv__
        -fdata-sections
        -ffunction-sections
        -fno-jump-tables
        -fno-tree-loop-distribute-patterns
        -D__PULPOS2__
        -DPOS_CONFIG_IO_UART=${CONFIG_IO_UART}
        -DPOS_CONFIG_IO_UART_BAUDRATE=${CONFIG_IO_UART_BAUDRATE}
        -DPOS_CONFIG_IO_UART_ITF=${CONFIG_IO_UART_ITF}
        -D__TRACE_LEVEL__=${CONFIG_TRACE_LEVEL}
        -DPI_LOG_LOCAL_LEVEL=${CONFIG_LOG_LOCAL_LEVEL}
        #-include pos/chips/pulp/config.h
        #-I$(PULPOS_PULP_HOME)/include/pos/chips/pulp
        #-I$(PULPOS_HOME)/lib/libc/minimal/include
        #-I$(PULPOS_HOME)/include -I$(PULPOS_HOME)/kernel -I$(PULPOS_ARCHI)/include -I$(PULPOS_HAL)/include -I$(PMSIS_API)/include
        #$(foreach inc,$(PULPOS_MODULES),-I$(inc)/include)
    )

    if(${PULP_PLATFORM} STREQUAL gvsoc)
        list(APPEND PULP_CFLAGS -D__PLATFORM__=ARCHI_PLATFORM_GVSOC)
    elseif(${PULP_PLATFORM STREQUAL board)
        list(APPEND PULP_CFLAGS -D__PLATFORM__=ARCHI_PLATFORM_BOARD)
    elseif(${PULP_PLATFORM STREQUAL rtl)
        list(APPEND PULP_CFLAGS -D__PLATFORM__=ARCHI_PLATFORM_RTL)
    elseif(${PULP_PLATFORM STREQUAL fpga)
        list(APPEND PULP_CFLAGS -D__PLATFORM__=ARCHI_PLATFORM_FPGA)
    endif()

    if(DEFINED cluster/nb_pe)
        list(APPEND PULP_CFLAGS -DARCHI_CLUSTER_NB_PE=${cluster/nb_pe})
        list(APPEND config_args --config-opt=cluster/nb_pe=${cluster/nb_pe})
    endif()

    list(APPEND PULP_LDFLAGS
        -nostartfiles
        -nostdlib
        -Wl,--gc-sections
        #-L$(PULPOS_PULP_HOME)/kernel
        #-Tchips/pulp/link.ld
    )

    list(APPEND PULP_ARCH_CFLAGS
        -march=${PULP_MARCHI}
        -mPE=${cluster/nb_pe}
        -mFC=1
    )

    list(APPEND PULP_ARCH_LDFLAGS
        -march=${PULP_MARCHI}
        -mPE=${cluster/nb_pe}
        -mFC=1
    )

    list(APPEND PULP_OBJDFLAGS
        -Mmarch=${PULP_MARCHI}
    )

    list(APPEND PULP_OMP_CFLAGS
        -fopenmp
        -mnativeomp
    )

    list(APPEND PULP_SOURCES
        kernel/fll-v${fll/version}.c
        kernel/freq-domains.c
        kernel/chips/pulp/soc.c
        lib/libc/minimal/io.c
        lib/libc/minimal/fprintf.c
        lib/libc/minimal/prf.c
        lib/libc/minimal/sprintf.c
        lib/libc/minimal/semihost.c
        kernel/init.c
        kernel/kernel.c
        kernel/device.c
        kernel/task.c
        kernel/alloc.c
	    kernel/alloc_pool.c
        kernel/irq.c
        kernel/soc_event.c
        kernel/log.c
        kernel/time.c
    )

    list(APPEND PULP_ASM_SOURCES
        kernel/crt0.S
        kernel/irq_asm.S
        kernel/task_asm.S
        kernel/time_asm.S
    )

    if(DEFINED soc_eu/version)
        list(APPEND PULP_ASM_SOURCES
            kernel/soc_event_v${soc_eu/version}_itc.S
        )
    else()
        list(APPEND PULP_ASM_SOURCES
            kernel/soc_event_eu.S
        )
    endif()

    if(DEFINED udma/hyper/version)
        list(APPEND PULP_SOURCES
            drivers/hyperbus/hyperbus-v${udma/hyper/version}.c
        )
    endif()

    if(DEFINED udma/spim/version)
        list(APPEND PULP_SOURCES
            drivers/spim/spim-v${udma/spim/version}.c
        )
    endif()

    if(DEFINED udma/uart/version)
        list(APPEND PULP_SOURCES
            drivers/uart/uart-v${udma/uart/version}.c
        )
    endif()

    if(DEFINED udma/i2s/version)
        list(APPEND PULP_SOURCES
            drivers/i2s/i2s-v${udma/i2s/version}.c
        )
    endif()

    if(DEFINED udma/i2c/version)
        list(APPEND PULP_SOURCES
            drivers/i2c/i2c-v${udma/i2c/version}.c
        )
    endif()

    if(DEFINED udma/version)
        list(APPEND PULP_CFLAGS 
            D__CONFIG_UDMA__
        )
        list(APPEND PULP_SOURCES
            drivers/udma/udma-v${udma/archi}.c
        )
    endif()

    if(DEFINED gpi/version)
        list(APPEND PULP_SOURCES
            drivers/gpio/gpio-v${gpio/version}.c
        )
        list(APPEND PULP_ASM_SOURCES
            drivers/gpio/gpio-v${gpio/version}_asm.S
        )
    endif()

    if(DEFINED padframe/version)
        list(APPEND PULP_SOURCES
            drivers/pads/pads-v${padframe/version}.c
        )
    endif()

    if(DEFINED cluster/version)
        list(APPEND PULP_SOURCES
            PULP_SRCS += drivers/cluster/cluster.c
        )
        list(APPEND PULP_ASM_SOURCES
            drivers/cluster/pe-eu-v${event_unit/version}.S
            drivers/cluster/pe-eu-v${event_unit/version}_task.S
        )
    endif()

    add_executable(${PULP_APP}
        ${PULP_SOURCES}
        ${PULP_ASM_SOURCES}
    )
    target_include_directories(${PULP_APP} PRIVATE ${PULP_INCLUDE_DIRS})
    target_link_libraries(${PULP_APP} PRIVATE ${PULP_LIBRARIES})
    target_compile_options(${PULP_APP} PRIVATE ${PULP_CFLAGS})
    target_link_options(${PULP_APP} PRIVATE ${PULP_LD_FLAGS})

    add_custom_target(
        image ALL
        COMMAND
            gapy
            --target=${BOARD_NAME}
            --platform=${PULP_PLATFORM}
            --work-dir=${CMAKE_BINARY_DIR}
            ${config_args}
            ${gapy_args}
            run
            --image
            --binary=${PULP_APP}
            ${PULP_RUNNER_ARGS}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "GAPY image"
    )

    add_custom_target(
        flash ALL
        COMMAND
            gapy
            --work-dir=${CMAKE_BINARY_DIR}
            ${config_args}
            ${gapy_args}
            run
            --flash
            --binary=${PULP_APP}
            ${PULP_RUNNER_ARGS}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "GAPY flash"
    )

    add_custom_target(
        run
        COMMAND
            gapy
            --work-dir=${CMAKE_BINARY_DIR}
            ${config_args}
            ${gapy_args}
            run
            --exec-prepare
            --exec
            --binary=${PULP_APP}
            ${PULP_RUNNER_ARGS}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "GAPY flash"
    )
endfunction()