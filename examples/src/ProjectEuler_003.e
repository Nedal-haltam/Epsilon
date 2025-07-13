
#include "libe.e"

func main()
{
    auto n = 600851475143;
    auto number = n;
    auto ans;
    while ((n & 1) == 0)
        n = n >> 1;

    for (auto i = 3; i < n + 1; i = i + 1)
    {
        if (n % i == 0)
            ans = i;
        while (n % i == 0)
            n = n / i;
    }

    print("the largest prime factor of the number %d is %d\n", number, ans);
    return 0;
}