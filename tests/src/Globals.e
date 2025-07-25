#include "libe.e"

char arr[5][5];
func init()
{
    for (auto i = 0; i < 5; i = i + 1)
    {
        for (auto j = 0; j < 5; j = j + 1)
        {
            arr[i][j] = 2 * (i * 5 + j + 1);
        }
    }
}
func desplay()
{
    for (auto i = 0; i < 5; i = i + 1)
    {
        for (auto j = 0; j < 5; j = j + 1)
        {
            print("%d\n", arr[i][j]);
        }
    }
}
func main()
{
    auto var1 = 123;
    auto var2 = 123;
    init();
    auto var3 = 123;
    auto var4 = 123;
    desplay();
    auto var5 = 123;
    return (var1 - var2 + var3 - var4 + var5 - 123);
}
