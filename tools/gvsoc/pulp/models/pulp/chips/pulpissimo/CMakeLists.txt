vp_model(
    NAME apb_soc_impl
    DEST pulp/chips/pulpissimo
    SOURCES apb_soc_impl.cpp
)

install(
    FILES rom.bin debug_rom.bin
    DESTINATION python/pulp/chips/pulpissimo
)