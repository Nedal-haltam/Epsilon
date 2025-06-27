
#include "libe.e"

#define numbersize 10
#define charsize 15

func bar(auto number, char character, auto numbers[], char chars[], auto WillCall)
{
    print("Entering function `bar`\n");
    print("number = %d\n", number);
    print("character = %d\n", character);
    print("character = %c\n", character);
    print("numbers: \n");
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        print("%d ", numbers[i]);
    }
    print("\n");
    print("characters: \n");
    for (auto i = 0; i < charsize; i = i + 1)
    {
        print("%c ", chars[i]);
    }
    print("\n");
    print("characters as a string: `%s`\n", chars);
    print("WillCall = %d\n", WillCall);
    print("------------------------------------------------\n");
}

func foo(auto number, char character, auto numbers[], char chars[], auto WillCall)
{
    print("Entering function `foo`\n");
    print("number = %d\n", number);
    print("character = %d\n", character);
    print("character = %c\n", character);
    print("numbers: \n");
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        print("%d ", numbers[i]);
    }
    print("\n");
    print("characters: \n");
    for (auto i = 0; i < charsize; i = i + 1)
    {
        print("%c ", chars[i]);
    }
    print("\n");
    print("characters as a string: `%s`\n", chars);
    print("WillCall = %d\n", WillCall);
    print("------------------------------------------------\n");
    if (WillCall)
    {
        foo(number, character, numbers, chars, 0);
    }
    else
    {
        bar(number, character, numbers, chars, 0);
    }
}

func FillAutoTwoD(auto ns[][numbersize], auto n)
{
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        for (auto j = 0; j < numbersize; j = j + 1)
        {
            ns[i][j] = numbersize * i + j;
        }
    }
}

func PrintAutoTwoD(auto ns[][numbersize])
{
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        for (auto j = 0; j < numbersize; j = j + 1)
        {
            print("%d", ns[i][j]);
        }
        print("\n");
    }
}
func FillCharTwoD(char cs[][charsize], char n)
{
    for (auto i = 0; i < charsize; i = i + 1)
    {
        for (auto j = 0; j < charsize; j = j + 1)
        {
            cs[i][j] = n + i + j;
        }
    }
}

func PrintCharTwoD(char cs[][charsize])
{
    for (auto i = 0; i < charsize; i = i + 1)
    {
        for (auto j = 0; j < charsize; j = j + 1)
        {
            print("%d", cs[i][j]);
        }
        print("\n");
    }
}

func TwoD(auto ns[][numbersize], char cs[][charsize])
{
    print("autos are here: \n");
    FillAutoTwoD(ns, 10);
    PrintAutoTwoD(ns);
    print("------------------------------------------------\n");
    print("characters are here: \n");
    FillCharTwoD(cs, 0);
    PrintCharTwoD(cs);
    print("------------------------------------------------\n");
}

func pass_array_with_offset(auto arr[4])
{
    auto count = 1;
    for (auto i = -1; i < 3; i = i + 1)
    {
        arr[i] = count;
        count = count + 1;
    }
}

func PassArrayWithOffset()
{
    auto ns[4];
    pass_array_with_offset(ns + 8); // the offset should account for the `byte` addressable memory
    for (auto i = 0; i < 4; i = i + 1)
    {
        print("%d ", ns[i]);
    }
    print("\n");
    return 0;
}


func StringLitManipulate(char string[], auto n)
{
    string[0] = 'H';
    string[1] = 'e';
    string[2] = 'l';
    string[3] = 'l';
    string[4] = 'o';
    string[5] = ' ';
    for (auto i = 6; i < n; i = i + 1)
    {
        string[i] = 'a' + i - 6;
    }
    print("printing character by character: ");
    print("`");
    for (auto i = 0; i < n; i = i + 1)
    {
        print("%c", string[i]);
    }
    print("`");
    print("\n");
    print("the nth index character: `%c` // ... so it is null terminated by default\n", string[n]);
}

func main()
{
    auto n = 420;
    char c = 'a';
    auto ns1D[numbersize];
    char cs1D[charsize];
    for (char i = 'a'; i < 'a' + charsize - 1; i = i + 1)
    {
        cs1D[i - c] = i;
    }
    cs1D[charsize - 1] = 0;
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        ns1D[i] = (n / numbersize + i * 2) << 1 | 1;
    }
    foo(n, c, ns1D, cs1D, 1);
    bar(n, c, ns1D, cs1D, 0);
    print("--------------------------------------------------------------\n");

    auto ns2D[numbersize][numbersize];
    char cs2D[charsize][charsize];
    TwoD(ns2D, cs2D);
    print("--------------------------------------------------------------\n");

    PassArrayWithOffset();
    print("--------------------------------------------------------------\n");

    // we get from a string literal (i.e. "a string literal") a pointer (address) of that string
    // so we can do the following
    auto AddressOfStringLit = "this is a string literal";
    auto StrinLitLength = strlen(AddressOfStringLit);

    // we can print it directly
    print("length of stringlit : `%d`\n", StrinLitLength);
    print("print it directly : ");
    print("`");
    print(AddressOfStringLit);
    print("`");
    print("\n");
    print("or print it using format specifier : `%s`\n", AddressOfStringLit);
    StringLitManipulate(AddressOfStringLit, StrinLitLength);
    print("after manipulation:\n");
    print("print it directly : ");
    print("`");
    print(AddressOfStringLit);
    print("`");
    print("\n");
    print("or print it using format specifier : `%s`\n", AddressOfStringLit);
    print("--------------------------------------------------------------\n");

    return 0;
}
