cmake_minimum_required (VERSION 3.8)

add_library(ACNAL 
 SHARED
  ACNAL.cpp
  ACNAL.h
  _premh.h
)

set_target_properties(ACNAL
 PROPERTIES
  CXX_STANDARD 17
  CXX_EXTENSIONS OFF
  CXX_STANDARD_REQUIRED ON
)