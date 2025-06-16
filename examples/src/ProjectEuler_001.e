#define limit 1000
func main()
{
    int ans = 0;
    for (int i = 1; i < limit; i = i + 1)
    {
        if (i % 3 == 0 | i % 5 == 0)
        {
            ans = ans + i;
        }
    }
    printf("sum of all the multiples of 3 or 5 below 1000 is: %d\n", ans);
    return 0;
}