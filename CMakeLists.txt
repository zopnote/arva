cmake_minimum_required(VERSION 3.10)

project(athylen_sdk)

install(FILES ${CMAKE_SOURCE_DIR}/README.md DESTINATION /)
install(FILES ${CMAKE_SOURCE_DIR}/LICENSE DESTINATION /)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/docs DESTINATION /)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/templates DESTINATION /)

add_subdirectory(bin)