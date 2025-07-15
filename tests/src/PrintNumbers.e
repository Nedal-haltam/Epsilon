#include "libe.e"

func main()
{
    print("%d\n", 1 << 63);
    print("%d\n", (1 << 63) - 1);
    print("%d\n", -1);
    print("%zu\n", 1 << 63);
    print("%zu\n", (1 << 63) - 1);
    print("%zu\n", -1);
    print("--------------------------------------------------------------\n");
    return 0;
}
