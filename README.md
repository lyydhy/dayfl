# dayfl

借鉴 [dayjs](https://github.com/iamkun/dayjs) 自己写的自己使用的一个 flutter 日期格式化工具

格式化功能 和 [dayjs](https://github.com/iamkun/dayjs) 一样

可能有性能问题 大型项目慎用！ 主要技术不加，欢迎大佬提供意见修改

[dayjs](https://github.com/iamkun/dayjs)的插件功能 用 dart extension 代替吧

# 示例

```dart
    // 参数1  接收 DateTime 和 int  和 String- 须符合DateTime.parse()
    // 参数2  当String 不符合DateTime.parse()的时候 传入你日期格式化字符串
    Dayfl(参数1， 参数2)
    
    // 参数2 语言包名称 默认cn
    Dayfl().format(格式化字符串, [参数2])
    // 无参时 默认当前时间 格式为 YYYY-MM-DD HH:mm:ss
    // 其他格式参照下面表格

    // 新增格式化参数
    // 参数key 类似于 YYYY MM DD
    Dayfl.addMatchers(参数key, (
        datetime, {
        String year = '',
        String month = '',
        String day = '',
        String hour = '',
        String minute = '',
        String second = '',
    }) {
        return 参数key 对应 的值;
    })

    // 更多功能看示例
```

### 当前时间没得验证功能 请传入的时间字符串是个有效的字符串 不然会报错的

# 格式化字符串参数

| 标识 | 实例    | 描述            |
| ---- | ------- | --------------- |
| YY   | 21      | 年, 两位数      |
| YYYY | 2021    | 年, 四位数      |
| M    | 1-12    | 月, 从 1 开始   |
| MM   | 01-12   | 月, 两位数字    |
| MMM  | Jan-Dec | 月, 英文缩写    |
| D    | 1-31    | 日              |
| DD   | 01-31   | 日, 两位数字    |
| H    | 0-23    | 24 小时         |
| HH   | 01-23   | 24 小时, 两位数 |
| h    | 1-12    | 12 小时         |
| hh   | 01-12   | 12 小时, 两位数 |
| m    | 0-59    | 分钟            |
| mm   | 01-59   | 分钟, 两位数    |
| s    | 0-59    | 秒              |
| ss   | 01-59   | 秒, 两位数      |
| A    | AM / PM | 上/下午, 大写   |
| a    | am / pm | 上/下午, 小写   |
| W    | 1-7     | 星期 数字       |
| WW   | 1-7     | 星期 语言包     |
