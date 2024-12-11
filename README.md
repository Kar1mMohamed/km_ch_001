# 🌀 Isolates in Dart

<div dir="rtl">

في Dart، تُعتبر **🔀Isolates** وسيلة فعّالة لإدارة العمليات المتوازية (🔄parallel tasks) دون الحاجة إلى مشاركة الذاكرة بشكل مباشر 🧠. كل Isolate يعمل ككيان مستقل بموارده الخاصة.

**🤔 لماذا نستخدم 🔀Isolates؟**

- في بيئة Dart، يتم تنفيذ الكود عادةً داخل Isolate رئيسي (🏠Main Isolate).
- عند تنفيذ عمليات ثقيلة مثل قراءة ملفات ضخمة 📂 أو إجراء حسابات معقدة 🧮، يمكن أن يتسبب ذلك في بطء التطبيق إذا تم تنفيذها داخل الـ 🏠Main Isolate.
- هنا تظهر أهمية استخدام Isolates لتوزيع العمل وجعل التطبيق أكثر سلاسة واستجابة 🚀.

---

### 🛠️ مثال عملي

#### 🚀 تشغيل Isolate لحساب الأرقام الأولية

<div dir="ltr">

```dart
import 'dart:isolate';

// الدالة التي سيتم تشغيلها داخل الـ Isolate
void findPrimes(SendPort sendPort) {
  List<int> primes = [];
  for (int i = 2; i < 100000; i++) {
    if (isPrime(i)) {
      primes.add(i);
    }
  }
  // إرسال النتائج إلى Isolate الرئيسي
  sendPort.send(primes);
}

bool isPrime(int number) {
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}

void main() async {
  // إنشاء قناة للتواصل بين Isolate الرئيسي والجديد
  ReceivePort receivePort = ReceivePort();

  // إنشاء Isolate جديد
  await Isolate.spawn(findPrimes, receivePort.sendPort);

  // الاستماع إلى النتائج
  receivePort.listen((message) {
    print("🧮 عدد الأرقام الأولية: ${message.length}");
    receivePort.close();
  });
}
```
</div>


---

### 📝 شرح الكود

1. **🔧 Isolate.spawn**:

   - ينشئ Isolate جديدًا ويقوم بتشغيل دالة داخله.
   - يأخذ دالة (مثل `findPrimes`) وبيانات إضافية إذا لزم الأمر.

2. **📬 ReceivePort**:

   - قناة تواصل بين Isolates.
   - Isolate الجديد يرسل البيانات من خلال SendPort.

3. **📤 SendPort**:

   - الجزء المستخدم لاستقبال البيانات داخل الـ 🏠Main Isolate.

---

### 🧪 مثال بسيط

#### 🖨️ إرسال رسالة من Isolate جديد:

<div dir="ltr">

```dart
import 'dart:isolate';

void printMessage(SendPort sendPort) {
  sendPort.send("💬 مرحبًا من Isolate الجديد!");
}

void main() async {
  ReceivePort receivePort = ReceivePort();

  // تشغيل Isolate جديد
  await Isolate.spawn(printMessage, receivePort.sendPort);

  // استقبال الرسائل
  receivePort.listen((message) {
    print(message);
    receivePort.close();
  });
}
```
</div>


**الناتج:**

```
💬 مرحبًا من Isolate الجديد!
```

---

### 🏆 الفوائد العملية

- تُستخدم Isolates في الحالات التي تتطلب معالجة مكثفة مثل:
  1. 🔍 تحليل بيانات ضخمة.
  2. 🖼️ معالجة الصور أو الفيديو.
  3. 🌐 التفاعل المكثف مع الخوادم.

### 💡 نصيحة احترافية

في الحالات البسيطة التي تتطلب عمليات متوازية، يمكنك استخدام **compute** من مكتبة Flutter، حيث تُبسط عملية استخدام Isolates:
<div dir="ltr">

```dart
import 'package:flutter/foundation.dart';

Future<int> heavyTask(int number) async {
  return number * 2; // مثال على عملية بسيطة
}

void main() async {
  int result = await compute(heavyTask, 5);
  print("📊 النتيجة: $result");
}
```
</div>


---

### 📚 الخلاصة

- **🔀Isolates** أداة قوية للتعامل مع العمليات المكثفة دون تعطيل واجهة المستخدم 🖥️.
- استخدم **📬ReceivePort** و **📤SendPort** للتواصل بين Isolates.
- استخدم **⚡compute** للحالات الأبسط مع Flutter.

إذا كنت بحاجة إلى شرح إضافي أو تطبيق عملي، لا تتردد في طلب المساعدة! 😄

</div>