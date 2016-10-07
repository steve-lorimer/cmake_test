#include_guard(__included_color)

if(NOT WIN32)
    string(ASCII 27 Esc)
    set(col_reset    "${Esc}[m")
    set(col_bold     "${Esc}[1m")
    set(red          "${Esc}[31m")
    set(green        "${Esc}[32m")
    set(yellow       "${Esc}[33m")
    set(blue         "${Esc}[34m")
    set(magenta      "${Esc}[35m")
    set(cyan         "${Esc}[36m")
    set(white        "${Esc}[37m")
    set(bold_red     "${Esc}[1;31m")
    set(bold_green   "${Esc}[1;32m")
    set(bold_yellow  "${Esc}[1;33m")
    set(bold_blue    "${Esc}[1;34m")
    set(bold_magenta "${Esc}[1;35m")
    set(bold_cyan    "${Esc}[1;36m")
    set(bold_white   "${Esc}[1;37m")
endif()

function(message)
    # FATAL_ERROR / SEND_ERROR: red
    # WARNING                 : yellow
    # AUTHOR_WARNING          : cyan
    # STATUS                  : green

    set(ALL_ARGS ${ARGV})
    list(GET ARGV 0 MSG_TYPE)
    list(REMOVE_AT ARGV 0)

    if(MSG_TYPE STREQUAL FATAL_ERROR OR MSG_TYPE STREQUAL SEND_ERROR)

        _message(${MSG_TYPE} "${bold_red}${ARGV}${col_reset}")

    elseif(MSG_TYPE STREQUAL WARNING)

        _message(${MSG_TYPE} "${bold_yellow}${ARGV}${col_reset}")

    elseif(MSG_TYPE STREQUAL AUTHOR_WARNING)

        _message(${MSG_TYPE} "${bold_cyan}${ARGV}${col_reset}")

    elseif(MSG_TYPE STREQUAL STATUS)

        _message(${MSG_TYPE} "${bold_blue}${ARGV}${col_reset}")

    else()

        _message("${ALL_ARGS}")

    endif()
endfunction()
