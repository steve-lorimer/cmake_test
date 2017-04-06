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
find_shared_lib(pcap                      LIB_PCAP)
find_shared_lib(zmq                       LIB_ZMQ)

# third_party libs built in tree
use_in_tree_lib(cpp-netlib                LIB_CPPNET)
use_in_tree_lib(eastl                     LIB_EASTL)
use_in_tree_lib(libev                     LIB_EV)
use_in_tree_lib(gmock                     LIB_GMOCK)
use_in_tree_lib(gtest                     LIB_GTEST)
use_in_tree_lib(libtins                   LIB_TINS)
use_in_tree_lib(zlib                      LIB_Z)

# optional libraries
find_shared_lib(pq                        LIB_PQ OPTIONAL)
find_shared_lib(pqxx                      LIB_PQXX OPTIONAL)
find_gcc_lib   (quadmath                  LIB_QUADMATH)

