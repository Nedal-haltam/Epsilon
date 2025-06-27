#include "libe.e"

#define SIZE 100

func display(auto base[], auto n) {
    auto i  = 0;
    while (i < n) {
        if (base[i]) print("#"); 
        else print(".");
        i = i + 1;
    }
    print("\n");
}

func next(auto base[], auto n) {
    auto state = base[0] | base[1] << 1;
    auto i  = 2;
    while (i < n) {
        state = state << 1;
        state = state | base[i];
        state = state & 7;
        base[i - 1] = (110 >> state) & 1;
        i = i + 1;
    }
}
func main() {
    auto n = SIZE;
    auto base[SIZE];
    for (auto i = 0; i < n; i = i + 1)
        base[i] = 0;
    base[n - 2] = 1;

    display(base, n);
    auto i = 0;
    while (i < n - 3) {
        next(base, n);
        display(base, n);
        i = i + 1;
    }
}