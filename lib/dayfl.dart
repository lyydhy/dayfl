/// Dayfl
import 'format.dart';
import 'location.dart';

// typedef pluginFunc = void Function(Dayfl dayfl);

/// 回调
typedef MatchersFunc = String Function(Dayfl dayfl);

class Dayfl {
  /// datetime
  late DateTime _datetime;

  /// 年
  String _year = '';

  /// 月
  String _month = '';

  /// 日
  String _day = '';

  /// 小时
  String _hour = '';

  /// 分钟
  String _minute = '';

  /// 秒
  String _sec = '';

  /// 格式化对象
  Map<String, String> _matchers = {};

  /// 新增格式map
  // ignore: prefer_final_fields
  static Map<String, MatchersFunc> _matcherstatic = {};

  /// [datetime] 支持传入格式  Dayfl | String | int | DateTime
  ///
  /// [formatStr] datetime 传入字符串的时候 可以传入的解析格式字符串
  Dayfl([var datetime, String formatStr = '']) {
    _object(datetime, formatStr);
  }

  // 设置秒数
  // void second(int num) {
  //   if (num > 60 || num < 0) return;
  // }

  /// 之前
  ///
  /// [date] 接收时间可以是 Dayfl | 时间字符串 | DateTime  三者都不是 return false;
  bool isBefore(var date) {
    if (date is Dayfl) {
      return _datetime.isBefore(date.dateTime);
    } else if (date is DateTime) {
      return _datetime.isBefore(date);
    } else if (date is String) {
      return _datetime.isBefore(Dayfl(date).dateTime);
    }
    return false;
  }

  /// 之后
  ///
  /// [date] 接收时间可以是 Dayfl|时间字符串|DateTime 三者都不是 return false;
  bool isAfter(var date) {
    if (date is Dayfl) {
      return _datetime.isAfter(date.dateTime);
    } else if (date is DateTime) {
      return _datetime.isAfter(date);
    } else if (date is String) {
      return _datetime.isAfter(Dayfl(date).dateTime);
    }

    return false;
  }

  /// 获取时间戳 单位毫秒
  int valueOf() {
    return _datetime.millisecondsSinceEpoch;
  }

  /// 格式化
  String format([String formatStr = Location.defaultFormatStr]) {
    String s = formatStr.replaceAllMapped(Location.regexFormat, (match) {
      if (match.groupCount > -1) {
        String v = match.group(0).toString();
        if (_matchers[v] != null) {
          return _matchers[v].toString();
        }
      }
      return '';
    });
    if (_matcherstatic.isNotEmpty) {
      _matcherstatic.forEach((key, value) {
        s = s.replaceAll(key, _matchers[key].toString());
      });
    }
    return s;
  }

  /// 添加日期
  ///
  /// [duration] 示例 Duration(days: 1)
  Dayfl add(Duration duration) {
    _datetime = _datetime.add(duration);
    return this;
  }

  /// 减去日期
  ///
  /// [duration] 示例 Duration(days: 1)
  Dayfl subtract(Duration duration) {
    _datetime.subtract(duration);
    return this;
  }

  /// 时间差 两个时间相差 小时数
  ///
  /// [date] 必须是  Dayfl 或者 DateTime
  Duration difference(var date) {
    if (date is Dayfl) {
      return _datetime.difference(date.dateTime);
    } else if (date is DateTime) {
      return _datetime.difference(date);
    } else {
      return const Duration(hours: 0);
    }
  }

  /// isUtc
  bool isUtc() {
    return _datetime.isUtc;
  }

  /// 和DateTime 的 compareTo 方法一样
  ///
  /// [date] 必须是  Dayfl 或者 DateTime
  int compareTo(var date) {
    if (date is Dayfl) {
      return _datetime.compareTo(date.dateTime);
    } else {
      return _datetime.compareTo(date);
    }
  }

  /// 类型推断
  void _object(var datetime, [String formatStr = '']) {
    if (datetime is Dayfl) {
      _datetime = datetime.dateTime;
    } else if (datetime is String) {
      _datetime = Format(timeStr: datetime, formatStr: formatStr).dateTime;
    } else if (datetime is DateTime) {
      _datetime = datetime;
    } else if (datetime is int) {
      _datetime = DateTime(datetime);
    } else {
      _datetime = DateTime.now();
    }
    _init();
  }

  /// 初始化
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

    if (_matcherstatic.isNotEmpty) {
      _matcherstatic.forEach((key, value) {
        Map<String, String> _m = {
          key: value(this),
        };
        if (!_matchers.containsKey(key)) {
          _matchers.addAll(_m);
        }
      });
    }
  }

  /// 根据长度补零
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

  /// 新增格式化参数
  ///
  /// [key] 参数key值 类似于 YYYY MM DD
  ///
  /// [matchersFunc] 回调方法 传入可执行的方法  返回 String
  static void addMatchers(String key, MatchersFunc matchersFunc) {
    Map<String, MatchersFunc> _m = {key: matchersFunc};
    if (_matcherstatic.containsKey(key)) {
      _matcherstatic.remove(key);
    }
    _matcherstatic.addAll(_m);
  }

  /// 删除自定添加的格式化参数
  ///
  /// [key] 参数key值  自己在addMatchers时添加的
  static void delMatchers(String key) {
    if (_matcherstatic.containsKey(key)) {
      _matcherstatic.remove(key);
    }
  }

  /// 获取时间 返回 DateTime
  DateTime get dateTime => _datetime;

  /// 获取年 String
  String get year => _year;

  /// 获取月 String
  String get month => _month;

  /// 获取日 String
  String get day => _day;

  /// 获取小时 String
  String get hour => _hour;

  /// 获取分钟 String
  String get minute => _minute;

  /// 获取秒 String
  String get second => _sec;
}
