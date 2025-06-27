
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
        print("%c ", chars[i]);
    }
    print("\n");
    print("chars: `%s`\n", chars);
}

func CharArrayTest()
{
    char arr[SIZE];
    foo(arr);
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        print("%c ", arr[i]);
    }
    print("\n");
    print("arr: `%s`\n", arr);
}

// interesting
func PointerTest()
{
    auto x = "`hello world`";
    print("%s\n", x);
    print(x);
    print("\n");
}

func main()
{
    print("-----------------------------\n");
    print("CharArrayTest:\n");
    CharArrayTest();

    print("-----------------------------\n");
    print("PointerTest:\n");
    PointerTest();

    return 0;
}