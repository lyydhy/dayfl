# API 文档

## 构造函数

```dart
// 当前时间
Dayfl()

// 字符串解析
Dayfl('2024-01-15')
Dayfl('2024-01-15 10:30:00')
Dayfl('26/1/06 13:05:1', 'YY/M/DD HH:mm:s')

// DateTime 对象
Dayfl(DateTime(2024, 1, 15))

// 时间戳
Dayfl(1705276800)      // 秒级
Dayfl(1705276800000)   // 毫秒级

// 年份
Dayfl(2024)
```

## 属性访问

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

## 格式化

```dart
d.format()  // "YYYY-MM-DD HH:mm:ss" 格式

d.format('YYYY-MM-DD')           // "2024-01-15"
d.format('YYYY/MM/DD HH:mm:ss')  // "2024/01/15 10:30:00"
d.format('MM-DD HH:mm')          // "01-15 10:30"
d.format('YYYY-MMM-WW', 'en')    // "2024-January-03" (英文)
d.format('', '', true)            // 文字格式化: "刚刚" / "1天前" / "2月前"
```

## Setter（属性赋值）

```dart
d.year = 2025
d.month = 12
d.day = 25
d.hour = 18
d.minute = 30
d.second = 0
```

## 链式调用 Setter

```dart
d.setYear(2025).setMonth(12).setDay(25).setHour(18).setMinute(30).setSecond(0)
```

## 通用 Getter / Setter

```dart
d.get(DateLocationEnum.year)     // int: 按单位获取值
d.get(DateLocationEnum.month)

d.set(DateLocationEnum.year, 2025)    // 按单位设置值，支持链式
d.set(DateLocationEnum.month, 12).set(DateLocationEnum.day, 25)
```

## 日期加减

```dart
d.add(DateLocationEnum.day, 5)       // 加 5 天
d.add(DateLocationEnum.month, 2)     // 加 2 个月
d.add(DateLocationEnum.year, 1)      // 加 1 年
d.subtract(DateLocationEnum.hour, 3) // 减 3 小时
d.subtract(DateLocationEnum.sec, 30) // 减 30 秒
```

## 日期边界

```dart
d.startOf(DateLocationEnum.year)   // 年初: 01-01 00:00:00.000
d.startOf(DateLocationEnum.month)  // 月初: 当月1日 00:00:00.000
d.startOf(DateLocationEnum.day)    // 日初: 当天 00:00:00.000

d.endOf(DateLocationEnum.year)   // 年末: 12-31 23:59:59.999
d.endOf(DateLocationEnum.month)  // 月末: 当月最后一天 23:59:59.999
d.endOf(DateLocationEnum.day)    // 日末: 当天 23:59:59.999
```

## 日期比较

```dart
d.isBefore(other)    // bool: 是否在 other 之前
d.isAfter(other)     // bool: 是否在 other 之后
d.isSame(other)      // bool: 是否相同（毫秒精度）
d.isSame(other, DateLocationEnum.year)   // 同年

d.isSameOrBefore(other)            // 小于等于
d.isSameOrBefore(other, DateLocationEnum.month) // 同月或之前

d.isSameOrAfter(other)             // 大于等于
d.isSameOrAfter(other, DateLocationEnum.year)   // 同年或之后

d.isBetween(a, b)                  // 是否在 a 和 b 之间（不含端点）
d.isBetween(a, b, inclusive: true) // 含端点

d.compareTo(other)   // int: -1, 0, 1
```

**other 参数支持类型**: `Dayfl` / `DateTime` / `String`

## 时间差

```dart
Duration diff = d.difference(other)           // Duration 对象
int hours = d.diffIn(other, DateLocationEnum.hour)    // 小时差
int days = d.diffIn(other, DateLocationEnum.day)      // 天数差
int months = d.diffIn(other, DateLocationEnum.month)  // 月份差
```

## 工具方法

```dart
d.unix()          // int?: 秒级 Unix 时间戳
d.toISOString()   // String?: ISO 8601 字符串
d.isValid()       // bool: 日期是否有效
```

## 语言包

```dart
// 切换全局语言
d.setLocale = 'en';

// format 指定语言（不影响全局）
d.format('YYYY-MMM-DD', 'en');  // "2024-January-15"
d.format('YYYY-MMM-DD', 'cn');  // "2024-一月-15"

// 获取当前语言的周信息（num=星期几数字1-7，text=星期几名称）
Map weekInfo = d.getWeek('en');  // {'num': 6, 'text': 'Saturday'}
```

## 扩展机制

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
