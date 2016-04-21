include_guard(__included_dependencies)

include(find_lib)

set(Boost_USE_STATIC_LIBS ON)

#find_package(Boost REQUIRED)
#find_package(Boost COMPONENTS program_options REQUIRED)

find_package(Protobuf REQUIRED)

find_static_lib(tcmalloc_minimal TCMALLOC)

