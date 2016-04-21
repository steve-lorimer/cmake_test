#pragma once

//#include <vector>
//using FooT = std::vector<int>;

#include <EASTL/fixed_vector.h>
using FooT = eastl::fixed_vector<int, 5>;


FooT foo();
