/// 常量类
class Location {
  // 默认格式化字符串
  static const String defaultFormatStr = "YYYY-MM-DD HH:mm:ss";

  // regex 正则均摘自 [dayjs](https://github.com/iamkun/dayjs)
  /// 解析格式正则
  static RegExp regexFormat = RegExp(
      r"\[([^\]]+)]|Y{1,4}|M{1,4}|D{1,2}|d{1,4}|H{1,2}|h{1,2}|a|A|m{1,2}|s{1,2}|W{1,2}");

  /// 解析日期正则
  static RegExp regexParse = RegExp(
      r"(\d{4})?[\-\\\/]?(\d{1,2})?[\-\\\/]?(\d{0,2})[Tt\s]*(\d{1,2})?:?(\d{1,2})?:?(\d{1,2})?[.:]?(\d+)?");
}

/// 单位enum
enum DateLocationEnum {
  year,
  month,
  day,
  hour,
  minute,
  sec,
  millisecondsSinceEpoch
}

/// 语言模板
class Locale {
  /// 名称
  String name = '';

  /// 月份缩写开始
  int monthStart = 0;

  /// 月份缩写数组
  List<String> monthAbbreviations = [];

  /// 周缩写开始
  int weekStart = 0;

  /// 周数组
  List<String> weekAbbreviations = [];

  /// 格式文字
  Map<String, String> formatText = {};

  /// 其他文字  扩展的时候使用
  Map<String, String> otherText = {};

  /// [name] 语言名称
  ///
  /// [monthStart] 月份缩写开始下标  只能是 0 或者 1 其他长度请自行通过addMatchers的方式实现
  ///
  /// [monthAbbreviations] 月份缩写数组 必须是一月份开始递增
  ///
  /// [weekStart] 周缩写开始 只能是 0 或者 1 其他长度请自行通过addMatchers的方式实现
  ///
  /// [weekAbbreviations] 周数组
  ///
  /// [formatText] 格式文字
  Locale(
      {required this.name,
      this.monthStart = 0,
      this.monthAbbreviations = const [],
      this.weekStart = 0,
      this.weekAbbreviations = const [],
      this.formatText = const {},
      this.otherText = const {}});

  @override
  String toString() {
    return 'Locale{name: $name, monthStart: $monthStart, monthAbbreviations: $monthAbbreviations, weekStart: $weekStart, weekAbbreviations: $weekAbbreviations, formatText: $formatText}';
  }
}
