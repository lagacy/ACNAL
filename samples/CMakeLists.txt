cmake_minimum_required (VERSION 3.8)

if(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
find_library(ACNAL_LOC NAMES ACNAL PATHS $<TARGET_FILE_DIR:ACNAL>)
add_executable(APIClientLog ./APIClientLog/main.cpp)
set_target_properties(APIClientLog
 PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY_DEBUG "${PROJECT_BINARY_DIR}/bin"
)
target_include_directories(APIClientLog PUBLIC
	"${PROJECT_BINARY_DIR}"
	"${PROJECT_SOURCE_DIR}/samples"
)
target_link_libraries(APIClientLog ACNAL)
endif()