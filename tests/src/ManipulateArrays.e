

#include "libe.e"

#define SIZE 10
func PrintArray(auto xs[], auto n)
{
    for (auto i = 0; i < n; i = i + 1)
    {
        print("xs[%d] = %d\n", i, xs[i]);
    }
}

func InitArray(auto xs[], auto n)
{
    for (auto i = 0; i < n; i = i + 1)
    {
        xs[i] = i + 1;
    }
}

func MultiplyArray(auto xs[], auto n, auto value)
{
    for (auto i = 0; i < n; i = i + 1)
    {
        xs[i] = xs[i] * value;
    }
}

func Dot(auto a[], auto b[], auto n)
{
    for (auto i = 0; i < n; i = i + 1)
    {
        a[i] = a[i] * b[i];
    }
}

func main()
{
    auto n = SIZE;
    auto xs[SIZE], ys[SIZE];
    InitArray(xs, n);
    PrintArray(xs, n);
    print("-------------------------------------\n");
    MultiplyArray(xs, n, 7);
    PrintArray(xs, n);
    print("-------------------------------------\n");
    InitArray(ys, n);
    Dot(xs, ys, n);
    PrintArray(xs, n);
    print("-------------------------------------\n");
    return 0;
}