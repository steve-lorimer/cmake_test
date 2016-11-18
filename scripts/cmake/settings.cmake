include_guard(__included_settings)

# set(DEBUG_CMAKE "TRUE")
#set(NO_CCACHE "TRUE")

# we set the -rdynamic compiler flag, which exports all our symbols, because we use backtrace
# to log a stack trace when we dump core. This variable suppresses a warning about this behaviour
set(CMAKE_ENABLE_EXPORTS true)
