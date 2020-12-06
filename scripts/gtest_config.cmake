cmake_minimum_required (VERSION 3.8)

#setup all your packages dependencies here

message(STATUS "Configuring Gtest package")

enable_testing()
find_package(GTest)

if(NOT ${GTEST_FOUND})

	message(STATUS "Gtest package can't be found")
	else()

endif()
