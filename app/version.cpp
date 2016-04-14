#include "version.h"
#include "version_details.h"

std::string app_version()
{
    using namespace std::literals::string_literals;

    return "\n version info:"s                      +
           "\n\t  source version: " + VERSION       +
           "\n\t  num commits:    " + NUM_COMMITS   +
           "\n\t  branch:         " + BRANCH        +
           "\n\t  build variant:  " + BUILD_VARIANT +
           "\n\t  build date:     " + BUILD_DATE    +
           "\n\t  ahead by:       " + AHEAD_BY      +
           "\n\t  user:           " + USER          +
           "\n\t  hostname:       " + HOSTNAME;
}

