# CMakeList.txt : fichier projet CMake de niveau supérieur, effectuez une configuration globale
# et incluez les sous-projets ici.
#
cmake_minimum_required (VERSION 3.8)

project ("ACNAL" LANGUAGES CXX)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

if(MSVC)
# warning level 4 and all warnings as errors, use c++17 latest features
add_compile_options(/W4 /EHsc /Za /std:c++17)
else()
# lots of warning and all warnings as error, use c++17
add_compile_options(-Wall -Wextra -pedantic -Werror -std=c++17)
endif()

# Incluez les sous-projets.
add_subdirectory ("src")
