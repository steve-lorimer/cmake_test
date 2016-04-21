# helper to prevent scripts being included multiple times
macro(include_guard VAR)
    if(${VAR})
        return()
    endif()
    set(${VAR} YES)
endmacro()