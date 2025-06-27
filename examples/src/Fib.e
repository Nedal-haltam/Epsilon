
#include "libe.e"

#define SIZE 30
func _FibRecursive(auto arr[], auto i)
{
    if (arr[i] != -1)
        return arr[i];
    if (i == 0 | i == 1)
        return i;

    return _FibRecursive(arr, i - 1) + _FibRecursive(arr, i - 2);
}

func FibRecursive()
{
    auto arr[SIZE];
    for (auto i = 0; i < SIZE; i = i + 1)
        arr[i] = -1;
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        arr[i] = _FibRecursive(arr, i);
        print2("%ld ", arr[i]);
    }
    print1("\n");
}

func FibIterative(auto n)
{
    auto a = 0, b = 1;
    auto c;
    for (auto i = 0; i < n; i = i + 1)
    {
        print2("%ld ", a);
        c = a + b;
        a = b;
        b = c;
    }
    print1("\n");
}

func main()
{
    auto n = SIZE;
    FibRecursive();
    FibIterative(n);
    return 0;
}
