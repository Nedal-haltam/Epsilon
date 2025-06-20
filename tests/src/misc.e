
#define numbersize 10
#define charsize 15

func bar(auto number, char character, auto numbers[numbersize], char chars[charsize], auto WillCall)
{
    printf("Entering function `bar`\n");
    printf("number = %d\n", number);
    printf("character = %d\n", character);
    printf("character = %c\n", character);
    printf("numbers: \n");
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        printf("%d ", numbers[i]);
    }
    printf("\n");
    printf("characters: \n");
    for (auto i = 0; i < charsize; i = i + 1)
    {
        printf("%c ", chars[i]);
    }
    printf("\n");
    printf("characters as a string: `%s`\n", chars);
    printf("WillCall = %d\n", WillCall);
    printf("------------------------------------------------\n");
}

func foo(auto number, char character, auto numbers[numbersize], char chars[charsize], auto WillCall)
{
    printf("Entering function `foo`\n");
    printf("number = %d\n", number);
    printf("character = %d\n", character);
    printf("character = %c\n", character);
    printf("numbers: \n");
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        printf("%d ", numbers[i]);
    }
    printf("\n");
    printf("characters: \n");
    for (auto i = 0; i < charsize; i = i + 1)
    {
        printf("%c ", chars[i]);
    }
    printf("\n");
    printf("characters as a string: `%s`\n", chars);
    printf("WillCall = %d\n", WillCall);
    printf("------------------------------------------------\n");
    if (WillCall)
    {
        foo(number, character, numbers, chars, 0);
    }
    else
    {
        bar(number, character, numbers, chars, 0);
    }
}

func FillAutoTwoD(auto ns[numbersize][numbersize], auto n)
{
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        for (auto j = 0; j < numbersize; j = j + 1)
        {
            ns[i][j] = numbersize * i + j;
        }
    }
}

func PrintAutoTwoD(auto ns[numbersize][numbersize])
{
    for (auto i = 0; i < numbersize; i = i + 1)
    {
        for (auto j = 0; j < numbersize; j = j + 1)
        {
            printf("%-3d", ns[i][j]);
        }
        printf("\n");
    }
}
func FillCharTwoD(char cs[charsize][charsize], char n)
{
    for (auto i = 0; i < charsize; i = i + 1)
    {
        for (auto j = 0; j < charsize; j = j + 1)
        {
            cs[i][j] = n + i + j;
        }
    }
}

func PrintCharTwoD(char cs[charsize][charsize])
{
    for (auto i = 0; i < charsize; i = i + 1)
    {
        for (auto j = 0; j < charsize; j = j + 1)
        {
            printf("%-3d", cs[i][j]);
        }
        printf("\n");
    }
}

func TwoD(auto ns[numbersize][numbersize], char cs[charsize][charsize])
{
    printf("autos are here: \n");
    PrintAutoTwoD(ns);
    printf("------------------------------------------------\n");
    FillAutoTwoD(ns, 10);
    PrintAutoTwoD(ns);
    printf("------------------------------------------------\n");
    printf("characters are here: \n");
    PrintCharTwoD(cs);
    printf("------------------------------------------------\n");
    FillCharTwoD(cs, 0);
    PrintCharTwoD(cs);
    printf("------------------------------------------------\n");
}

#define size 10
func test()
{
    auto a[size];
    auto b[size];
    conv(a, b);

    // assembly:
    // la t0, a
    // la t1, b
    // li t2, size
    // conv t0, t1, t2
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
        printf("%d ", ns[i]);
    }
    printf("\n");
    return 0;
}

// the zero in the size of the `string` character array variable is just a dummy value
func StringLitManipulate(char string[0], auto n)
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
    printf("printing character by character: ");
    printf("`");
    for (auto i = 0; i < n; i = i + 1)
    {
        printf("%c", string[i]);
    }
    printf("`");
    printf("\n");
    printf("the nth index character: `%c` // ... so it is null terminated by default\n", string[n]);
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
    printf("--------------------------------------------------------------\n");

    auto ns2D[numbersize][numbersize];
    char cs2D[charsize][charsize];
    TwoD(ns2D, cs2D);
    printf("--------------------------------------------------------------\n");

    PassArrayWithOffset();
    printf("--------------------------------------------------------------\n");

    // we get from a string literal (i.e. "a string literal") a pointer (address) of that string
    // so we can do the following
    auto AddressOfStringLit = "this is a string literal";
    auto StrinLitLength = strlen(AddressOfStringLit);

    // we can print it directly
    printf("length of stringlit : `%d`\n", StrinLitLength);
    printf("print it directly : ");
    printf("`");
    printf(AddressOfStringLit);
    printf("`");
    printf("\n");
    printf("or print it using format specifier : `%s`\n", AddressOfStringLit);
    StringLitManipulate(AddressOfStringLit, StrinLitLength);
    printf("after manipulation:\n");
    printf("print it directly : ");
    printf("`");
    printf(AddressOfStringLit);
    printf("`");
    printf("\n");
    printf("or print it using format specifier : `%s`\n", AddressOfStringLit);
    printf("--------------------------------------------------------------\n");

    return 0;
}
