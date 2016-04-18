file(GLOB src "*.cpp")

register_test(bar_test bar ${src} libbar)
