# Dayfl

Dayfl 是一个纯 Dart 日期格式化工具库，灵感来源于 JavaScript 的 Day.js。支持日期解析、格式化、比较、加减运算等功能。内置中文和英文语言包，支持自定义语言扩展。

## 特性

- 🎯 **纯 Dart 实现** - 无需原生平台依赖
- 🌍 **跨平台支持** - 支持所有 Flutter 支持的平台
- ⚡ **零依赖** - 无第三方依赖
- 🔧 **丰富 API** - 日期解析、格式化、比较、加减运算
- 🌐 **多语言** - 内置中文和英文语言包

## 快速安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  dayfl: ^2.0.4
```

## 基本用法

```dart
import 'package:dayfl/dayfl.dart';

// 当前时间
final now = Dayfl();

// 字符串解析
final date = Dayfl('2024-01-15');

// 格式化
print(date.format('YYYY-MM-DD'));  // 2024-01-15
print(date.format('MM月DD日'));     // 01月15日

// 日期操作
final nextWeek = date.add(DateLocationEnum.day, 7);
final lastMonth = date.subtract(DateLocationEnum.month, 1);

// 日期比较
print(date.isBefore(nextWeek));  // true
print(date.isSame(Dayfl('2024-01-15')));  // true
```
