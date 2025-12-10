
#include "libe.e"

func main()
{
    auto bound = 4000000;
    auto sum = 0;
    auto a = 0;
    auto b = 1;
    auto c;
    auto run = 1;
    while(run)
    {
        c = a + b;
        if (bound < c)
            run = 0;
        if (run)
        {
            if ((c & 1) == 0)
                sum = sum + c;
            a = b;
            b = c;
        }
    }
    print("the sum of the even-valued terms is: %d\n", sum);
    return 0;
}