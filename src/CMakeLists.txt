

message( "${CMAKE_CONFIGURATION_TYPES}")
if(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
	message("The build is in DEBUG")
	add_executable (TestClient "TestClient/main.cpp")
	add_library (ACNAL SHARED "Core/ACNAL.cpp" "Core/ACNAL.h" "Core/_premh.h")
endif(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
