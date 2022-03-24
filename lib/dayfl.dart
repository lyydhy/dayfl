/// Dayfl
import 'format.dart';
import 'location.dart';
export 'location.dart';
// typedef pluginFunc = void Function(Dayfl dayfl);

/// 回调
typedef MatchersFunc = String Function(Dayfl dayfl);

class Dayfl {
  /// datetime
  DateTime? _datetime;

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

  /// locale
  static String _localeName = 'cn';

  /// 格式化对象
  Map<String, String> _matchers = {};

  /// 语言数组 默认中文
  static final List<Locale> _locales = [
    Locale(
      name: 'cn',
      monthStart: 0,
      monthAbbreviations: [
        '一月',
        '二月',
        '三月',
        '四月',
        '五月',
        '六月',
        '七月',
        '八月',
        '九月',
        '十月',
        '十一月',
        '十二月',
      ],
      weekStart: 0,
      weekAbbreviations: [
        '星期一',
        '星期二',
        '星期三',
        '星期四',
        '星期五',
        '星期六',
        '星期日',
      ],
    ),
  ];

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
  //   _set(DateLocationEnum.sec, num, operation)
  // }

  /// 之前
  ///
  /// [date] 接收时间可以是 Dayfl | 时间字符串 | DateTime  三者都不是 return false;
  bool isBefore(var date) {
    if (date is Dayfl) {
      return _datetime!.isBefore(date.dateTime!);
    } else if (date is DateTime) {
      return _datetime!.isBefore(date);
    } else if (date is String) {
      return _datetime!.isBefore(Dayfl(date).dateTime!);
    }
    return false;
  }

  /// 之后
  ///
  /// [date] 接收时间可以是 Dayfl|时间字符串|DateTime 三者都不是 return false;
  bool isAfter(var date) {
    if (date is Dayfl) {
      return _datetime!.isAfter(date.dateTime!);
    } else if (date is DateTime) {
      return _datetime!.isAfter(date);
    } else if (date is String) {
      return _datetime!.isAfter(Dayfl(date).dateTime!);
    }

    return false;
  }

  /// 格式化
  ///
  /// [formatStr] 格式化字符串
  ///
  /// [locale] 语言包
  String format([
    String formatStr = Location.defaultFormatStr,
    String locale = '',
  ]) {
    if (_datetime == null) return '';
    if (locale == '') {
      locale = _localeName;
    }
    Locale _locale = getLocale(locale);
    if (!_matchers.containsKey("W")) {
      _matchers.addAll({
        "W": getWeek(locale)['num'].toString(),
        "WW": getWeek(locale)['text'],
      });
    }
    if (!_matchers.containsKey("MMM")) {
      if (_locale.monthStart == 0) {
        _matchers
            .addAll({"MMM": _locale.monthAbbreviations[int.parse(_month) - 1]});
      } else if (_locale.monthStart == 1) {
        _matchers
            .addAll({"MMM": _locale.monthAbbreviations[int.parse(_month)]});
      }
    }
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
  /// [type] 操作对象
  ///
  /// [num] 操作数值
  Dayfl add(DateLocationEnum type, int num) {
    _datetime = _set(type, num, 1);
    _init();
    return this;
  }

  /// 减去日期
  ///
  /// [type] 操作对象
  ///
  /// [num] 操作数值
  Dayfl subtract(DateLocationEnum type, int num) {
    _datetime = _set(type, num, 0);
    _init();
    return this;
  }

  /// 日期加减操作
  DateTime? _set(DateLocationEnum type, int num, int operation) {
    if (type == DateLocationEnum.year) {
      int _y = int.parse(_year);
      if (operation == 1) {
        _year = (_y + 1).toString();
      } else {
        _year = (_y - 1).toString();
      }
    } else if (type == DateLocationEnum.month) {
      int _y = int.parse(_year);
      int _m = int.parse(_month);
      if (operation == 1) {
        _month = "${_m + num}";
        if (_m + num > 12) {
          int _b = 12 - _m;
          int _a = num - _b;
          _month = _a.toString();
          _year = (_y + 1).toString();
        }
      } else {
        _month = "${_m - num}";
        if (_m - num <= 0) {
          int _b = num - _m;
          int _a = 12 - _b;
          _month = "$_a";
          _year = (_y - 1).toString();
        }
      }
    } else if (type == DateLocationEnum.day ||
        type == DateLocationEnum.hour ||
        type == DateLocationEnum.minute ||
        type == DateLocationEnum.sec) {
      DateTime _d;
      if (type == DateLocationEnum.day) {
        if (operation == 1) {
          _d = dateTime!.add(Duration(days: num));
        } else {
          _d = dateTime!.subtract(Duration(days: num));
        }
      } else if (type == DateLocationEnum.hour) {
        if (operation == 1) {
          _d = dateTime!.add(Duration(hours: num));
        } else {
          _d = dateTime!.subtract(Duration(hours: num));
        }
      } else if (type == DateLocationEnum.minute) {
        if (operation == 1) {
          _d = dateTime!.add(Duration(minutes: num));
        } else {
          _d = dateTime!.subtract(Duration(minutes: num));
        }
      } else if (type == DateLocationEnum.sec) {
        if (operation == 1) {
          _d = dateTime!.add(Duration(seconds: num));
        } else {
          _d = dateTime!.subtract(Duration(seconds: num));
        }
      } else {
        _d = DateTime.now();
      }

      _year = _d.year.toString();
      _month = _d.month.toString();
      _day = _d.day.toString();
      _hour = _d.hour.toString();
      _minute = _d.minute.toString();
      _sec = _d.second.toString();
    }
    return Dayfl("$_year-$_month-$_day $_hour:$_minute:$_sec").dateTime;
  }

  /// 判断日期是否相同
  ///
  /// [dayfl] 比较的对象
  ///
  /// [type] 比较粒度单位 默认毫秒
  bool isSame(
    Dayfl dayfl, [
    DateLocationEnum type = DateLocationEnum.millisecondsSinceEpoch,
  ]) {
    bool _y = dayfl.year == _year;
    bool _mo = dayfl.month == _month;
    bool _d = dayfl.day == _day;
    bool _h = dayfl.hour == _hour;
    bool _m = dayfl.minute == _minute;
    bool _s = dayfl.second == _sec;

    if (type == DateLocationEnum.year) {
      return _y;
    } else if (type == DateLocationEnum.month) {
      return _y && _mo;
    } else if (type == DateLocationEnum.day) {
      return _y && _mo && _d;
    } else if (type == DateLocationEnum.hour) {
      return _y && _mo && _d && _h;
    } else if (type == DateLocationEnum.minute) {
      return _y && _mo && _d && _h && _m;
    } else if (type == DateLocationEnum.sec) {
      return _y && _mo && _d && _h && _m && _s;
    } else {
      return dayfl.dateTime == _datetime;
    }
  }

  /// 时间差 两个时间相差 小时数
  ///
  /// [date] 必须是  Dayfl 或者 DateTime
  Duration difference(var date) {
    if (date is Dayfl) {
      return _datetime!.difference(date.dateTime!);
    } else if (date is DateTime) {
      return _datetime!.difference(date);
    } else {
      return const Duration(hours: 0);
    }
  }

  /// 和DateTime 的 compareTo 方法一样
  ///
  /// [date] 必须是  Dayfl 或者 DateTime
  int compareTo(var date) {
    if (date is Dayfl) {
      return _datetime!.compareTo(date.dateTime!);
    } else {
      return _datetime!.compareTo(date);
    }
  }

  /// 类型推断
  void _object(var datetime, [String formatStr = '']) {
    try {
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
    } catch (e) {
      _datetime = null;
      // ignore: avoid_print
      print("日期解析错误, 请查看格式是否正确！");
    }
  }

  /// 初始化
  void _init() {
    if (_datetime == null) {
      _matchers = {};
      return;
    }
    _year = _datetime!.year.toString();
    _month = _datetime!.month.toString();
    _day = _datetime!.day.toString();
    _hour = _datetime!.hour.toString();
    _minute = _datetime!.minute.toString();
    _sec = _datetime!.second.toString();
    int _h = int.parse(_hour);
    _h = _h > 12 ? _h - 12 : _h;
    _matchers = {
      "YY": _year.substring(2),
      "YYYY": _year,
      "M": _month,
      "MM": _fillZero(_month, 2),
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

  /// 获取当前日期月份天数
  int? get daysInMonth {
    if (_datetime == null) return null;
    int _m = int.parse(_month);
    int _y = int.parse(_year);
    int _m1 = _m + 1;
    if (_m + 1 > 12) {
      _m1 = 1;
      _y += 1;
    }
    Dayfl endTime = Dayfl("$_y-$_m1-1");
    Dayfl startTime = Dayfl("$_year-$_month-1");
    double days =
        (endTime.valueOf! - startTime.valueOf!) / (1000 * 60 * 60 * 24);
    return days.toInt();
  }

  /// 获取week
  ///
  /// return Map num, text
  Map<String, dynamic> getWeek([String locale = '']) {
    if (_datetime == null) return {};
    Map<String, dynamic> map = {'num': null, 'text': ''};
    map['num'] = _datetime!.weekday;
    Locale d = getLocale(locale);
    if (d.weekStart == 0) {
      map['text'] = d.weekAbbreviations[_datetime!.weekday - 1];
    } else if (d.weekStart == 1) {
      map['text'] = d.weekAbbreviations[_datetime!.weekday];
    }
    return map;
  }

  /// 添加语言
  ///
  /// [arg] 语言类
  static bool addLocale(Locale arg) {
    if (_locales
        .where((element) => element.name == arg.name)
        .toList()
        .isNotEmpty) {
      return false;
    }
    _locales.add(arg);
    return true;
  }

  /// 转换成数组
  /// dayfl('2019-01-25').toArray() // [ 2019, 0, 25, 0, 0, 0, 0 ]
  List<int> toArray() {
    if (_datetime == null) return [];
    return [
      int.parse(_year),
      int.parse(_month),
      int.parse(_day),
      int.parse(_hour),
      int.parse(_minute),
      int.parse(second),
    ];
  }

  /// 获取当前使用语言包
  Locale getLocale([String name = '']) {
    String lname = name;
    if (name == '') {
      lname = _localeName;
    }
    List<Locale> _d = _locales.where((e) => e.name == lname).toList();
    if (_d.isNotEmpty) {
      return _d[0];
    }
    _d = _locales.where((e) => e.name == lname).toList();
    return _d[0];
  }

  /// 是否是闰年
  bool? get isLeapYear {
    if (_datetime == null) return null;
    int _y = int.parse(_year);
    if (_y % 400 == 0 || (_y % 4 == 0 && _y % 100 != 0)) return true;
    return false;
  }

  /// 获取时间戳 单位毫秒
  int? get valueOf {
    if (_datetime == null) return null;
    return _datetime!.millisecondsSinceEpoch;
  }

  /// isUtc
  bool? get isUtc {
    if (_datetime == null) return null;
    return _datetime!.isUtc;
  }

  /// 获取时间 返回 DateTime
  DateTime? get dateTime {
    return _datetime;
  }

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

  /// 设置语言
  set setLocale(String name) {
    _localeName = name;
  }
}
