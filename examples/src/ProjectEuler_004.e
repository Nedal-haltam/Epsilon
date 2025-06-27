#include "libe.e"

func IsPalindrome(auto number)
{
    auto temp = number;
    auto reversed = 0;
    while (0 < temp)
    {
        reversed = reversed * 10 + temp % 10;
        temp = temp / 10;
    }
    return number == reversed;
}

func main()
{
    auto a = 100, b = 100;
    auto MaxPalindrome = 0;
    for (auto i = a; i < 1000; i = i + 1)
    {
        for (auto j = b; j < 1000; j = j + 1)
        {
            auto mult = i * j;
            if (IsPalindrome(mult) & MaxPalindrome < mult)
            {
                MaxPalindrome = mult;
            }
        }
    }
    print2("the largest palindrome made from the product of two 3-digit numbers is : %d\n", MaxPalindrome);
    return 0;
}