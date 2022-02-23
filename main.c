#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

typedef NUM_T num_t;

num_t fabsll(num_t x)
{
    return x < 0 ? -x : x;
}

long double test(int n)
{
    num_t sum = 0;
    num_t const one = 1.0;
    for (int i = 1; i < n; ++i)
    {
        sum += (one / (i+1))*(one / i);
    }
    return sum;
}

int main(int argc, char const *argv[])
{
    struct timespec start={0}, end={0};
    clock_gettime(CLOCK_REALTIME, &start);
    long double r = test(20000000);
    clock_gettime(CLOCK_REALTIME, &end);
    time_t ds = end.tv_sec - start.tv_sec;
    time_t dn = end.tv_nsec - start.tv_nsec;
    printf("sizeof(num_t) = %zu\n", sizeof(num_t));
    printf("r=%.20Lf t=%f\n", r, ds + dn * 1e-9);
    return 0;
}