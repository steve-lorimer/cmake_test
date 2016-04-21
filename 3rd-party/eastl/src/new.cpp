#include <stdio.h>
#include <stdlib.h>

// required by eastl (see 3rd-party/eastl/README)

void* operator new[](size_t size, const char* /*name*/, int /*flags*/, unsigned /*debug_flags*/, const char* /*file*/, int /*line*/)
{
    return new char[size];
}

void* operator new[](size_t size, size_t /*alignment*/, size_t /*alignment_offset*/, const char* /*name*/, int /*flags*/, unsigned /*debug_flags*/, const char* /*file*/, int /*line*/)
{
    return new char[size];
}
