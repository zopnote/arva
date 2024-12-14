find_program(FLUTTER_SDK flutter PATHS ${FLUTTER_SDK})

if(NOT FLUTTER_SDK)
    message(FATAL_ERROR "Flutter not found! Make sure Flutter is installed and in PATH.")
endif()

set(SOURCE_FLUTTER_ROOT ${CMAKE_SOURCE_DIR}/bin/ui)
set(BINARY_FLUTTER_ROOT ${CMAKE_BINARY_DIR}/bin/ui)

file(GLOB FLUTTER_PROJECT_FILES ${SOURCE_FLUTTER_ROOT}/*)
file(COPY ${FLUTTER_PROJECT_FILES} DESTINATION ${BINARY_FLUTTER_ROOT})

set(FLUTTER_ENTRY_POINT ${BINARY_FLUTTER_ROOT}/lib/main.dart)

set(OUTPUT ${BINARY_FLUTTER_ROOT}/build/${TARGET}/${ARCHITECTURE}/runner/Release)
set(OUTPUT_EXECUTABLE ${OUTPUT}/ui.exe)

add_custom_command(
    OUTPUT ${OUTPUT_EXECUTABLE}
    COMMAND ${FLUTTER_SDK} build ${TARGET} ${FLUTTER_ENTRY_POINT}
    DEPENDS ${FLUTTER_ENTRY_POINT}
    WORKING_DIRECTORY ${BINARY_FLUTTER_ROOT}
    COMMENT "Compiling Flutter app at '${BINARY_FLUTTER_ROOT}' to native application '${OUTPUT}'"
)

add_custom_target(build_flutter ALL DEPENDS ${OUTPUT_EXECUTABLE})

install(FILES ${OUTPUT_EXECUTABLE} DESTINATION bin/ui)
install(FILES ${OUTPUT}/flutter_windows.dll DESTINATION bin/ui)
install(DIRECTORY ${OUTPUT}/data DESTINATION bin/ui)
