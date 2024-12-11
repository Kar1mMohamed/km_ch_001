import 'dart:isolate';
import 'package:test/test.dart';

void main() {
  test('exampleOne should calculate primes', () async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    await Isolate.spawn(findPrimes, sendPort);

    final List<int> primes = await receivePort.first;
    receivePort.close();

    expect(primes, isNotEmpty);
    expect(primes.first, equals(2));
    expect(primes.contains(97), isTrue); // Check if 97 is prime
  });

  test('exampleTwo should send message', () async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    await Isolate.spawn(printMessage, sendPort);

    final String message = await receivePort.first;
    receivePort.close();

    expect(message, equals("💬 مرحبًا من Isolate الجديد!"));
  });
}

// Helper functions used in your code
void findPrimes(SendPort sendPort) {
  List<int> primes = [];
  for (int i = 2; i < 100; i++) {
    // Reduced range for testing purposes
    if (isPrime(i)) {
      primes.add(i);
    }
  }
  sendPort.send(primes);
}

bool isPrime(int number) {
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}

void printMessage(SendPort sendPort) {
  sendPort.send("💬 مرحبًا من Isolate الجديد!");
}
