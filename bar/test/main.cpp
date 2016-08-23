#define BOOST_TEST_MAIN
#include <boost/test/included/unit_test.hpp>
#include <boost/test/unit_test.hpp>
#include "bar/bar.h"

BOOST_AUTO_TEST_CASE(bar_test)
{
    std::cout << "testing bar\n";

    BOOST_REQUIRE_EQUAL(bar(), "123 bar");
}
