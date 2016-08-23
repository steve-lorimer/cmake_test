include_guard(__included_settings)

#set(DEBUG_CMAKE "TRUE")
#set(NO_CCACHE "TRUE")

if(EXISTS "/etc/redhat-release")

    message(STATUS "Building on CentOs - disabling GUI")

    set(NO_GUI "Y")
endif()
