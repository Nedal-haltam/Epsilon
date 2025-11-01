
func main(auto argc, auto argv)
{
    if (argc < 2)
    {
        print("\033[31mno arguement was provided to print the sequence\033[0m\n");
        exit(1);
    }

    auto seq = atouns(*(argv + 8));
    print("printing until %d\n", seq);
    for (auto i = 0; i < seq; i += 1)
        print("%d ", i + 1);
    print("\n");

    return 0;
}
