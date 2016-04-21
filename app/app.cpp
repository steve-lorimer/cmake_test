#include "app.h"
#include <boost/program_options.hpp>
#include "version.h"
#include "foo/foo.h"
#include "bar/bar.h"
#include <iostream>

int App::run(int argc, char** argv)
{
    namespace po = boost::program_options;

    po::options_description desc("allowed options");
    desc.add_options()
        ("help,h"    , "show this help message")
        ("version,v" , "print version information - then quits");

    po::variables_map vm;
    po::store(po::command_line_parser(argc, argv).options(desc).allow_unregistered().run(), vm);
    po::notify(vm);

    if (vm.count("help"))
    {
        std::cout << desc << std::endl;
        exit(0);
    }

    if (vm.count("version"))
    {
        std::cout << app_version() << std::endl;
        exit(0);
    }

    std::cout << app_version() << '\n'
              << '\n'
              << "foo.size: " << foo().size() << '\n'
              << "bar: "      << bar() << '\n';
    return 0;
}
