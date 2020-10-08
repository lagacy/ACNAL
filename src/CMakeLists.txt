
message( "${CMAKE_CONFIGURATION_TYPES}")
if(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
add_subdirectory(TestClient)
endif()
add_subdirectory(Core)
