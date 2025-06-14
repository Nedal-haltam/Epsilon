func Print10sMultipleAndLengths()
{
    int x = 1;
    int count = 0;
    int bound = 1000;
    for (int i = 1; i < bound + 1; i = i + 1)
    {
        int len = strlen(itoa(x));
        if (count != len)
        {
            printf("number = %d\n", x);
            printf("new len = %d\n", len);
            count = len;
        }
        x = x + 1;
    }
}

func foo(int a, int b)
{
    return a + b;
}

func main()
{
    printf("return of foo is : %d\n", foo(123, 456));
    Print10sMultipleAndLengths();
}