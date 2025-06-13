
#define SIZE 100

func display(int base[SIZE], int n) {
    int i  = 0;
    while (i < n) {
        if (base[i]) printf("#"); 
        else printf(".");
        i = i + 1;
    }
    printf("\n");
}

func next(int base[SIZE], int n) {
    int state = base[0] | base[1] << 1;
    int i  = 2;
    while (i < n) {
        state = state << 1;
        state = state | base[i];
        state = state & 7;
        base[i - 1] = (110 >> state) & 1;
        i = i + 1;
    }
}
func main() {
    int n = SIZE;
    int base[SIZE];
    for (int i = 0; i < n; i = i + 1)
        base[i] = 0;
    base[n - 2] = 1;

    display(base, n);
    int i = 0;
    while (i < n - 3) {
        next(base, n);
        display(base, n);
        i = i + 1;
    }
}

/*
#define n 100
func main() {
    int base[n];
    for (int i = 0; i < n; i = i + 1)
        base[i] = 0;
    base[n - 2] = 1;

    int j  = 0;
    while (j < n) {
        if (base[j]) printf("#"); 
        else printf(".");
        j = j + 1;
    }
    printf("\n");
    int i = 0;
    while (i < n - 3) {
        int k = 2;
        int state;
        state = base[0] | base[1] << 1;
        while (k < n) {
            state = state << 1;
            state = state | base[k];
            state = state & 7;
            base[k - 1] = (110 >> state) & 1;
            k = k + 1;
        }


        j  = 0;
        while (j < n) {
            if (base[j]) printf("#"); 
            else printf(".");
            j = j + 1;
        }
        printf("\n");


        i = i + 1;
    }
}
*/