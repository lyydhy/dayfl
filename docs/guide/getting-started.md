# 快速开始

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  dayfl: ^2.0.4
```

然后运行：

```bash
flutter pub get
```

## 基本用法

### 1. 创建 Dayfl 对象

```dart
import 'package:dayfl/dayfl.dart';

// 当前时间
final now = Dayfl();

// 字符串解析（自动识别格式）
final date1 = Dayfl('2024-01-15');
final date2 = Dayfl('2024-01-15 10:30:00');
final date3 = Dayfl('26/1/06 13:05:1', 'YY/M/DD HH:mm:s');

// DateTime 对象
final date4 = Dayfl(DateTime(2024, 1, 15));

// 时间戳（自动判断秒/毫秒）
final date5 = Dayfl(1705276800);      // 秒级时间戳
final date6 = Dayfl(1705276800000);   // 毫秒级时间戳

// 年份数字
final date7 = Dayfl(2024);
```

### 2. 格式化日期

```dart
final d = Dayfl('2024-01-15 10:30:45');

// 默认格式
print(d.format());  // 2024-01-15 10:30:45

// 自定义格式
print(d.format('YYYY-MM-DD'));           // 2024-01-15
print(d.format('MM月DD日 HH:mm'));       // 01月15日 10:30
print(d.format('YYYY/MM/DD HH:mm:ss')); // 2024/01/15 10:30:45

// 英文月份
print(d.format('YYYY-MMM-DD', 'en'));   // 2024-Jan-15
```

### 3. 日期操作

```dart
final d = Dayfl('2024-01-15');

// 加减日期
final nextWeek = d.add(DateLocationEnum.day, 7);
final lastMonth = d.subtract(DateLocationEnum.month, 1);

// 设置日期边界
final startOfDay = d.startOf(DateLocationEnum.day);    // 2024-01-15 00:00:00
final endOfDay = d.endOf(DateLocationEnum.day);        // 2024-01-15 23:59:59.999
```

### 4. 日期比较

```dart
final d1 = Dayfl('2024-01-15');
final d2 = Dayfl('2024-01-20');

print(d1.isBefore(d2));           // true
print(d1.isAfter(d2));            // false
print(d1.isSame(d2));             // false
print(d1.isSameOrBefore(d2));     // true
print(d1.isBetween(Dayfl('2024-01-01'), Dayfl('2024-02-01')));  // true
```

### 5. 多语言支持

```dart
final d = Dayfl('2024-01-15');

// 中文（默认）
print(d.format('YYYY年MM月DD日'));  // 2024年01月15日

// 英文
print(d.format('YYYY-MM-DD', 'en'));  // 2024-01-15

// 切换全局语言
d.setLocale = 'en';
print(d.format('YYYY-MMM-DD'));  // 2024-Jan-15
```
