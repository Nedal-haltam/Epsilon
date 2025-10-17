

func foo(...)
{
    print("calling foo\n");
    auto count = __VARIADIC_COUNT__;
    print("variadics count = %d\n", count);
    for (auto i = 0; i < count; i = i + 1)
    {
        print("varaidic(%d) = %d\n", i, __VARIADIC_ARGS__(i));
    }
    return 0;
}

func bar(auto x, ...)
{
    print("calling bar\n");
    print("x = %d\n", x);
    auto count = __VARIADIC_COUNT__;
    print("variadics count = %d\n", count);
    for (auto i = 0; i < count; i = i + 1)
    {
        print("varaidic(%d) = %d\n", i, __VARIADIC_ARGS__(i));
    }
}

func main()
{
    // maximum is seven
    // a0-7:
    // a0: for number of variadics args
    // a1-a7: for variadics args
    print("----------------------\n");
    foo();
    print("----------------------\n");
    foo(10, 20, 30);
    print("----------------------\n");
    foo(10, 20, 30, 40, 50);
    print("----------------------\n");
    foo(10, 20, 30, 40, 50, 60, 70);
    // not allowed
    // foo(10, 20, 30, 40, 50, 60, 70);


    // maximum is six, one gone for the first parameter `x`
    print("----------------------\n");
    bar(123);
    print("----------------------\n");
    bar(123, 10, 20, 30, 40);
    print("----------------------\n");
    bar(123, 10, 20, 30, 40, 50, 60);
    print("----------------------\n");
    // not allowed
    // bar();
    // bar(123, 10, 20, 30, 40, 50, 60, 70);
}
