# CMakeList.txt : fichier projet CMake de niveau supérieur, effectuez une configuration globale
# et incluez les sous-projets ici.
#
cmake_minimum_required (VERSION 3.8)

project ("ACNAL" LANGUAGES CXX)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/lib)

find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

if(NOT EXISTS "${PROJECT_SOURCE_DIR}/extern/repo/CMakeLists.txt")
    message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
endif()

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


include_directories("${PROJECT_SOURCE_DIR}/src")
add_subdirectory("src")

if(${CMAKE_CONFIGURATION_TYPES} MATCHES "Debug")
find_library(ACNAL_LOC NAMES ACNAL PATHS $<TARGET_FILE_DIR:ACNAL>)
add_executable(TestClient ./TestClient/main.cpp)
set_target_properties(TestClient
 PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY_DEBUG "${PROJECT_BINARY_DIR}/bin"
)
target_include_directories(TestClient PUBLIC
	"${PROJECT_BINARY_DIR}"
	"${PROJECT_SOURCE_DIR}/src/Core"
)
target_link_libraries(TestClient ACNAL)
endif()
