
auto A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
func sx64(auto x)
{ return x * 6434 >> 13; }

#define SCALE (2)
#define SIZE (SCALE * SCALE * 2000)

char b[SIZE], z[SIZE];
func main()
{
    char chars[12];
    chars[0]  = '.';
    chars[1]  = ',';
    chars[2]  = '-';
    chars[3]  = '~';
    chars[4]  = ':';
    chars[5]  = ';';
    chars[6]  = '=';
    chars[7]  = '!';
    chars[8]  = '*';
    chars[9]  = '#';
    chars[10] = '$';
    chars[11] = '@';

    A = 1024;
    C = 1024;
    B = 0;
    D = 0;
    auto iters = 1;
    while (iters)
    {
        iters = iters - 1;
        E = 0;
        while (E < SCALE * SCALE * 2000)
        {
            b[E] = 32;
            z[E] = 127;
            E = E + 1;
        }
        E = 0;
        G = 0;
        F = 1024;
        while (G < SCALE * 90)
        {
            G = G + 1;
            H = 0;
            I = 0;
            J = 1024;
            while (I < SCALE * 324)
            {
                I = I + 1;
                M = F + 2048;
                Z = J * M >> 10;
                P = B * E >> 10;
                Q = H * M >> 10;
                R = P - (A * Q >> 10);
                S = A * E >> 10;
                T = 5242880 + 1024 * S + sx64(B * Q);
                U = F * H >> 10;
                X = SCALE * 40 + SCALE * 30 * (sx64(D * Z) - sx64(C * R)) / T;
                Y = SCALE * 12 + SCALE * 15 * (sx64(D * R) + sx64(C * Z)) / T;
                N = sx64((-B * U - D * ((-sx64(A * U) >> 10) + P) - J * (F * C >> 10) >> 10) - S >> 7);
                O = X + SCALE * 80 * Y;
                V = sx64((T - 5242880) >> 15);
                if (Y < (SCALE * 22) & 0 < Y & 0 < X & X < (SCALE * 80))
                {
                    if (V < z[O])
                    {
                        z[O] = V;
                        auto index = 0;
                        if (0 < N) index = N;
                        b[O] = chars[index];
                    }
                }
                L = J;
                J = J - (5 * H >> 8);
                H = H + (5 * L >> 8);
                L = (3145728 - J * J - H * H) >> 11;
                J = sx64(J * L >> 10);
                H = sx64(H * L >> 10);
            }
            L = F;
            F = F - (9 * E >> 7);
            E = E + (9 * L >> 7);
            L = (3145728 - F * F - E * E) >> 11;
            F = sx64(F * L >> 10);
            E = sx64(E * L >> 10);
        }
        K = 0;
        while (K < (SCALE * 80 * SCALE * 22))
        {
            char c = 10;
            if ((K % (SCALE * 80)) != 0) c = b[K];
            print("%c", c);
            K = K + 1;
        }
        L = B;
        B = B - (5 * A >> 7);
        A = A + (5 * L >> 7);
        L = (3145728 - B * B - A * A) >> 11;
        B = sx64(B * L >> 10);
        A = sx64(A * L >> 10);
        L = D;
        D = D - (5 * C >> 8);
        C = C + (5 * L >> 8);
        L = (3145728 - D * D - C * C) >> 11;
        D = sx64(D * L >> 10);
        C = sx64(C * L >> 10);
        if (iters) print("%c[%dA", 27, SCALE * 22);
    }
    return 0;
}
