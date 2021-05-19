import 'dart:math';

class Cryptography {
  int encryptChar({required int char, required int e, required int n}) {
    var value = 1;
    while (e > 0) {
      value *= char;
      value %= n;
      e--;
    }
    return value;
  }

  bool isPrime({required int n, int divisor = 2}) {
    if (n == 0) return false;
    if (divisor > sqrt(n)) return true;
    if (n % divisor == 0) return false;

    return isPrime(n: n, divisor: divisor + 1);
  }

  int generateD({required int p, required int q, required int e}) {
    var totiente = (p - 1) * (q - 1);
    for (var index = 1; index < totiente; index++) {
      if ((e * index) % totiente == 1) {
        return index;
      }
    }
    return 0;
  }

  bool validationPQ({required p, required q}) {
    if (isPrime(n: p) && isPrime(n: q))
      return true;
    else
      return false;
  }

  bool validationEN({required e, required n}) {
    if (isPrime(n: e) && isPrime(n: n))
      return true;
    else
      return false;
  }
}
