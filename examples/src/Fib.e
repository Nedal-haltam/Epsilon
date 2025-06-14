

#define SIZE 30
func _FibRecursive(int arr[SIZE], int i)
{
    if (arr[i] != -1)
        return arr[i];
    if (i == 0 | i == 1)
        return i;

    return _FibRecursive(arr, i - 1) + _FibRecursive(arr, i - 2);
}

func FibRecursive()
{
    int arr[SIZE];
    for (int i = 0; i < SIZE; i = i + 1)
        arr[i] = -1;
    for (int i = 0; i < SIZE; i = i + 1)
    {
        arr[i] = _FibRecursive(arr, i);
        printf("%ld ", arr[i]);
    }
    printf("\n");
}

func FibIterative(int n)
{
    int a = 0, b = 1;
    int c;
    for (int i = 0; i < n; i = i + 1)
    {
        printf("%ld ", a);
        c = a + b;
        a = b;
        b = c;
    }
    printf("\n");
}

func main()
{
    int n = SIZE;
    FibRecursive();
    FibIterative(n);
    return 0;
}
