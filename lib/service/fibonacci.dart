// O(2^n)
int fibonaci(int num) {
  if (num <= 0) {
    throw Exception("invalid number: $num");
  }
  if (num == 1) return 1;
  if (num == 2) return 1;
  return fibonaci(num - 1) + fibonaci(num - 2);
}

// Programação dinâmica bottom-up
// O(n)
BigInt dynamicFibonacci(int n) {
  if (n <= 0) {
    throw Exception("invalid number: $n");
  }
  if (n == 1 || n == 2) return BigInt.one;

  List<BigInt> list = List.filled(n + 1, BigInt.zero);
  list[1] = BigInt.one;

  for (int i = 2; i <= n; i++) {
    list[i] = list[i - 1] + list[i - 2];
  }

  return list[n];
}

void main() {
  //print(fibonaci(60));
  print(dynamicFibonacci(120));
}
