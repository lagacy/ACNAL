cmake_minimum_required (VERSION 3.8)

#setup all your packages dependencies here

message(STATUS "Configuring Gtest package")
enable_testing()
find_package(GTest)

if(NOT ${GTEST_FOUND})

	message(STATUS "Gtest package can't be found")
	if(WIN32)
	message(STATUS "Installing GTest for windows")
	execute_process(
		COMMAND
			./external/vcpkg/vcpkg install gtest:x64-windows
		WORKING_DIRECTORY
			${PROJECT_SOURCE_DIR}
		OUTPUT_VARIABLE VCPKG_RESULT
    )
	 message("${VCPKG_RESULT}")

	 else()
	 message(STATUS "Installing GTest for unix")
	 execute_process(
		COMMAND
			./external/vcpkg/vcpkg install GTest
		WORKING_DIRECTORY
			${PROJECT_SOURCE_DIR}
		OUTPUT_VARIABLE VCPKG_RESULT
    )
	 message("${VCPKG_RESULT}")
	 endif()

     find_package(GTest REQUIRED)
	else()
		message(STATUS "Gtest is installed")
endif()
