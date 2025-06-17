
#define SIZE 10


func PrintArray(auto xs[SIZE], auto n)
{
    for (auto i = 0; i < n; i = i + 1)
    {
        printf("xs[%d] = %d\n", i, xs[i]);
    }
}

func InitArray(auto xs[SIZE], auto n)
{
    for (auto i = 0; i < n; i = i + 1)
    {
        xs[i] = i + 1;
    }
}

func MultiplyArray(auto xs[SIZE], auto n, auto value)
{
    for (auto i = 0; i < n; i = i + 1)
    {
        xs[i] = xs[i] * value;
    }
}

func Dot(auto a[SIZE], auto b[SIZE], auto n)
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
    printf("-------------------------------------\n");
    MultiplyArray(xs, n, 7);
    PrintArray(xs, n);
    printf("-------------------------------------\n");
    InitArray(ys, n);
    Dot(xs, ys, n);
    PrintArray(xs, n);
    printf("-------------------------------------\n");
    return 0;
}