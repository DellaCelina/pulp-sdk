include(props)
include(hal_files)
include(hal_src_files)

set(SOURCES

# add common files
include/hal/pulp.h
include/hal/utils.h
include/hal/pulp_io.h
include/hal/debug_bridge/debug_bridge.h
include/hal/gvsoc/gvsoc.h
include/hal/tb/tb.h

# add hal files
${HAL_FILES}
${HAL_SRC_FILES}
)