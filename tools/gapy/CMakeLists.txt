cmake_minimum_required(VERSION 3.5)

project(gapy)

# set environments for property generation
set(ENV{PYTHONPATH} "${CMAKE_CURRENT_SOURCE_DIR}:$ENV{PYTHONPATH}")

# generate property from json
set(PROPERTIES
  udma/version
  timer/version
  stdout/version
  soc_eu/version
  fc_itc/version
  icache_ctrl/version
  xne/version
  fll/version
  event_unit/version
  cluster_ctrl/version
  pulp_chip
  cluster/version
  dma/version
  udma/spim/version
  udma/cpi/version
  padframe/version
  pulp_chip_family
  pmu/version
  udma/hyper/version
  efuse/version
  udma/i2c/version
  rtc/version
  gpio/version
  fc/iss_class
  pe/iss_class
  udma/i2s/version
  udma/mram/version
  hwce/version
  udma/tcdm/version
  hwacc/base
  udma/uart/version
  udma/hyper/version
  ima/version
)

foreach(prop ${PROPERTIES})
    set(PROP_FLAGS "--property=${prop}" ${PROP_FLAGS})
endforeach()

set(PROPS_CMAKE ${CMAKE_BINARY_DIR}/cmake/props.cmake)
execute_process(
    COMMAND 
        ${CMAKE_CURRENT_SOURCE_DIR}/bin/plpinfo
        cmakegen
        --cmakefile=${PROPS_CMAKE}
        ${PROP_FLAGS}
)

set(HAL_FILES_CMAKE ${CMAKE_BINARY_DIR}/cmake/hal_files.cmake)
execute_process(
    COMMAND
        ${CMAKE_CURRENT_SOURCE_DIR}/bin/plpfiles
        cmakegen
        --item=hal_files
        --cmakefile=${HAL_FILES_CMAKE}
        --var=HAL_FILES
)

set(HAL_SRC_FILES_CMAKE ${CMAKE_BINARY_DIR}/cmake/hal_src_files.cmake)
execute_process(
    COMMAND
        ${CMAKE_CURRENT_SOURCE_DIR}/bin/plpfiles
        cmakegen
        --item=hal_src_files
        --cmakefile=${HAL_SRC_FILES_CMAKE}
        --var=HAL_SRC_FILES
)

install(
    FILES
        ${PROPS_CMAKE}
        ${HAL_FILES_CMAKE}
        ${HAL_SRC_FILES_CMAKE}
    DESTINATION cmake
)

install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
    DESTINATION python/gapy
    FILES_MATCHING PATTERN "*.py"
)