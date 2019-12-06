#include "print.h"
#include <string>

using namespace std;

int main(int argc, char* argv[])
{
	printf("build ver: %d.%d\n", VER_MAJOR, VER_MINOR);
    Print p(string("cout"));

    p << "hello world"
      << "\n";

    return 0;
}
