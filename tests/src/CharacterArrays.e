#define SIZE 27
func foo(char chars[SIZE])
{
    for (char i = 'a'; i < 'z' + 1; i = i + 1)
    {
        chars[i - 'a'] = i;
    }
    chars[SIZE - 1] = 0;
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        printf("%c ", chars[i]);
    }
    printf("\n");
    printf("chars: `%s`\n", chars);
}

func CharArrayTest()
{
    char arr[SIZE];
    foo(arr);
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        printf("%c ", arr[i]);
    }
    printf("\n");
    printf("arr: `%s`\n", arr);
}

// interesting
func PointerTest()
{
    auto x = "`hello world`";
    printf("%s\n", x);
    printf(x);
    printf("\n");
}

func main()
{
    printf("-----------------------------\n");
    printf("CharArrayTest:\n");
    CharArrayTest();

    printf("-----------------------------\n");
    printf("PointerTest:\n");
    PointerTest();

    return 0;
}