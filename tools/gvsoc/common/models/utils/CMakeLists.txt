vp_model(
    NAME loader_impl
    DEST utils
    SOURCES loader_impl.cpp
)

vp_model(
    NAME dpi_wrapper_impl
    DEST utils
    SOURCES dpi_wrapper_impl.cpp
    LIBRARIES pulpdpi
)

vp_model(
    NAME injector_impl
    DEST utils
    SOURCES injector_impl.cpp
    LIBRARIES pulpvplauncher
)

vp_model(
    NAME composite_impl
    DEST utils
    SOURCES composite_impl.cpp
)

vp_model(
    NAME clock_impl
    DEST utils
    SOURCES clock_impl.cpp
)

vp_model(
    NAME dpi_chip_wrapper
    DEST utils
    SOURCES dpi_chip_wrapper.cpp
)