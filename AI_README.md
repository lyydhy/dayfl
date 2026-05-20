# Dayfl - Dart 日期格式化库

## 概述

Dayfl 是一个纯 Dart 日期格式化工具库，灵感来源于 JavaScript 的 Day.js。支持日期解析、格式化、比较、加减运算等功能。内置中文和英文语言包，支持自定义语言扩展。

- **版本**: 2.0.2
- **仓库**: https://github.com/lyydhy/dayfl
- **Dart SDK**: ^3.6.2
- **依赖**: 无外部依赖（纯 Dart 实现）
- **测试**: 174 个测试用例，全部通过

## 文件结构

```
lib/
├── dayfl.dart      # 主类，提供所有日期操作 API
├── format.dart     # 内部解析类，处理日期字符串解析
├── test/
│   └── dayfl_test.dart  # 测试文件
```

## 核心 API

### 构造函数

```dart
// 当前时间
Dayfl()

// 字符串解析（自动识别格式）
Dayfl('2024-01-15')
Dayfl('2024-01-15 10:30:00')
Dayfl('26/1/06 13:05:1', 'YY/M/DD HH:mm:s')

// DateTime 对象
Dayfl(DateTime(2024, 1, 15))

// 时间戳（自动判断秒/毫秒）
Dayfl(1705276800)      // 秒级时间戳
Dayfl(1705276800000)   // 毫秒级时间戳

// 年份数字（作为年份处理）
Dayfl(2024)
```

### 格式化 `format()`

```dart
Dayfl().format()  // "YYYY-MM-DD HH:mm:ss" 格式

Dayfl().format('YYYY-MM-DD')           // "2024-01-15"
Dayfl().format('YYYY/MM/DD HH:mm:ss')  // "2024/01/15 10:30:00"
Dayfl().format('MM-DD HH:mm')          // "01-15 10:30"
Dayfl().format('YYYY-MMM-WW', 'en')    // "2024-January-03" (英文)
Dayfl().format('', '', true)            // 文字格式化: "刚刚" / "1天前" / "2月前"
```

**格式化占位符:**

| 占位符 | 说明 | 示例 |
|--------|------|------|
| YYYY | 四位年 | 2024 |
| YY | 两位年 | 24 |
| M | 月（无补零） | 1-12 |
| MM | 月（补零） | 01-12 |
| MMM | 月缩写（语言相关） | 一月/January |
| D | 日（无补零） | 1-31 |
| DD | 日（补零） | 01-31 |
| H | 时 24h（无补零） | 0-23 |
| HH | 时 24h（补零） | 00-23 |
| h | 时 12h（无补零） | 1-12 |
| hh | 时 12h（补零） | 01-12 |
| m | 分（无补零） | 0-59 |
| mm | 分（补零） | 00-59 |
| s | 秒（无补零） | 0-59 |
| ss | 秒（补零） | 00-59 |
| SSS | 毫秒 | 000-999 |
| A | AM/PM | AM |
| a | am/pm | am |
| W | 周数（数字） | 1-53 |
| WW | 周名（语言相关） | 星期一/Monday |

### 属性访问

```dart
final d = Dayfl('2024-01-15 10:30:45');

d.year       // int: 2024
d.month      // int: 1
d.day        // int: 15
d.hour       // int: 10
d.minute     // int: 30
d.second     // int: 45
d.dateTime   // DateTime 原始对象
d.valueOf    // int: 毫秒时间戳
d.isLeapYear // bool: 是否闰年
d.daysInMonth // int: 当月天数
d.toArray()  // [2024, 1, 15, 10, 30, 45]
d.isUtc      // bool
```

### Setter（属性赋值）

```dart
d.year = 2025
d.month = 12
d.day = 25
d.hour = 18
d.minute = 30
d.second = 0
```

### 链式调用 Setter

```dart
d.setYear(2025).setMonth(12).setDay(25).setHour(18).setMinute(30).setSecond(0)
```

### 日期加减

```dart
d.add(DateLocationEnum.day, 5)       // 加 5 天
d.add(DateLocationEnum.month, 2)     // 加 2 个月
d.add(DateLocationEnum.year, 1)      // 加 1 年
d.subtract(DateLocationEnum.hour, 3) // 减 3 小时
d.subtract(DateLocationEnum.sec, 30) // 减 30 秒
```

### 日期边界

```dart
d.endOf(DateLocationEnum.year)   // 年末: 12-31 23:59:59.999
d.endOf(DateLocationEnum.month)  // 月末: 当月最后一天 23:59:59.999
d.endOf(DateLocationEnum.day)    // 日末: 当天 23:59:59.999
```

### 日期比较

```dart
d.isBefore(other)    // bool: 是否在 other 之前
d.isAfter(other)     // bool: 是否在 other 之后
d.isSame(other)      // bool: 是否相同（毫秒精度）
d.isSame(other, DateLocationEnum.year)   // 同年
d.isSame(other, DateLocationEnum.month)  // 同年同月
d.isSame(other, DateLocationEnum.day)    // 同年同月同日
d.compareTo(other)   // int: -1, 0, 1
```

**other 参数支持类型**: `Dayfl` / `DateTime` / `String`

### 时间差

```dart
Duration diff = d.difference(other)           // Duration 对象
int hours = d.diffIn(other, DateLocationEnum.hour)    // 小时差
int days = d.diffIn(other, DateLocationEnum.day)      // 天数差
int months = d.diffIn(other, DateLocationEnum.month)  // 月份差
```

### 语言包

```dart
// 切换全局语言
d.setLocale = 'en';

// format 指定语言（不影响全局）
d.format('YYYY-MMM-DD', 'en');  // "2024-January-15"
d.format('YYYY-MMM-DD', 'cn');  // "2024-一月-15"

// 获取当前语言的周信息
Map weekInfo = d.getWeek('en');  // {'num': 1, 'text': 'Monday'}
```

### 扩展机制

```dart
// 添加自定义格式化器（静态方法，全局生效）
Dayfl.addMatchers('BB', (dayfl) => dayfl.year.toString());
Dayfl().format('BB');  // "2024"

// 删除自定义格式化器
Dayfl.delMatchers('BB');

// 添加新语言包（静态方法）
Dayfl.addLocale(Locale(
  name: 'ja',
  monthAbbreviations: ['1月', '2月', '3月', ...],
  weekStart: 1,
  weekAbbreviations: ['月曜日', '火曜日', ...],
  formatText: {'ltTenSec': 'たった今', 'yesterday': '昨日', ...},
));
```

### DateLocationEnum 枚举

```dart
enum DateLocationEnum {
  year,
  month,
  day,
  hour,
  minute,
  sec,
  millisecondsSinceEpoch
}
```

用于 `add()`、`subtract()`、`isSame()`、`diffIn()` 等方法的单位参数。

## 内置语言

| 语言 | name | weekStart | 周起始 |
|------|------|-----------|--------|
| 中文 | cn | 1 | 周一 |
| 英文 | en | 0 | 周日 |

## Locale 类

```dart
class Locale {
  String name;                      // 语言名称（唯一标识）
  List<String> monthAbbreviations;  // 月份缩写，12 个，从一月开始
  int weekStart;                    // 0=周日开头, 1=周一开头
  List<String> weekAbbreviations;   // 周缩写，7 个
  Map<String, String> formatText;   // 文字格式化键值对
  Map<String, String> otherText;    // 扩展文字
}
```

## 测试

```bash
dart test
```

运行全部 174 个测试，覆盖：
- 构造函数变体（7种输入类型）
- 所有 format 占位符（20个）
- format dayFormat 文字格式化和回调
- add/subtract 全单位（年月日时分秒）
- endOf 全6级
- isBefore/isAfter（Dayfl/DateTime/String）
- isSame 全7级精度
- difference/diffIn 全单位
- compareTo
- 月溢出边界
- 中英文周格式化
- MMM 月份缩写中英文
- 语言包切换和自定义语言
- addMatchers/delMatchers
- 自定义格式解析
- 边界情况

## 已知限制

1. `Locale` 类字段是可变的（非 final），但设计上不应被修改
2. 自定义格式化器 (`addMatchers`) 是全局静态的，无法实例级别隔离
3. 不支持时区转换（基于 Dart `DateTime`）
4. `endOf()` 方法仅支持到秒级精度（毫秒固定为 999）
5. 月份加减时，日期会钳位到目标月份最大天数（如 1月31+1月 → 2月28/29）
