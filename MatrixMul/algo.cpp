#include <iostream>
#include <stdio.h>
using namespace std;
int main(){
    int a[3][3] = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}};
    int b[3][2] = {{0, 1}, {2, 3}, {4, 5}};
    int c[3][2];
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 2; j++){
            c[i][j] = 0;
        }
    }
    int m = 3, n = 2, l = 3;
    // 3x3 x 3x2  = 3x2
    // m = rowA, n = colb, k = rolB
    for (int i = 0; i < m; i++)
    {
        for(int j = 0; j < n; j++){
            for(int k = 0; k < l; k++){
                printf("c[%d][%d] += a[%d][%d] * b[%d][%d] \n", i, j, i, k, k, j);
                printf("c(%d * %d + %d) += a(%d * %d + %d) * b(%d * %d + %d) \n", i, n, j, i, m, k, k, n, j);
                c[i][j] += a[i][k] * b[k][j];
                printf("c = %d\n", c[i][j]);
            }
            cout << "---------" <<endl;
        }
    }
    return 0;
}