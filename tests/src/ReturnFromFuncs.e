#include "libe.e"


func Returnchar256()
{
    char x = 256;
    return x;
}
func Returnchar255()
{
    char x = 255;
    return x;
}
func Returnchar128()
{
    char x = 128;
    return x;
}
func Returnchar127()
{
    char x = 127;
    return x;
}

func main()
{
    char x_Returnchar256 = Returnchar256();
    auto x_Returnchar256_auto = Returnchar256();
    print("return 256:\n");
    print("char: %d\n", x_Returnchar256);
    print("auto: %d\n", x_Returnchar256_auto);
    char x_Returnchar255 = Returnchar255();
    auto x_Returnchar255_auto = Returnchar255();
    print("return 255:\n");
    print("char: %d\n", x_Returnchar255);
    print("auto: %d\n", x_Returnchar255_auto);
    char x_Returnchar128 = Returnchar128();
    auto x_Returnchar128_auto = Returnchar128();
    print("return 128:\n");
    print("char: %d\n", x_Returnchar128);
    print("auto: %d\n", x_Returnchar128_auto);
    char x_Returnchar127 = Returnchar127();
    auto x_Returnchar127_auto = Returnchar127();
    print("return 127:\n");
    print("char: %d\n", x_Returnchar127);
    print("auto: %d\n", x_Returnchar127_auto);
}