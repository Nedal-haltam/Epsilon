
func foo(auto x, auto px)
{
    print("&px = %d\n", &px);
    print("px  = %d\n", px);
    print("&x   = %d\n", &x);
    print("*px = %d\n", *px);
    print("x   = %d\n", x);
}

func main()
{
    auto x = 123;
    auto px = &x;

    print("in main:\n");
    print("&px = %d\n", &px);
    print("px  = %d\n", px);
    print("&x   = %d\n", &x);
    print("*px = %d\n", *px);
    print("x   = %d\n", x);

    print("passed throug function:\n");
    foo(x, px);

    return 0;
}
