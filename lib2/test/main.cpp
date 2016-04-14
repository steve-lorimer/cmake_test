#define BOOST_TEST_MAIN
#include <boost/test/included/unit_test.hpp>
#include <boost/test/unit_test.hpp>
#include "lib2/lib2.h"

BOOST_AUTO_TEST_CASE(lib2_test)
{
    BOOST_REQUIRE_EQUAL(lib2(), "lib1 lib2");
}
