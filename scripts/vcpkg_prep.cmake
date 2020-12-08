# This script manage the vcpkg submodule

cmake_minimum_required (VERSION 3.8)
set(vcpkg_root "${PROJECT_SOURCE_DIR}/external/vcpkg" CACHE PATH "absolute path to the vcpkg local repos root")
set(vcpkg_toolchain "${vcpkg_root}/scripts/buildsystems/vcpkg.cmake" CACHE PATH "absolute path to the vcpkg toolchain file")
set(vcpkg_exe "${vcpkg_root}/vcpkg.exe" CACHE PATH "absolute path to the vcpkg exe file")

# We check if vcpkg is already usable
message(STATUS "Checking if vcpkg is availlable")
function(vcpkg_setup)

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
endfunction()