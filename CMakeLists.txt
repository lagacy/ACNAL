# CMakeList.txt : fichier projet CMake de niveau supérieur, effectuez une configuration globale
# et incluez les sous-projets ici.
#
cmake_minimum_required (VERSION 3.8)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/tools/vcpkg/scripts/buildsystems/vcpkg.cmake
  CACHE STRING "Vcpkg toolchain file")

project ("ACNAL" LANGUAGES CXX)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

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
