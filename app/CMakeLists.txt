find_package(Boost COMPONENTS program_options REQUIRED)

bin(
	NAME 
        app
	
	SRCS 
        main.cpp
        app.cpp
		version.cpp

	DEPS 
        libbar
        ${Boost_PROGRAM_OPTIONS_LIBRARY}

	INSTALL TAG
	)
