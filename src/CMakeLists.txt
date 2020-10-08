cmake_minimum_required (VERSION 3.8)

file(GLOB_RECURSE SFCollection "*.cpp")
file(GLOB_RECURSE HFCollection "*.h")


add_library(ACNAL 
 SHARED
  ${SFCollection}
)

set_target_properties(ACNAL
 PROPERTIES
  CXX_STANDARD 17
  CXX_EXTENSIONS OFF
  CXX_STANDARD_REQUIRED ON
)