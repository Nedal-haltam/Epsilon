func main()
{
    int bound = 4000000;
    int sum = 0;
    int a = 0;
    int b = 1;
    int c;
    while(1)
    {
        c = a + b;
        if (bound < c)
            break;
        if ((c & 1) == 0)
            sum = sum + c;
        a = b;
        b = c;
    }
    printf("the sum of the even-valued terms is: %d\n", sum);
    return 0;
}