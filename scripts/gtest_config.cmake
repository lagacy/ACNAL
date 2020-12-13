cmake_minimum_required (VERSION 3.8)

#setup all your packages dependencies here
option(BUILD_TESTS "Enable tests pipeline" ON)

if(${BUILD_TESTS})
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

macro(package_add_test TESTNAME)
    # create an exectuable in which the tests will be stored
    add_executable(${TESTNAME} ${ARGN})
    # link the Google test infrastructure, mocking library, and a default main fuction to
    # the test executable.  Remove g_test_main if writing your own main function.
    target_link_libraries(${TESTNAME} GTest::gtest GTest::gmock GTest::gtest_main)
    # gtest_discover_tests replaces gtest_add_tests,
    # see https://cmake.org/cmake/help/v3.10/module/GoogleTest.html for more options to pass to it
    gtest_discover_tests(${TESTNAME}
        # set a working directory so your project root so that you can find test data via paths relative to the project root
        WORKING_DIRECTORY ${PROJECT_DIR}
        PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_DIR}"
    )
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests)
endmacro()
endif(${BUILD_TESTS})
