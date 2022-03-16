cmake_minimum_required(VERSION 3.5)

project(gapy)

include(install_files)

file(GLOB_RECURSE PYTHON_FILES
    *.py
)

install_files(
    FILES ${PYTHON_FILES}
    DEST python/gapy
    BASE ${CMAKE_CURRENT_SOURCE_DIR}
)

install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/configs/ DESTINATION configs
  FILES_MATCHING PATTERN "*.json"
)

install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/targets/ DESTINATION targets
  FILES_MATCHING PATTERN "*.json"
)