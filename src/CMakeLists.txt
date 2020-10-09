cmake_minimum_required (VERSION 3.8)

file(GLOB_RECURSE SFCollection "private/*.cpp")
file(GLOB_RECURSE HFCollection "public/*.h")


add_library(ACNAL 
 SHARED
  ${SFCollection}
)

set_target_properties(ACNAL
 PROPERTIES
  LINKER_LANGUAGE C
  RUNTIME_OUTPUT_DIRECTORY_DEBUG "${PROJECT_BINARY_DIR}/bin"
)