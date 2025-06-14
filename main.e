
#define SIZE 10


func PrintArray(int xs[SIZE], int n)
{
    for (int i = 0; i < n; i = i + 1)
    {
        printf("xs[%d] = %d\n", i, xs[i]);
    }
}

func InitArray(int xs[SIZE], int n)
{
    for (int i = 0; i < n; i = i + 1)
    {
        xs[i] = i + 1;
    }
}

func MultiplyArray(int xs[SIZE], int n, int value)
{
    for (int i = 0; i < n; i = i + 1)
    {
        xs[i] = xs[i] * value;
    }
}

func Dot(int a[SIZE], int b[SIZE], int n)
{
    for (int i = 0; i < n; i = i + 1)
    {
        a[i] = a[i] * b[i];
    }
}

func main()
{
    int n = SIZE;
    int xs[SIZE];
    InitArray(xs, n);
    PrintArray(xs, n);
    printf("-------------------------------------\n");
    MultiplyArray(xs, n, 7);
    PrintArray(xs, n);
    printf("-------------------------------------\n");
    int ys[SIZE];
    InitArray(ys, n);
    Dot(xs, ys, n);
    PrintArray(xs, n);
    printf("-------------------------------------\n");
    printf("-------------------------------------\n");
    printf("-------------------------------------\n");
    printf("-------------------------------------\n");
    printf("-------------------------------------\n");
    printf("-------------------------------------\n");
    printf("-------------------------------------\n");
    return 0;
}