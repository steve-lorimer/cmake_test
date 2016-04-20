if(__included_string)
    return()
endif()
set(__included_string YES)

function(word_count INPUT_STRING NUM_WORDS)
    
    if (INPUT_STRING STREQUAL "")
        
        # empty string = 0 words
        set (len 0)

    else()

        # convert string into list
        string(REPLACE " "  ";" input_list ${INPUT_STRING})
        string(REPLACE "\n" ";" input_list ${input_list})

        # get length of list
        list  (LENGTH input_list len)

    endif()

    # store result in NUM_WORDS
    set(${NUM_WORDS} ${len} PARENT_SCOPE)

endfunction()
