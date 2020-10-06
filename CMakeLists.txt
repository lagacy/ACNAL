# CMakeList.txt : fichier projet CMake de niveau supérieur, effectuez une configuration globale
# et incluez les sous-projets ici.
#
cmake_minimum_required (VERSION 3.8)

project ("ACNAL")

if(MSVC)
# warning level 4 and all warnings as errors, use c++20 latest features
add_compile_options(/W4 /WX /EHsc /Za /std:c++latest)
else()
# lots of warning and all warnings as error, use c++20
add_compile_options(-Wall -Wextra -pedantic -Werror -std=c++20)
endif()

# Incluez les sous-projets.
add_subdirectory ("src")
