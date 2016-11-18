file(GLOB SRCS "src/*.cpp")

lib(
    NAME   eastl
    STATIC
    MODULE 3rd-party
    SRCS   ${SRCS}
    )

target_include_directories(eastl.lib SYSTEM PUBLIC "${CMAKE_CURRENT_LIST_DIR}/include")
target_compile_options    (eastl.lib PRIVATE -Wno-unused-local-typedefs)
target_compile_options    (eastl.lib PRIVATE -Wno-unused-parameter)
