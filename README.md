<div align="center">
  <h1>📅 Dayfl</h1>
  <p><strong>一个轻量级、高性能的 Flutter 日期格式化库</strong></p>
  
  [![Pub Version](https://img.shields.io/pub/v/dayfl?style=flat-square)](https://pub.dev/packages/dayfl)
  [![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
  [![Dart](https://img.shields.io/badge/dart-%3E%3D2.15.1-blue.svg?style=flat-square)](https://dart.dev/)
  [![Flutter](https://img.shields.io/badge/flutter-%3E%3D1.20.0-blue.svg?style=flat-square)](https://flutter.dev/)
</div>

## ✨ 特性

- 🎯 **纯Dart实现**: 完全使用Dart语言编写，无需原生平台依赖
- 🌍 **跨平台支持**: 支持iOS、Android、Web、Windows、macOS、Linux等所有Flutter支持的平台
- 🚀 **轻量级**: 零依赖，体积小巧
- ⚡ **高性能**: 优化的算法，快速处理
- 🔧 **易用性**: 简洁的 API，类似 Day.js 的使用体验
- 🌐 **多语言**: 支持中英文等多种语言
- 🛡️ **类型安全**: 完整的类型检查和错误处理
- 🔄 **灵活扩展**: 支持自定义格式化规则

## 📖 简介

Dayfl 是一个受 [Day.js](https://github.com/iamkun/dayjs) 启发的 Flutter 日期格式化库。它提供了与 Day.js 相同的格式化功能，但专为 Flutter/Dart 环境优化。通过 Dart Extension 的方式替代了插件系统，让代码更加简洁高效。

## 🚀 快速开始

### 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  dayfl: ^2.0.0
```

然后运行：

```bash
flutter pub get
```

### 基本用法

```dart
import 'package:dayfl/dayfl.dart';

// 创建 Dayfl 实例
final now = Dayfl();                    // 当前时间
final date = Dayfl(DateTime.now());     // 从 DateTime 创建
final timestamp = Dayfl(1640995200000); // 从时间戳创建
final dateStr = Dayfl('2021-12-31');    // 从字符串创建

// 格式化输出
print(now.format());                    // 2021-12-31 23:59:59
print(date.format('YYYY年MM月DD日'));    // 2021年12月31日
print(timestamp.format('MM/DD/YYYY'));  // 12/31/2021
```

## 📚 使用示例

### 📅 日期创建

```dart
// 多种方式创建日期实例
final now = Dayfl();                           // 当前时间
final fromDateTime = Dayfl(DateTime.now());    // 从 DateTime 对象
final fromTimestamp = Dayfl(1640995200000);    // 从时间戳（毫秒）
final fromString = Dayfl('2021-12-31');        // 从标准日期字符串
final fromCustom = Dayfl('31/12/2021', 'DD/MM/YYYY'); // 自定义格式字符串
```

### 🎨 格式化输出

```dart
final date = Dayfl('2021-12-31 15:30:45');

// 基本格式化
date.format();                    // 2021-12-31 15:30:45 (默认格式)
date.format('YYYY-MM-DD');        // 2021-12-31
date.format('YYYY年MM月DD日');     // 2021年12月31日
date.format('MM/DD/YYYY');        // 12/31/2021

// 时间格式化
date.format('HH:mm:ss');          // 15:30:45
date.format('hh:mm A');           // 03:30 PM
date.format('h:m a');             // 3:30 pm

// 星期格式化
date.format('dddd, MMMM DD');     // Friday, December 31
date.format('WW');                // 星期五 (中文)
```

### 🔧 自定义格式化规则

```dart
// 添加自定义格式化规则
Dayfl.addMatchers('Q', (datetime, dayfl) {
  return '第${((datetime.month - 1) ~/ 3) + 1}季度';
});

final date = Dayfl('2021-12-31');
print(date.format('YYYY年Q')); // 2021年第4季度
```

### ⚡ 日期操作

```dart
final date = Dayfl('2021-12-31');

// 日期比较
date.isBefore('2022-01-01');      // true
date.isAfter('2021-12-30');       // true
date.isSame('2021-12-31');        // true

// 日期计算
date.add(1, 'day');               // 2022-01-01
date.subtract(1, 'month');        // 2021-11-30
date.startOf('month');            // 2021-12-01
date.endOf('year');               // 2021-12-31

// 时间差计算
date.difference('2022-01-01');    // 返回 Duration 对象
date.diffIn('2022-01-01', DateLocationEnum.day);    // 相差天数（整数）
date.diffIn('2022-01-01', DateLocationEnum.hour);   // 相差小时数（整数）
date.diffIn('2022-01-01', DateLocationEnum.month);  // 相差月数（整数）
```

> ⚠️ **注意**: 请确保传入的日期字符串是有效的格式，无效的日期字符串会抛出异常。

## 📋 格式化参数表

### 📅 年月日

| 标识 | 示例输出 | 描述 |
|------|----------|------|
| `YY` | 21 | 年份，两位数 |
| `YYYY` | 2021 | 年份，四位数 |
| `M` | 1-12 | 月份，从 1 开始 |
| `MM` | 01-12 | 月份，两位数字 |
| `MMM` | Jan-Dec | 月份，英文缩写 |
| `MMMM` | January-December | 月份，英文全称 |
| `D` | 1-31 | 日期 |
| `DD` | 01-31 | 日期，两位数字 |

### ⏰ 时分秒

| 标识 | 示例输出 | 描述 |
|------|----------|------|
| `H` | 0-23 | 24小时制小时 |
| `HH` | 00-23 | 24小时制小时，两位数 |
| `h` | 1-12 | 12小时制小时 |
| `hh` | 01-12 | 12小时制小时，两位数 |
| `m` | 0-59 | 分钟 |
| `mm` | 00-59 | 分钟，两位数 |
| `s` | 0-59 | 秒 |
| `ss` | 00-59 | 秒，两位数 |
| `SSS` | 000-999 | 毫秒，三位数 |
| `A` | AM/PM | 上午/下午，大写 |
| `a` | am/pm | 上午/下午，小写 |

### 📆 星期

| 标识 | 示例输出 | 描述 |
|------|----------|------|
| `W` | 1-7 | 星期，数字表示 |
| `WW` | 星期一-星期日 | 星期，中文表示 |
| `ddd` | Mon-Sun | 星期，英文缩写 |
| `dddd` | Monday-Sunday | 星期，英文全称 |

## 🌍 多语言支持

```dart
// 设置语言（默认为中文）
final date = Dayfl('2021-12-31');
date.format('YYYY年MM月DD日 WW'); // 2021年12月31日 星期五
date.format('MMMM DD, YYYY', 'en'); // December 31, 2021
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目基于 [MIT 许可证](LICENSE) 开源。

## 🙏 致谢

感谢 [Day.js](https://github.com/iamkun/dayjs) 项目提供的灵感和设计思路。
