file(GLOB SRCS "src/*.cpp")

lib(
    NAME   eastl
    STATIC
    MODULE 3rd-party
    SRCS   ${SRCS}
    )

target_include_directories(eastl PUBLIC "${CMAKE_CURRENT_LIST_DIR}/include")
target_compile_options    (eastl PUBLIC -Wno-unused-local-typedefs)
target_compile_options    (eastl PUBLIC -Wno-unused-parameter)
