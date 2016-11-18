include_guard(__included_utils)

function(add_unique ITEM LIST)
    list(FIND ${LIST} ${ITEM} exists)
    if(${exists} EQUAL -1)
        list(APPEND ${LIST} ${ITEM})
    endif()
    set(${LIST} ${${LIST}} PARENT_SCOPE)
endfunction()
