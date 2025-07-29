#include "libe.e"

func main()
{
    auto GlobalString = "Global String\n";
    asm("
    li a0, 1
    LD a1, 0(sp)
    li a2, 14
    li a7, 64
    ecall
    la a0, 0
    li a7, 93
    ecall");
    return 123;
}
