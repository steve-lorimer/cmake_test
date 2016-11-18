#include "version.h"

/*
 * Version information
 *
 * - This is a generated file - do not edit
 */

namespace app { namespace bin {

const char* version()       { return "d060c96-dirty"; }
const char* num_commits()   { return "70"; }
const char* date()          { return __DATE__ " "  __TIME__; }
const char* variant()       { return "debug"; }
const char* branch()        { return "master"; }
const char* ahead_by()      { return "0"; }
const char* num_untracked() { return "0"; }
const char* user()          { return "steve"; }
const char* hostname()      { return "ky-steve"; }

}}
