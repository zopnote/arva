cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_COMPILER clang)

project(arva_sdk)


set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

install(FILES ${CMAKE_SOURCE_DIR}/README.md DESTINATION /)
add_subdirectory(bin)
add_subdirectory(core)