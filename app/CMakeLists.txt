create_version("app" version.cpp)

bin(
    NAME 
        app
    
    SRCS 
        main.cpp
        app.cpp
        version.cpp

    LIBS 
        bar.lib
        ${LIB_BOOST_PROGRAM_OPTIONS}

    TAG
    )

# ensure that the version info is generated before we try compile version
add_dependencies(app.bin version_info.app)
