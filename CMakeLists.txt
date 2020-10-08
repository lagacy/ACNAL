# CMakeList.txt : fichier projet CMake de niveau supérieur, effectuez une configuration globale
# et incluez les sous-projets ici.
#
cmake_minimum_required (VERSION 3.8)

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

if(MSVC)
# warning level 4 and all warnings as errors, use c++17 latest features
add_compile_options(/W4 /EHsc /Za /std:c++17)
else()
# lots of warning and all warnings as error, use c++17
add_compile_options(-Wall -Wextra -pedantic -Werror -std=c++17)
endif()

# Incluez les sous-projets.
add_subdirectory ("src")
