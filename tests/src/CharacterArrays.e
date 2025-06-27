
#include "libe.e"

#define SIZE 27
func foo(char chars[])
{
    for (char i = 'a'; i < 'z' + 1; i = i + 1)
    {
        chars[i - 'a'] = i;
    }
    chars[SIZE - 1] = 0;
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        print2("%c ", chars[i]);
    }
    print1("\n");
    print2("chars: `%s`\n", chars);
}

func CharArrayTest()
{
    char arr[SIZE];
    foo(arr);
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        print2("%c ", arr[i]);
    }
    print1("\n");
    print2("arr: `%s`\n", arr);
}

// interesting
func PointerTest()
{
    auto x = "`hello world`";
    print2("%s\n", x);
    print1(x);
    print1("\n");
}

func main()
{
    print1("-----------------------------\n");
    print1("CharArrayTest:\n");
    CharArrayTest();

    print1("-----------------------------\n");
    print1("PointerTest:\n");
    PointerTest();

    return 0;
}