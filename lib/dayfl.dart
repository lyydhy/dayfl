/*
 * @Author: your name
 * @Date: 2021-11-16 11:48:22
 * @LastEditTime: 2021-11-17 18:31:33
 * @LastEditors: Please set LastEditors
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \flutter_dayjs\lib\dayjs.dart
 */

import 'format.dart';
import 'location.dart';

class Dayfl {
  late DateTime _datetime;
  String _year = '';
  String _month = '';
  String _day = '';
  String _hour = '';
  String _minute = '';
  String _sec = '';
  Map<String, String> _matchers = {};
  Dayfl([var datetime, String formatStr = '']) {
    _object(datetime, formatStr);
  }

  // 设置秒数
  // void second(int num) {
  //   if (num > 60 || num < 0) return;
  // }

  /// 之前
  ///
  /// [date] 接收时间可以是 Dayfl|时间字符串|DateTime  两者都不是 return false;
  bool isBefore(var date) {
    if (date is Dayfl) {
      return _datetime.isBefore(date.getDateTime());
    } else if (date is DateTime) {
      return _datetime.isBefore(date);
    } else if (date is String) {
      return _datetime.isBefore(Dayfl(date).getDateTime());
    }
    return false;
  }

  /// 之后
  ///
  /// [date] 接收时间可以是 Dayfl|时间字符串|DateTime 两者都不是 return false;
  bool isAfter(var date) {
    if (date is Dayfl) {
      return _datetime.isAfter(date.getDateTime());
    } else if (date is DateTime) {
      return _datetime.isAfter(date);
    } else if (date is String) {
      return _datetime.isAfter(Dayfl(date).getDateTime());
    }

    return false;
  }

  /// 获取时间 返回 DateTime
  DateTime getDateTime() {
    return _datetime;
  }

  /// 获取时间戳 单位毫秒
  int valueOf() {
    return _datetime.millisecondsSinceEpoch;
  }

  /// 格式化
  String format([String formatStr = Location.defaultFormatStr]) {
    return formatStr.replaceAllMapped(Location.regexFormat, (match) {
      if (match.groupCount > -1) {
        String v = match.group(0).toString();
        if (_matchers[v] != null) {
          return _matchers[v].toString();
        }
      }
      return '';
    });
  }

  /// 添加日期
  Dayfl add(Duration duration) {
    _datetime = _datetime.add(duration);
    return this;
  }

  /// 减去日期
  Dayfl subtract(Duration duration) {
    _datetime.subtract(duration);
    return this;
  }

  /// 时间差 两个时间相差 小时数
  ///
  /// [date] 必须是  Dayfl 或者 DateTime
  Duration difference(var date) {
    if (date is Dayfl) {
      return _datetime.difference(date.getDateTime());
    } else if (date is DateTime) {
      return _datetime.difference(date);
    } else {
      return const Duration(hours: 0);
    }
  }

  // 类型推断
  void _object(var datetime, [String formatStr = '']) {
    if (datetime is String) {
      _datetime = Format(timeStr: datetime, formatStr: formatStr).getDateTime();
    } else if (datetime is DateTime) {
      _datetime = datetime;
    } else if (datetime is int) {
      _datetime = DateTime(datetime);
    } else {
      _datetime = DateTime.now();
    }
    _init();
  }

  void _init() {
    _year = _datetime.year.toString();
    _month = _datetime.month.toString();
    _day = _datetime.day.toString();
    _hour = _datetime.hour.toString();
    _minute = _datetime.minute.toString();
    _sec = _datetime.second.toString();
    int _h = int.parse(_hour);
    _h = _h > 12 ? _h - 12 : _h;

    _matchers = {
      "YY": _year.substring(2),
      "YYYY": _year,
      "M": _month,
      "MM": _fillZero(_month, 2),
      "MMM": Location.monthToEnglishAbbreviations()[int.parse(_month)],
      "D": _day,
      "DD": _fillZero(_day, 2),
      "H": _hour,
      "HH": _fillZero(_hour, 2),
      "h": _h.toString(),
      "hh": _fillZero(_h.toString(), 2),
      "m": _minute,
      "mm": _fillZero(_minute, 2),
      "s": _sec,
      "ss": _fillZero(_sec, 2),
      "A": int.parse(_hour) <= 12 ? 'AM' : 'PM',
      "a": int.parse(_hour) <= 12 ? 'am' : 'pm',
    };
  }

  // 根据长度补零
  String _fillZero(String str, int length) {
    if (str.length == length) {
      return str;
    }
    String _zero = '';
    for (int i = 0; i < length - str.length; i++) {
      _zero += '0';
    }

    return _zero + str;
  }
}
