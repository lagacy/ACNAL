cmake_minimum_required (VERSION 3.8)

set(DOXYGEN_ROOT "${PROJECT_SOURCE_DIR}/tools/doxygen" CACHE PATH "Location of the root folder")
set(DOXYGEN_MACOS_ARCHIVE "${DOXYGEN_ROOT}/macos/Doxygen-1.8.20.dmg" CACHE PATH "Location of the doxygen for macos")
set(DOXYGEN_LINUX_ARCHIVE "${DOXYGEN_ROOT}/linux/doxygen-1.8.20.linux.bin.tar.gz" CACHE PATH "Location of the doxygen for linux")
set(DOXYGEN_WIN_SETUP "${DOXYGEN_ROOT}/windows/doxygen-1.8.20-setup.exe" CACHE PATH "Location of the doxygen for Windows")

set(DOXYGEN_BINARY_DIR "${DOXYGEN_ROOT}/bin" CACHE PATH "Location of the doxygen binary folder")

set(Doxygen_DIR "${DOXYGEN_BINARY_DIR}")

function(doxygen_setup)
find_package(Doxygen)
if(NOT ${DOXYGEN_FOUND})

	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
	message(STATUS "Unpacking doxygen for Linux")
	file(ARCHIVE_EXTRACT 
		INPUT ${DOXYGEN_LINUX_ARCHIVE}
		DESTINATION ${DOXYGEN_BINARY_DIR}
		VERBOSE
	)

	message(STATUS "Begining Doxygen installation for Linux")
	execute_process(
		COMMAND
			"make install ${DOXYGEN_BINARY_DIR}"
		WORKING_DIRECTORY
			${PROJECT_SOURCE_DIR}
		OUTPUT_VARIABLE SETUP_RESULT
    )
	 message("${SETUP_RESULT}")

	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
	message(STATUS "Unpacking doxygen for MacOS")
	file(ARCHIVE_EXTRACT 
		INPUT ${DOXYGEN_MACOS_ARCHIVE}
		DESTINATION ${DOXYGEN_BINARY_DIR}
		VERBOSE
	)

	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
	message(STATUS "Begining Doxygen installation for windows")
	execute_process(
		COMMAND
			${DOXYGEN_WIN_SETUP}
		WORKING_DIRECTORY
			${PROJECT_SOURCE_DIR}
		OUTPUT_VARIABLE SETUP_RESULT
    )
	 message("${SETUP_RESULT}")
	endif()
	find_package(Doxygen REQUIRED dot
             OPTIONAL_COMPONENTS mscgen dia)
	message(STATUS "Doxygen is now installed and is ready to use")
else()
message(STATUS "Doxygen is installed")
endif()
endfunction(doxygen_setup)