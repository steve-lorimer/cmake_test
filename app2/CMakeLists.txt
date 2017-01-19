create_version("app2" version.cpp)

bin(
    NAME 
        app2
    
    SRCS 
        main.cpp
        app2.cpp
        version.cpp

    LIBS 
        foo.lib
        ${LIB_BOOST_PROGRAM_OPTIONS}

    TAG
    )

# ensure that the version info is generated before we try compile version
add_dependencies(app2.bin version_info.app2)
