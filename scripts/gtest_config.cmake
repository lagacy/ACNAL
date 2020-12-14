cmake_minimum_required (VERSION 3.8)
#setup all your packages dependencies here
option(BUILD_TESTS "Enable tests pipeline" ON)

if(${BUILD_TESTS})
message(STATUS "Configuring Gtest package")
enable_testing()¸

find_package(GTest)
if(NOT ${GTEST_FOUND})

	message(STATUS "Gtest package can't be found")
	# Download and unpack googletest at configure time
	configure_file(${PROJECT_SOURCE_DIR}/CMakeLists.txt.in googletest-download/CMakeLists.txt)
	execute_process(COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
		WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/googletest-download"
	)
	execute_process(COMMAND "${CMAKE_COMMAND}" --build .
		WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/googletest-download"
	)

	# Prevent GoogleTest from overriding our compiler/linker options
	# when building with Visual Studio
	set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

	# Add googletest directly to our build. This adds the following targets:
	# gtest, gtest_main, gmock and gmock_main
	add_subdirectory("${CMAKE_BINARY_DIR}/googletest-src"
					"${CMAKE_BINARY_DIR}/googletest-build"
	)

	# The gtest/gmock targets carry header search path dependencies
	# automatically when using CMake 2.8.11 or later. Otherwise we
	# have to add them here ourselves.
	if(CMAKE_VERSION VERSION_LESS 2.8.11)
		include_directories("${gtest_SOURCE_DIR}/include"
							"${gmock_SOURCE_DIR}/include"
		)

# Now simply link your own targets against gtest, gmock,
# etc. as appropriate

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
