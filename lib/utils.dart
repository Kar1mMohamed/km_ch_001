import 'dart:isolate';

bool isPrime(int number) {
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}

// الدالة التي سيتم تشغيلها داخل الـ Isolate
// The function that will run inside the Isolate
void findPrimes(SendPort sendPort) {
  List<int> primes = [];
  for (int i = 2; i < 100000; i++) {
    if (isPrime(i)) {
      primes.add(i);
    }
  }
  // إرسال النتائج إلى Isolate الرئيسي
  // Send the results to the main Isolate
  sendPort.send(primes);
}

void printMessage(SendPort sendPort) {
  sendPort.send("💬 مرحبًا من Isolate الجديد!");
}

Future<int> heavyTask(int number) async {
  // مثال على عملية بسيطة
  // An example of a simple operation
  return number * 2;
}
