cmake_minimum_required(VERSION 3.5)
project(gap-configs)

# set pulp config properties
if(NOT DEFINED ENV{BOARD_NAME})
  message(FATAL_ERROR "Need to set BOARD_NAME environment variable")
endif()

set(ENV{PULP_CONFIGS}
"$ENV{BOARD_NAME}@config_file=config/$ENV{BOARD_NAME}.json")

set(ENV{PULP_CONFIGS_PATH}
"${CMAKE_CURRENT_SOURCE_DIR}/configs:$ENV{PULP_CONFIGS_PATH}")

install(
  DIRECTORY configs/
  DESTINATION configs
  FILES_MATCHING PATTERN "*.json"
)

install(
  DIRECTORY targets/
  DESTINATION targets
  FILES_MATCHING PATTERN "*.json"
)