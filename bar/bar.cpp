#include "bar.h"
#include "bar_msg.pb.h"
#include "foo/foo.h"

std::string bar()
{
    FooT f = foo();

    BarMsg m;
    m.set_s(" bar");
    m.mutable_f()->set_s(foo_msg().s());

    std::string s;
    for (int i : f)
        s += std::to_string(i);

    return s + m.s() + " " + m.f().s();
}

namespace
{
    // protobuf does some stuff at static init time, and then leaks memory if we don't clean up behind it
    // this class forces the library to clean up at static destruction time
    struct ProtobufStaticShutdown
    {
        ~ProtobufStaticShutdown()
        {
            google::protobuf::ShutdownProtobufLibrary();
        }
    } static_protobuf_shutdown;
}
