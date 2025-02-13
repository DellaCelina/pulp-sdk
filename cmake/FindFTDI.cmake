execute_process(COMMAND libftdi1-config --cflags OUTPUT_VARIABLE FTDI_INCLUDE_DIRS OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND libftdi1-config --libs OUTPUT_VARIABLE FTDI_LIBRARIES OUTPUT_STRIP_TRAILING_WHITESPACE)

if(NOT FTDI_LIBRARIES)
    execute_process(COMMAND libftdi-config --cflags OUTPUT_VARIABLE FTDI_INCLUDE_DIRS OUTPUT_STRIP_TRAILING_WHITESPACE)
    execute_process(COMMAND libftdi-config --libs OUTPUT_VARIABLE FTDI_LIBRARIES OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()