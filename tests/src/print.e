
func main()
{
    auto x = 123;
    auto negx = -123;

    print("signed:\n");
    print("x    = %d\n", x);
    print("negx = %d\n", negx);

    print("unsigned:\n");
    print("x    = %zu\n", x);
    print("negx = %zu\n", negx);

    print("print empty:");
    print("`");
    print("");
    print("`\n");

    auto str = "this is an str message with specifiers, 34 + 35 = char(%c), signed(%d), unsigned(%zu)\n";
    char sn = 34 + 35;
    print(str, sn, sn, sn);

    print("auto str = specifier(s) -> %s", str);

    return 0;
}