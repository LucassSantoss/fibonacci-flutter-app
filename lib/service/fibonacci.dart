int fibonaci(int num) {
  if (num <= 0) {
    throw Exception("invalid number: $num");
  }
  if (num == 1) return 1;
  if (num == 2) return 1;
  return fibonaci(num - 1) + fibonaci(num - 2);
}
