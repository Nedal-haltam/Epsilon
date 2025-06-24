func main()
{
    auto found = 0;
    auto i = 20;
    while(!found)
    {
        i = i + 1;
        found = 1;
        for (auto j = 1; j < 21; j = j + 1)
        {
            if (i % j != 0)
            {
                found = 0;
                break;
            }
        }
    }
    printf("the smallest positive number that is evenly divisible by all of the numbers from 1 to 20 is : %d\n", i);
    return 0;
}
