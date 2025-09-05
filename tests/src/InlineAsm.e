#include "libe.e"

func main()
{
    auto string = "string\n";
    asm("
    li a0, 1
    LD a1, 0(sp)
    li a2, 7
    li a7, 64
    ecall
    la a0, 0
    li a7, 93
    ecall");
    return 123;
}
