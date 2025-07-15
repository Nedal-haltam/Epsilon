
#include "libe.e"

func Print10sMultipleAndLengths()
{
    auto x = 1;
    auto count = 0;
    auto bound = 1000;
    for (auto i = 1; i < bound + 1; i = i + 1)
    {
        auto len = strlen(stoa(x));
        if (count != len)
        {
            print("number = %d\n", x);
            print("new len = %d\n", len);
            count = len;
        }
        x = x + 1;
    }
}

func foo(auto a, auto b)
{
    return a + b;
}

func main()
{
    print("return of foo is : %d\n", foo(123, 456));
    Print10sMultipleAndLengths();
}