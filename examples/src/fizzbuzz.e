func main()
{
    auto i;
    i = 1;
    while (i < 100 | i == 100)
    {
        if (i % 3 == 0 | i % 5 == 0)
        {
            if (i % 3 == 0) print("Fizz");
            if (i % 5 == 0) print("Buzz");
        } else
        {
            print("%d", i);
        }
        print("\n");
        i = i + 1;
    }
}