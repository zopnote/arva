find_program(DART_COMPILER dart PATHS ${DART_SDK})

if(NOT DART_COMPILER)
    message(FATAL_ERROR "Dart compiler not found! Make sure Dart is installed and in PATH.")
endif()

set(ENTRY_POINT ${CMAKE_SOURCE_DIR}/bin/src/main.dart)
set(OUTPUT_EXECUTABLE ${CMAKE_BINARY_DIR}/bin/arva.exe)

file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_custom_command(
    OUTPUT ${OUTPUT_EXECUTABLE}
    COMMAND ${DART_COMPILER} compile exe ${ENTRY_POINT} -o ${OUTPUT_EXECUTABLE}
    DEPENDS ${ENTRY_POINT}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Compiling Dart script '${ENTRY_POINT}' to executable '${OUTPUT_EXECUTABLE}'"
)

add_custom_target(compile_dart ALL DEPENDS ${OUTPUT_EXECUTABLE})

install(FILES ${OUTPUT_EXECUTABLE} DESTINATION bin)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/bin/resources DESTINATION bin)
