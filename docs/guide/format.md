# 格式化占位符

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

## 示例

```dart
final d = Dayfl('2024-03-09 14:05:08');

d.format('YYYY-MM-DD');           // 2024-03-09
d.format('YY/M/D');               // 24/3/9
d.format('HH:mm:ss');             // 14:05:08
d.format('h:mm A');               // 2:05 PM
d.format('YYYY年MM月DD日');        // 2024年03月09日
d.format('MM/DD HH:mm');          // 03/09 14:05
d.format('YYYY-MM-DD HH:mm:ss.SSS'); // 2024-03-09 14:05:08.000
d.format('WW', 'en');             // Saturday
d.format('MMM', 'en');            // March
```
