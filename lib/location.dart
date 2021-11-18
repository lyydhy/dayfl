/// 常量类
class Location {
  // 默认格式化字符串
  static const String defaultFormatStr = "YYYY-MM-DD HH:mm:ss";

  /// 从1开始的 月份英文缩写数组
  static List<String> monthToEnglishAbbreviations() {
    return [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
  }

  // regex 正则均摘自 [dayjs](https://github.com/iamkun/dayjs)
  /// 解析格式正则
  static RegExp regexFormat = RegExp(
      r"\[([^\]]+)]|Y{1,4}|M{1,4}|D{1,2}|d{1,4}|H{1,2}|h{1,2}|a|A|m{1,2}|s{1,2}");

  /// 解析日期正则
  static RegExp regexParse = RegExp(
      r"/^(\d{4})[-/]?(\d{1,2})?[-/]?(\d{0,2})[Tt\s]*(\d{1,2})?:?(\d{1,2})?:?(\d{1,2})?[.:]?(\d+)?$/");
}
