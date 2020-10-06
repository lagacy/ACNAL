# CMAKE file that only manage subdir inclusion

message( "${CMAKE_CONFIGURATION_TYPES}")
if(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
	message("The build is in DEBUG")
	add_subdirectory ("TestClient")
endif(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
add_subdirectory ("Core")
