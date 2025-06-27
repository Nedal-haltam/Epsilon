
#include "libe.e"

#define numbersize 10
#define charsize 15

func bar(auto number, char character, auto numbers[], char chars[], auto WillCall)
{
    print1("Entering function `bar`\n");
    print2("number = %d\n", number);
    print2("character = %d\n", character);
    print2("character = %c\n", character);
    print1("numbers: \n");
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        print2("%d ", numbers[i]);
    }
    print1("\n");
    print1("characters: \n");
    for (auto i = 0; i < charsize; i = i + 1)
    {
        print2("%c ", chars[i]);
    }
    print1("\n");
    print2("characters as a string: `%s`\n", chars);
    print2("WillCall = %d\n", WillCall);
    print1("------------------------------------------------\n");
}

func foo(auto number, char character, auto numbers[], char chars[], auto WillCall)
{
    print1("Entering function `foo`\n");
    print2("number = %d\n", number);
    print2("character = %d\n", character);
    print2("character = %c\n", character);
    print1("numbers: \n");
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        print2("%d ", numbers[i]);
    }
    print1("\n");
    print1("characters: \n");
    for (auto i = 0; i < charsize; i = i + 1)
    {
        print2("%c ", chars[i]);
    }
    print1("\n");
    print2("characters as a string: `%s`\n", chars);
    print2("WillCall = %d\n", WillCall);
    print1("------------------------------------------------\n");
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
            print2("%d", ns[i][j]);
        }
        print1("\n");
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
            print2("%d", cs[i][j]);
        }
        print1("\n");
    }
}

func TwoD(auto ns[][numbersize], char cs[][charsize])
{
    print1("autos are here: \n");
    FillAutoTwoD(ns, 10);
    PrintAutoTwoD(ns);
    print1("------------------------------------------------\n");
    print1("characters are here: \n");
    FillCharTwoD(cs, 0);
    PrintCharTwoD(cs);
    print1("------------------------------------------------\n");
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
        print2("%d ", ns[i]);
    }
    print1("\n");
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
    print1("printing character by character: ");
    print1("`");
    for (auto i = 0; i < n; i = i + 1)
    {
        print2("%c", string[i]);
    }
    print1("`");
    print1("\n");
    print2("the nth index character: `%c` // ... so it is null terminated by default\n", string[n]);
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
    print1("--------------------------------------------------------------\n");

    auto ns2D[numbersize][numbersize];
    char cs2D[charsize][charsize];
    TwoD(ns2D, cs2D);
    print1("--------------------------------------------------------------\n");

    PassArrayWithOffset();
    print1("--------------------------------------------------------------\n");

    // we get from a string literal (i.e. "a string literal") a pointer (address) of that string
    // so we can do the following
    auto AddressOfStringLit = "this is a string literal";
    auto StrinLitLength = strlen(AddressOfStringLit);

    // we can print it directly
    print2("length of stringlit : `%d`\n", StrinLitLength);
    print1("print it directly : ");
    print1("`");
    print1(AddressOfStringLit);
    print1("`");
    print1("\n");
    print2("or print it using format specifier : `%s`\n", AddressOfStringLit);
    StringLitManipulate(AddressOfStringLit, StrinLitLength);
    print1("after manipulation:\n");
    print1("print it directly : ");
    print1("`");
    print1(AddressOfStringLit);
    print1("`");
    print1("\n");
    print2("or print it using format specifier : `%s`\n", AddressOfStringLit);
    print1("--------------------------------------------------------------\n");

    return 0;
}
