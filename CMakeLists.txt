# CMakeList.txt : High level Cmake configuration file, here we include subproject and generate set project dependencies
#
cmake_minimum_required (VERSION 3.8)

project ("ACNAL" LANGUAGES CXX)


set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/lib)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/scripts")

include (vcpkg_prep)
include (doxygen_config)

# vcpkg setup
vcpkg_setup()

# configure gtest
include (gtest_config)

# configure doxygen
doxygen_setup()

#Get the actual OS and store it as a preprocessor definition to be used in source code
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
add_compile_definitions(IS_LINUX)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
add_compile_definitions(IS_MACOS)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
add_compile_definitions(IS_WINDOWS)
endif()

# Get the actual compiler and store it as a preprocessor definition to be used in source code
add_compile_definitions(COMPILER_NAME="${CMAKE_CXX_COMPILER_ID}")

if(CMAKE_CXX_COMPILER_ID MATCHES Intel)
add_compile_definitions(IS_INTEL_CXX_COMPILER)
elseif(CMAKE_CXX_COMPILER_ID MATCHES GNU)
add_compile_definitions(IS_GNU_CXX_COMPILER)
elseif(CMAKE_CXX_COMPILER_ID MATCHES PGI)
add_compile_definitions(IS_PGI_CXX_COMPILER)
elseif(CMAKE_CXX_COMPILER_ID MATCHES XL)
add_compile_definitions(IS_XL_CXX_COMPILER)
elseif(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
add_compile_definitions(IS_MSVC_CXX_COMPILER)
endif()

# See cmakelists in src folder
include_directories("${PROJECT_SOURCE_DIR}/src")
add_subdirectory("src")

# See cmakelists in samples folder
include_directories("${PROJECT_SOURCE_DIR}/samples")
add_subdirectory("samples")

if(${BUILD_TESTS})
	# See cmakelists in tests folder
	include_directories("${PROJECT_SOURCE_DIR}/tests")
	add_subdirectory("tests")
endif(${BUILD_TESTS})
