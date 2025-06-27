


#define SIZE 5
#define glider_size 5
#define iters 25

func SlowDown()
{
    for (auto i = 0; i < 1000; i = i + 1)
    {
        for (auto j = 0; j < 1000; j = j + 1)
        {
            for (auto k = 0; k < 25; k = k + 1)
            {

            }
        }
    }
}

func Copy(auto src[][SIZE], auto dst[][SIZE])
{
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        for (auto j = 0; j < SIZE; j = j + 1)
        {
            dst[i][j] = src[i][j];
        }
    }
}

func main()
{
    auto grid[SIZE][SIZE];
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        for (auto j = 0; j < SIZE; j = j + 1)
        {
            grid[i][j] = 0;
        }
    }
    auto grid2[SIZE][SIZE];
    for (auto i = 0; i < SIZE; i = i + 1)
    {
        for (auto j = 0; j < SIZE; j = j + 1)
        {
            grid2[i][j] = 0;
        }
    }
    grid[1][2] = 1;
    grid[2][3] = 1;
    grid[3][1] = 1;
    grid[3][2] = 1;
    grid[3][3] = 1;

    for (auto iter = 0; iter < iters; iter = iter + 1)
    {
        for (auto i = 0; i < SIZE; i = i + 1)
        {
            for (auto j = 0; j < SIZE; j = j + 1)
            {
                if (grid[i][j])
                {
                    printf("#");
                }
                else
                {
                    printf(".");
                }
            }
            printf("\n");
        }
        SlowDown();
        Copy(grid, grid2);
        for (auto i = 0; i < SIZE; i = i + 1)
        {
            for (auto j = 0; j < SIZE; j = j + 1)
            {
                auto live = 0;
                for (auto dx = i - 1; dx < i + 2; dx = dx + 1)
                {
                    for (auto dy = j - 1; dy < j + 2; dy = dy + 1)
                    {
                        if ((dx != i) | (dy != j))
                        {
                            auto indexx = dx;
                            auto indexy = dy;
                            if (dx == -1)
                                indexx = SIZE - 1;
                            else if (dx == SIZE)
                                indexx = 0;
                            if (dy == -1)
                                indexy = SIZE - 1;
                            else if (dy == SIZE)
                                indexy = 0;
                            
                            if (grid[indexx][indexy])
                                live = live + 1;
                        }
                    }
                }
                if (grid[i][j])
                {
                    if ((live != 2) & (live != 3))
                        grid2[i][j] = 0;
                }
                else
                {
                    if (live == 3)
                        grid2[i][j] = 1;
                }
            }
        }
        Copy(grid2, grid);
    }
}