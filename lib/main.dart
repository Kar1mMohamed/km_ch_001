import 'dart:isolate';

import 'package:km_ch_001/utils.dart';

void main() async {
  exampleOne();
  exampleTwo();
}

void exampleOne() async {
  // إنشاء قناة للتواصل بين Isolate الرئيسي والجديد
  // Create a channel to communicate between the main Isolate and the new one
  ReceivePort receivePort = ReceivePort();

  // إنشاء Isolate جديد
  // Create a new Isolate
  await Isolate.spawn(findPrimes, receivePort.sendPort);

  // الاستماع إلى النتائج
  // Listen to the results
  receivePort.listen((message) {
    print("🧮 عدد الأرقام الأولية: ${message.length}");
    receivePort.close();
  });
}

void exampleTwo() async {
  ReceivePort receivePort = ReceivePort();

  // تشغيل Isolate جديد
  // Run a new Isolate
  await Isolate.spawn(printMessage, receivePort.sendPort);

  // استقبال الرسائل
  // Receive messages
  receivePort.listen((message) {
    print(message);
    receivePort.close();
  });
}
