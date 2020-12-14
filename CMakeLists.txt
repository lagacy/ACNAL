# CMakeList.txt : High level Cmake configuration file, here we include subproject and generate set project dependencies
#
cmake_minimum_required (VERSION 3.8)

set(vcpkg_root "${PROJECT_SOURCE_DIR}/external/vcpkg" CACHE PATH "absolute path to the vcpkg local repos root")
set(vcpkg_toolchain "${vcpkg_root}/scripts/buildsystems/vcpkg.cmake" CACHE PATH "absolute path to the vcpkg toolchain file")
set(vcpkg_exe "${vcpkg_root}/vcpkg.exe" CACHE PATH "absolute path to the vcpkg exe file")

# We check if vcpkg is already usable
message(STATUS "Checking if vcpkg is availlable")

 if(EXISTS "${PROJECT_SOURCE_DIR}/external/vcpkg" AND EXISTS "${vcpkg_toolchain}" )
  message(STATUS "vcpkg submodule is already initialized")

   # If there is nothing set we need to initialize the repos and bootstrap vcpkg
   else()
    message(STATUS "vcpkg is not availlable, trying to make the setup")
    execute_process(
		COMMAND
			git submodule update --init -- external/vcpkg
		WORKING_DIRECTORY
			${PROJECT_SOURCE_DIR}
		OUTPUT_VARIABLE GIT_RESULT
    )
	 message("${GIT_RESULT}")
     set(CMAKE_TOOLCHAIN_FILE ${vcpkg_toolchain})
 endif()

 if(NOT EXISTS ${vcpkg_exe})
	message(STATUS "vcpkg has not been bootstrapped, trying to run the bootstrap")

	#run the windows .bat script
	if(WIN32)
	message(STATUS "Bootrapping vcpkg for windows")
	execute_process(
		COMMAND
			bootstrap-vcpkg.bat
		WORKING_DIRECTORY
			${vcpkg_root}
		OUTPUT_VARIABLE BOOTSTRAP_RESULT
	   )
	
	# If linux or macos we run the .sh script
		else()
		message(STATUS "Bootrapping vcpkg for MacOS or linux")
		execute_process(
		COMMAND
		bash ./bootstrap-vcpkg.sh
		WORKING_DIRECTORY
			${vcpkg_root}
		OUTPUT_VARIABLE BOOTSTRAP_RESULT
		)

	endif()
 endif()

 # Now verify that vcpkg is added to the toolchain
  if(NOT "${vcpkg_toolchain}" STREQUAL "${CMAKE_TOOLCHAIN_FILE}")
   message(STATUS "vcpkg toolchain location has not been set or is wrong in the cmake_toolchain_file,adding it right now")
  set(CMAKE_TOOLCHAIN_FILE "${vcpkg_toolchain}/scripts/buildsystems/vcpkg.cmake"
    CACHE STRING "Cmake toolchain file")
	if("${vcpkg_toolchain}" STREQUAL "${CMAKE_TOOLCHAIN_FILE}")
		message(STATUS "Has been added successfully to the cmake toolchain")
	else()
	message(SEND_ERROR "vcpkg toolchain can't be set with sucess, try adding it manually in the CMakeSettings.json file with this line : \${projectDir}\external\vcpkg\scripts\buildsystems\vcpkg.cmake")
	endif()
  endif()

  # We verify again if everything is there
  if(EXISTS "${PROJECT_SOURCE_DIR}/external/vcpkg" AND EXISTS "${vcpkg_toolchain}" AND EXISTS ${vcpkg_exe})

		message(STATUS "vcpkg is ready to be used")

		else()
		message(SEND_ERROR "vcpkg submodule can't be setup, manually check it out")
	endif()

project ("ACNAL" LANGUAGES CXX)


set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/lib)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/scripts")

include (doxygen_config)

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
