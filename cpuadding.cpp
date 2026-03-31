#include <iostream>
using namespace std;

int main() {
  int a[] = {1, 2, 3, 4, 5};
  int b[] = {6, 7, 8, 9, 10};
  int c[5];

  cout << "{";
  for (int i = 0; i < 5; i++) {
    c[i] = a[i] + b[i];
    cout << c[i] << " ";
  }
  cout << "}";
}
