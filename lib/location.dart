/*
 * @Author: your name
 * @Date: 2021-11-17 16:53:10
 * @LastEditTime: 2021-11-17 18:13:01
 * @LastEditors: Please set LastEditors
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \dayfl\lib\location.dart
 */
class Location {
  // 默认格式化字符串
  static const String defaultFormatStr = "YYYY-MM-DD HH:mm:ss";
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

  // regex
  static RegExp regexFormat = RegExp(
      r"\[([^\]]+)]|Y{1,4}|M{1,4}|D{1,2}|d{1,4}|H{1,2}|h{1,2}|a|A|m{1,2}|s{1,2}");
  static RegExp regexParse = RegExp(
      r"/^(\d{4})[-/]?(\d{1,2})?[-/]?(\d{0,2})[Tt\s]*(\d{1,2})?:?(\d{1,2})?:?(\d{1,2})?[.:]?(\d+)?$/");
}
