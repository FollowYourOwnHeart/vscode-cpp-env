#include "print.h"
#include <iosfwd>
#include <iostream>

using namespace std;

Print::Print(string&& tag)
{
    this->tag = tag;
}

Print& Print::operator<<(const string& s)
{
    if (s == "\n") {
        cout << endl;
        return *this;
    }
    cout << tag << " : " << s;
    return *this;
}

Print::~Print()
{
    cout << "destruction" << endl;
}