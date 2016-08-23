find_package(Boost COMPONENTS program_options REQUIRED)

bin(
    NAME 
        app
    
    SRCS 
        main.cpp
        app.cpp
        version.cpp

    LIBS 
        bar_lib
        ${Boost_PROGRAM_OPTIONS_LIBRARY}

    DEPS
        version_info

    INSTALL
        app

    TAG
    )
