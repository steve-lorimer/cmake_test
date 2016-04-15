include(boost_test)

file(GLOB src "*.cpp")
add_boost_test(lib1_test ${src} lib1)
