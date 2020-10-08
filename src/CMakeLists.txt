cmake_minimum_required (VERSION 3.8)

message( "This is using ${CMAKE_CONFIGURATION_TYPES}")
if(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
add_subdirectory(TestClient)
endif()
add_subdirectory(Core)
