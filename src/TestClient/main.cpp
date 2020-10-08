/// This program examines features of the C++ library
/// to deduce and print the C++ version.
#include <algorithm>
#include <iomanip>
#include <iostream>
#include <iterator>
#include <ostream>
#include <string>
#include <vector>
/* This is a test to know the used standard */
template<std::size_t N>
struct array
{
    char array[N];
    enum { size = N };
};
template<int I>
struct value_of
{};
template<>
struct value_of<1>
{
    enum { value = true };
};
template<>
struct value_of<2>
{
    enum { value = false };
};
void* erase(...);
struct is_cpp20
{
    static array<1> deduce_type(std::vector<int>::size_type);
    static array<2> deduce_type(...);
    static std::vector<int> v;
    static int i;
    enum { value = value_of<sizeof(deduce_type(erase(v, i)))>::value };
};
struct is_cpp17
{
    static array<1> deduce_type(char*);
    static array<2> deduce_type(const char*);
    static std::string s;
    enum { value = value_of<sizeof(deduce_type(s.data()))>::value };
};
int cbegin(...);
struct is_cpp14
{
    static array<1> deduce_type(std::string::const_iterator);
    static array<2> deduce_type(int);
    enum { value = value_of<sizeof(deduce_type(cbegin(std::string())))>::value };
};
int move(...);
struct is_cpp11
{
    template<class T>
    static array<1> deduce_type(T);
    static array<2> deduce_type(int);
    static std::string s;
    enum { value = value_of<sizeof(deduce_type(move(s)))>::value };
};
enum {
    cpp_year =
    is_cpp20::value ? 2020 :
    is_cpp17::value ? 2017 :
    is_cpp14::value ? 2014 :
    is_cpp11::value ? 2011 :
    2003
};

// Here we get the actual OS with the CMAKE defined preprocessor
std::string say_hello() {
#ifdef IS_WINDOWS
    return std::string("Hello from Windows!");
#elif IS_LINUX
    return std::string("Hello from Linux!");
#elif IS_MACOS
    return std::string("Hello from macOS!");
#else
    return std::string("Hello from an unknown system!");
#endif
}

int main(int argc, char* argv[])
{
    // We test to get the used standard
    std::cout << "Supported C++ standard:" << '\n';
    std::cout << "C++ " << std::setfill('0') << std::setw(2) << cpp_year % 100 << '\n';
    std::cout << "============================================================" << '\n' << '\n';

    std::cout << say_hello() << std::endl;
    return EXIT_SUCCESS;
}