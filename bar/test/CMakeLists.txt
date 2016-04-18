file(GLOB src "*.cpp")

add_boost_test(bar_test ${src} bar)
