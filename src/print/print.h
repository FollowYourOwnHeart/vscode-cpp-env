#ifndef PRINT_H
#define PRINT_H

#include <iosfwd>
#include <iostream>
#include <string>

using namespace std;

class Print {
private:
    string tag;

public:
    Print(string&& tag);
    ~Print();
    Print& operator<<(const string& s);
};

#endif // PRINT_H
