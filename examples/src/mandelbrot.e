
auto W;
auto H;
auto IT;
auto f;

func m(auto cr, auto ci)
{
    auto a, b, i, tmp;
    cr = cr - (3 * W / 4);
    ci = ci - (H / 2);

    cr = (cr * f * 3) / W;
    ci = (ci * f * 3) / H;

    a = 0;
    b = 0;

    i = 0;
    while (i < IT)
    {
        if ((2*2*f) < (a*a/f + b*b/f))
        {
            return (9 - (i*10 / IT));
        }

        tmp = (a*a - b*b)/f + cr;
        b = (a*b)/f*2 + ci;
        a = tmp;

        i = i + 1;
    }

    return (0);
}

// reference to the code: https://github.com/bext-lang/b/blob/main/examples/mandelbrot.b
// it was modified to suite our e-code syntax
func main()
{
    auto gradient = "@%#*+=-:. ";
    W = 80;
    H = 40;
    IT = 100;
    f = 1000;
    auto i, j;
    j = 0;
    while (j < H)
    {
        i = 0;
        while (i < W)
        {
            auto x = m(i,j);
            write(1, gradient + x, 1);
            i = i + 1;
        }
        print("\n");
        j = j + 1;
    }
}
