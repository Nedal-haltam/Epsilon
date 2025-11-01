


func main(auto argc, auto argv)
{
    print("cl args count = %d\n", argc);
    print("Printing cl args:\n");
    for (auto i = 0; i < argc; i += 1)
    {
        print("%d- %s\n", i + 1, *(argv + i * 8));
    }
}
