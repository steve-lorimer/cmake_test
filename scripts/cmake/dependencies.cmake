include_guard(__included_dependencies)
include(find_lib)

# static libraries
find_static_lib(boost_unit_test_framework LIB_BOOST_UNIT_TEST_FRAMEWORK)
find_static_lib(boost_program_options     LIB_BOOST_PROGRAM_OPTIONS)
find_static_lib(boost_date_time           LIB_BOOST_DATE_TIME)
find_static_lib(boost_filesystem          LIB_BOOST_FILESYSTEM)
find_static_lib(boost_thread              LIB_BOOST_THREAD)
find_static_lib(boost_system              LIB_BOOST_SYSTEM)
find_static_lib(boost_regex               LIB_BOOST_REGEX)
find_static_lib(boost_iostreams           LIB_BOOST_IOSTREAMS)
find_static_lib(protobuf                  LIB_PROTOBUF)
find_static_lib(tcmalloc_minimal          LIB_TCMALLOC)

# shared libraries
find_shared_lib(zmq                       LIB_ZMQ_SO)
