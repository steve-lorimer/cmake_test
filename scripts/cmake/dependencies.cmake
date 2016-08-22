include_guard(__included_dependencies)
include(find_lib)

set(Boost_USE_STATIC_LIBS ON)

find_program(BASH_EXECUTABLE bash REQUIRED)

# boost
find_package(Boost
    COMPONENTS
        unit_test_framework REQUIRED
        program_options     REQUIRED
        date_time           REQUIRED
        filesystem          REQUIRED
        system              REQUIRED
        iostreams           REQUIRED)

# qt
if(NOT NO_GUI)
    find_package(Qt5Core         REQUIRED)
    find_package(Qt5Gui          REQUIRED)
    find_package(Qt5Widgets      REQUIRED)
    find_package(Qt5Multimedia   REQUIRED)
    find_package(Qt5PrintSupport REQUIRED)
    find_package(Qt5Test         REQUIRED)
else()
    message(STATUS "Building without GUI support")
endif()

# protobuf
# find_package(Protobuf REQUIRED)
find_static_lib(protobuf PROTOBUF)

# tcmalloc
find_static_lib(tcmalloc_minimal TCMALLOC)

# protobuf
