#include "libe.e"

func main()
{
    auto start = 10;
    auto end = 23;
    for i in (start - 1)..(end + 1) {
        print("i = %d\n", i);
    }
    print("--------------------------------\n");
    for (auto i = (start - 1); i < (end + 1); i = i + 1) {
        print("i = %d\n", i);
    }
    return 0;
}