/// Dayfl
import 'format.dart';
import 'location.dart';
export 'location.dart';
// typedef pluginFunc = void Function(Dayfl dayfl);

/// 回调
typedef MatchersFunc = String Function(Dayfl dayfl);

/// dayFormatFunc
typedef DayFormatFunc = String Function(Dayfl dayfl);

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

  /// 格式化匹配器
  Map<String, String> _matchers = {};

  /// locale
  static String _localeName = 'cn';

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
        formatText: {
          'ltTenSec': '刚刚',
          'ltDay': '天前',
          'ltMonth': '月前',
          'yesterday': '昨天',
          'yesteryear': '去年'
        }),
    Locale(
        name: 'en',
        monthStart: 0,
        monthAbbreviations: [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        ],
        weekStart: 0,
        weekAbbreviations: [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ],
        formatText: {
          'ltTenSec': 'just now',
          'ltDay': 'days ago',
          'ltMonth': 'months ago',
          'yesterday': 'yesterday',
          'yesteryear': 'last year'
        }),
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
    if (_datetime == null || !_isValidDateParam(date)) return false;
    
    if (date is Dayfl) {
      return _datetime!.isBefore(date.dateTime!);
    } else if (date is DateTime) {
      return _datetime!.isBefore(date);
    } else if (date is String) {
      DateTime? tempDate = _convertToSafeDateTime(date);
      return tempDate != null ? _datetime!.isBefore(tempDate) : false;
    }
    return false;
  }

  /// 之后
  ///
  /// [date] 接收时间可以是 Dayfl|时间字符串|DateTime 三者都不是 return false;
  bool isAfter(var date) {
    if (_datetime == null || !_isValidDateParam(date)) return false;
    
    if (date is Dayfl) {
      return _datetime!.isAfter(date.dateTime!);
    } else if (date is DateTime) {
      return _datetime!.isAfter(date);
    } else if (date is String) {
      DateTime? tempDate = _convertToSafeDateTime(date);
      return tempDate != null ? _datetime!.isAfter(tempDate) : false;
    }

    return false;
  }

  /// 格式化
  ///
  /// [formatStr] 格式化字符串
  ///
  /// [locale] 语言包
  ///
  /// [dayFormat] 文字格式化  小于10s= 刚刚  [今年] 当月几天前 往月几月前  [去年] 去年 'MM-DD HH:mm:ss [默认字符串] dayFormat 可以传bool 类型 也可以传一个带参的Function 自定义实现你的功能 默认false
  String format([
    String formatStr = Location.defaultFormatStr,
    String locale = '',
    var dayFormat = false,
  ]) {
    try {
      if (formatStr == '') formatStr = Location.defaultFormatStr;
      if (_datetime == null) return '';
      if (locale == '') {
        locale = _localeName;
      }
      Locale _locale = getLocale(locale);
    if (!_matchers.containsKey("W")) {
      // 优化：直接使用已获取的_locale，避免重复调用getLocale
      Map<String, dynamic> weekInfo = _getWeekInfo(_locale);
      _matchers.addAll({
        "W": weekInfo['num'].toString(),
        "WW": weekInfo['text'],
      });
    }
    if (!_matchers.containsKey("MMM")) {
      int monthIndex = month;
      if (_locale.monthStart == 0) {
        // 确保索引在有效范围内
        if (monthIndex >= 1 && monthIndex <= _locale.monthAbbreviations.length) {
          _matchers.addAll({"MMM": _locale.monthAbbreviations[monthIndex - 1]});
        }
      } else if (_locale.monthStart == 1) {
        // 确保索引在有效范围内
        if (monthIndex >= 0 && monthIndex < _locale.monthAbbreviations.length) {
          _matchers.addAll({"MMM": _locale.monthAbbreviations[monthIndex]});
        }
      }
    }
    String s = formatStr;
    var sortedKeys = _matchers.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
    for (var key in sortedKeys) {
      if (s.contains(key)) {
        s = s.replaceAll(key, _matchers[key]!);
      }
    }

    if (dayFormat is bool && dayFormat) {
      Dayfl newDate = Dayfl();
      if (newDate.isSame(this, DateLocationEnum.year) &&
          newDate.isAfter(this)) {
        int timeX = newDate.valueOf! - valueOf!;
        if (timeX < 10000) {
          s = _locale.formatText['ltTenSec'] ?? '';
        } else if (newDate.isSame(this, DateLocationEnum.month)) {
          timeX = newDate.difference(this).inHours;
          timeX = (timeX / 24).truncate();
          s = '$timeX' + (_locale.formatText['ltDay'] ?? '');
          if (newDate.difference(this).inHours - newDate.hour > 0) {
            s = _locale.formatText['yesterday'] ?? '';
          }
        } else {
          timeX = newDate.month - month;
          s = '$timeX' + (_locale.formatText['ltMonth'] ?? '');
        }
      } else if (newDate.isAfter(this)) {
        int timeX = newDate.year - year;
        if (timeX > 0 && timeX < 2) {
          s = (_locale.formatText['yesteryear'] ?? '') +
              ' ${format('MM-DD HH:mm:ss')}';
        }
      }
    } else if (dayFormat is DayFormatFunc) {
      s = dayFormat(this);
    }
    return s;
    } catch (e) {
      // 格式化失败时返回默认格式
      return _datetime?.toString() ?? '';
    }
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

  /// Manipulate the Dayfl object to the end of a unit of time.
  Dayfl endOf(DateLocationEnum type) {
    if (_datetime == null) {
      throw StateError('当前Dayfl对象包含无效的日期时间');
    }
    switch (type) {
      case DateLocationEnum.year:
        _datetime = DateTime(year, 12, 31, 23, 59, 59, 999);
        break;
      case DateLocationEnum.month:
        final days = daysInMonth;
        if (days == null) {
          throw StateError('无法获取当前月份的天数');
        }
        _datetime = DateTime(year, month, days, 23, 59, 59, 999);
        break;
      case DateLocationEnum.day:
        _datetime = DateTime(year, month, day, 23, 59, 59, 999);
        break;
      case DateLocationEnum.hour:
        _datetime = DateTime(year, month, day, hour, 59, 59, 999);
        break;
      case DateLocationEnum.minute:
        _datetime = DateTime(year, month, day, hour, minute, 59, 999);
        break;
      case DateLocationEnum.sec:
        _datetime = DateTime(year, month, day, hour, minute, second, 999);
        break;
      default:
        // For millisecondsSinceEpoch and any other unhandled cases, do nothing.
        break;
    }
    _init();
    return this;
  }

  /// 日期加减操作
  DateTime? _set(DateLocationEnum type, int num, int operation) {
    // 参数验证
    if (num < 0) {
      throw ArgumentError('操作数值不能为负数');
    }
    if (operation != 0 && operation != 1) {
      throw ArgumentError('操作类型只能是0(减法)或1(加法)');
    }
    if (_datetime == null) {
      throw StateError('当前Dayfl对象包含无效的日期时间，无法进行日期操作');
    }
    
    try {
    
    if (type == DateLocationEnum.year) {
      int _y = year;
      if (operation == 1) {
        _year = (_y + num).toString();
      } else {
        _year = (_y - num).toString();
      }
      // 验证年份范围
      int newYear = int.parse(_year);
      if (newYear < 1 || newYear > 9999) {
        throw RangeError('年份必须在1-9999之间');
      }
    } else if (type == DateLocationEnum.month) {
      int _y = year;
      int _m = month;
      if (operation == 1) {
        // 加月份
        int totalMonths = _m + num;
        while (totalMonths > 12) {
          totalMonths -= 12;
          _y += 1;
        }
        _month = totalMonths.toString();
        _year = _y.toString();
      } else {
        // 减月份
        int totalMonths = _m - num;
        while (totalMonths <= 0) {
          totalMonths += 12;
          _y -= 1;
        }
        _month = totalMonths.toString();
        _year = _y.toString();
      }
    } else if (type == DateLocationEnum.day ||
        type == DateLocationEnum.hour ||
        type == DateLocationEnum.minute ||
        type == DateLocationEnum.sec) {
      // 使用Map简化Duration操作的重复代码
      final durationMap = {
        DateLocationEnum.day: Duration(days: num),
        DateLocationEnum.hour: Duration(hours: num),
        DateLocationEnum.minute: Duration(minutes: num),
        DateLocationEnum.sec: Duration(seconds: num),
      };
      
      Duration duration = durationMap[type] ?? Duration.zero;
      DateTime _d = operation == 1 
          ? dateTime!.add(duration)
          : dateTime!.subtract(duration);

      _year = _d.year.toString();
      _month = _d.month.toString();
      _day = _d.day.toString();
      _hour = _d.hour.toString();
      _minute = _d.minute.toString();
      _sec = _d.second.toString();
    }
    // 直接创建DateTime对象，避免创建临时Dayfl对象
    _datetime = DateTime(
      int.parse(_year),
      int.parse(_month),
      int.parse(_day),
      int.parse(_hour),
      int.parse(_minute),
      int.parse(_sec)
    );
    return _datetime;
    } catch (e) {
      throw StateError('日期操作失败: $e');
    }
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
    // 使用Map简化重复的比较逻辑
    final comparisons = {
      DateLocationEnum.year: () => dayfl.year == year,
      DateLocationEnum.month: () => dayfl.year == year && dayfl.month == month,
      DateLocationEnum.day: () => dayfl.year == year && dayfl.month == month && dayfl.day == day,
      DateLocationEnum.hour: () => dayfl.year == year && dayfl.month == month && dayfl.day == day && dayfl.hour == hour,
      DateLocationEnum.minute: () => dayfl.year == year && dayfl.month == month && dayfl.day == day && dayfl.hour == hour && dayfl.minute == minute,
      DateLocationEnum.sec: () => dayfl.year == year && dayfl.month == month && dayfl.day == day && dayfl.hour == hour && dayfl.minute == minute && dayfl.second == second,
    };
    
    return comparisons[type]?.call() ?? (dayfl.dateTime == _datetime);
  }

  /// 通用方法：将输入参数转换为DateTime对象，减少重复的类型检查
  DateTime _extractDateTime(var date) {
    if (_datetime == null) {
      throw StateError('当前Dayfl对象包含无效的日期时间');
    }
    
    if (date is Dayfl) {
      if (date.dateTime == null) {
        throw ArgumentError('传入的Dayfl对象包含无效的日期时间');
      }
      return date.dateTime!;
    } else if (date is DateTime) {
      return date;
    } else {
      throw ArgumentError('参数必须是Dayfl或DateTime类型');
    }
  }

  /// 时间差 两个时间相差 小时数
  ///
  /// [date] 必须是  Dayfl 或者 DateTime
  Duration difference(var date) {
    DateTime targetDateTime = _extractDateTime(date);
    return _datetime!.difference(targetDateTime);
  }

  /// 计算两个时间的差值，支持自定义单位
  ///
  /// [date] 必须是 Dayfl 或者 DateTime
  /// [unit] 时间单位，支持年、月、日、时、分、秒
  /// 返回指定单位的时间差值（整数）
  int diffIn(var date, DateLocationEnum unit) {
    DateTime targetDateTime = _extractDateTime(date);
    Duration diff = _datetime!.difference(targetDateTime);
    
    switch (unit) {
      case DateLocationEnum.year:
        // 计算年份差
        int yearDiff = year - (date is Dayfl ? date.year : targetDateTime.year);
        return yearDiff;
      case DateLocationEnum.month:
        // 计算月份差
        int currentYear = year;
        int currentMonth = month;
        int targetYear = date is Dayfl ? date.year : targetDateTime.year;
        int targetMonth = date is Dayfl ? date.month : targetDateTime.month;
        
        // 计算总月份差
        int totalMonthsDiff = (currentYear - targetYear) * 12 + (currentMonth - targetMonth);
        return totalMonthsDiff;
      case DateLocationEnum.day:
        return diff.inDays;
      case DateLocationEnum.hour:
        return diff.inHours;
      case DateLocationEnum.minute:
        return diff.inMinutes;
      case DateLocationEnum.sec:
        return diff.inSeconds;
      default:
        // 默认返回毫秒差
        return diff.inMilliseconds;
    }
  }

  /// 和DateTime 的 compareTo 方法一样
  ///
  /// [date] 必须是  Dayfl 或者 DateTime
  int compareTo(var date) {
    DateTime targetDateTime = _extractDateTime(date);
    return _datetime!.compareTo(targetDateTime);
  }

  /// 类型推断
  void _object(var datetime, [String formatStr = '']) {
    try {
      if (datetime is Dayfl) {
        if (datetime.dateTime == null) {
          throw ArgumentError('传入的Dayfl对象包含无效的日期时间');
        }
        _datetime = datetime.dateTime;
      } else if (datetime is String) {
        if (datetime.trim().isEmpty) {
          throw ArgumentError('日期字符串不能为空');
        }
        _datetime = Format(timeStr: datetime, formatStr: formatStr).dateTime;
      } else if (datetime is DateTime) {
        _datetime = datetime;
      } else if (datetime is int) {
        // 处理时间戳，支持秒和毫秒
        if (datetime > 1000000000000) {
          // 毫秒时间戳
          _datetime = DateTime.fromMillisecondsSinceEpoch(datetime);
        } else {
          // 秒时间戳或年份
          if (datetime > 1000000000) {
            _datetime = DateTime.fromMillisecondsSinceEpoch(datetime * 1000);
          } else {
            // 当作年份处理
            if (datetime < 1 || datetime > 9999) {
              throw RangeError('年份必须在1-9999之间');
            }
            _datetime = DateTime(datetime);
          }
        }
      } else if (datetime == null) {
        _datetime = DateTime.now();
      } else {
        throw ArgumentError('不支持的日期时间类型: ${datetime.runtimeType}');
      }
      _init();
    } catch (e) {
      _datetime = null;
      // ignore: avoid_print
      print("日期解析错误: $e");
      rethrow; // 重新抛出异常以便调用者处理
    }
  }

  /// 初始化
  void _init() {
    if (_datetime == null) {
      _matchers = {};
      return;
    }
    // 优化：缓存数值，减少重复转换
    int yearInt = _datetime!.year;
    int monthInt = _datetime!.month;
    int dayInt = _datetime!.day;
    int hourInt = _datetime!.hour;
    int minuteInt = _datetime!.minute;
    int secInt = _datetime!.second;
    int millisecondInt = _datetime!.millisecond;

    _year = yearInt.toString();
    _month = monthInt.toString();
    _day = dayInt.toString();
    _hour = hourInt.toString();
    _minute = minuteInt.toString();
    _sec = secInt.toString();
    String _millisecond = millisecondInt.toString();
    
    // 修复12小时制转换逻辑
    int _h = hourInt;
    if (_h == 0) {
      _h = 12; // 午夜0点显示为12点
    } else if (_h > 12) {
      _h = _h - 12; // 下午时间转换为12小时制
    }
    // 12点保持为12点
    
    String _hStr = _h.toString();
    bool isAM = hourInt < 12;
    
    _matchers = {
      "YY": _year.substring(2),
      "YYYY": _year,
      "M": _month,
      "MM": _fillZero(_month, 2),
      "D": _day,
      "DD": _fillZero(_day, 2),
      "H": _hour,
      "HH": _fillZero(_hour, 2),
      "h": _hStr,
      "hh": _fillZero(_hStr, 2),
      "m": _minute,
      "mm": _fillZero(_minute, 2),
      "s": _sec,
      "ss": _fillZero(_sec, 2),
      "A": isAM ? 'AM' : 'PM',
      "a": isAM ? 'am' : 'pm',
      "SSS": _fillZero(_millisecond, 3),
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
    if (str.length >= length) {
      return str;
    }
    // 优化：使用padLeft方法，更高效
    return str.padLeft(length, '0');
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
    int _m = month;
    int _y = year;
    // 优化：直接使用DateTime构造函数计算月份天数，避免创建临时Dayfl对象
    // DateTime(year, month + 1, 0) 会返回上个月的最后一天
    return DateTime(_y, _m + 1, 0).day;
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
      int index = _datetime!.weekday - 1;
      if (index >= 0 && index < d.weekAbbreviations.length) {
        map['text'] = d.weekAbbreviations[index];
      }
    } else if (d.weekStart == 1) {
      int index = _datetime!.weekday;
      if (index >= 0 && index < d.weekAbbreviations.length) {
        map['text'] = d.weekAbbreviations[index];
      }
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
      year,
      month,
      day,
      hour,
      minute,
      second,
    ];
  }

  /// 内部辅助方法：验证日期参数的通用逻辑
  bool _isValidDateParam(var date) {
    if (date is Dayfl) {
      return date.dateTime != null;
    } else if (date is DateTime) {
      return true;
    } else if (date is String) {
      return date.trim().isNotEmpty;
    }
    return false;
  }

  /// 内部辅助方法：安全地将字符串转换为DateTime对象
  /// 优化：直接返回DateTime而不是Dayfl对象，减少对象创建开销
  DateTime? _convertToSafeDateTime(String dateStr) {
    try {
      if (dateStr.trim().isEmpty) return null;
      return Format(timeStr: dateStr).dateTime;
    } catch (e) {
      return null;
    }
  }

  /// 内部辅助方法：获取周信息，避免重复调用getLocale
  Map<String, dynamic> _getWeekInfo(Locale locale) {
    if (_datetime == null) {
      return {'num': 0, 'text': ''};
    }
    
    int weekday = _datetime!.weekday;
    int weekStart = locale.weekStart;
    int adjustedWeekday = (weekday - weekStart) % 7;
    if (adjustedWeekday < 0) adjustedWeekday += 7;
    
    String weekText = '';
    if (adjustedWeekday < locale.weekAbbreviations.length) {
      weekText = locale.weekAbbreviations[adjustedWeekday];
    }
    
    return {
      'num': adjustedWeekday,
      'text': weekText,
    };
  }

  /// 获取当前使用语言包
  Locale getLocale([String name = '']) {
    String lname = name;
    if (name == '') {
      lname = _localeName;
    }
    
    // 确保_locales不为空
    if (_locales.isEmpty) {
      throw StateError('没有可用的语言包，请先添加至少一个语言包');
    }
    
    List<Locale> _d = _locales.where((e) => e.name == lname).toList();
    if (_d.isNotEmpty) {
      return _d[0];
    }
    // 如果找不到指定语言，返回默认语言（中文）
    return _locales[0];
  }

  /// 是否是闰年
  bool? get isLeapYear {
    if (_datetime == null) return null;
    int _y = year;
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

  /// 获取年 int
  int get year => _datetime?.year ?? 0;

  /// 通用setter辅助方法，减少代码重复
  void _updateDateTime({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    if (_datetime == null) {
      throw StateError('当前Dayfl对象包含无效的日期时间');
    }
    
    int newYear = year ?? _datetime!.year;
    int newMonth = month ?? _datetime!.month;
    int newDay = day ?? _datetime!.day;
    int newHour = hour ?? _datetime!.hour;
    int newMinute = minute ?? _datetime!.minute;
    int newSecond = second ?? _datetime!.second;
    
    // 处理月份变更时的日期溢出问题
    if (month != null && day == null) {
      int maxDayInMonth = DateTime(newYear, newMonth + 1, 0).day;
      newDay = _datetime!.day > maxDayInMonth ? maxDayInMonth : _datetime!.day;
    }
    
    _datetime = DateTime(
      newYear,
      newMonth,
      newDay,
      newHour,
      newMinute,
      newSecond,
      _datetime!.millisecond,
      _datetime!.microsecond,
    );
    _init();
  }

  /// 设置年份
  /// [value] 年份值，范围1-9999
  /// 返回当前Dayfl对象以支持链式调用
  set year(int value) {
    if (value < 1 || value > 9999) {
      throw RangeError('年份必须在1-9999之间');
    }
    _updateDateTime(year: value);
  }

  /// 获取月 int
  int get month => _datetime?.month ?? 0;

  /// 设置月份
  /// [value] 月份值，范围1-12
  /// 返回当前Dayfl对象以支持链式调用
  set month(int value) {
    if (value < 1 || value > 12) {
      throw RangeError('月份必须在1-12之间');
    }
    _updateDateTime(month: value);
  }

  /// 获取日 int
  int get day => _datetime?.day ?? 0;

  /// 设置日期
  /// [value] 日期值，范围1-31（根据月份自动调整）
  /// 返回当前Dayfl对象以支持链式调用
  set day(int value) {
    if (_datetime == null) {
      throw StateError('当前Dayfl对象包含无效的日期时间，无法设置日期');
    }
    int maxDayInMonth = DateTime(_datetime!.year, _datetime!.month + 1, 0).day;
    if (value < 1 || value > maxDayInMonth) {
      throw RangeError('日期必须在1-$maxDayInMonth之间（当前月份）');
    }
    _updateDateTime(day: value);
  }

  /// 获取小时 int
  int get hour => _datetime?.hour ?? 0;

  /// 设置小时
  /// [value] 小时值，范围0-23
  /// 返回当前Dayfl对象以支持链式调用
  set hour(int value) {
    if (value < 0 || value > 23) {
      throw RangeError('小时必须在0-23之间');
    }
    _updateDateTime(hour: value);
  }

  /// 获取分钟 int
  int get minute => _datetime?.minute ?? 0;

  /// 设置分钟
  /// [value] 分钟值，范围0-59
  /// 返回当前Dayfl对象以支持链式调用
  set minute(int value) {
    if (value < 0 || value > 59) {
      throw RangeError('分钟必须在0-59之间');
    }
    _updateDateTime(minute: value);
  }

  /// 获取秒 int
  int get second => _datetime?.second ?? 0;

  /// 设置秒
  /// [value] 秒值，范围0-59
  /// 返回当前Dayfl对象以支持链式调用
  set second(int value) {
    if (value < 0 || value > 59) {
      throw RangeError('秒必须在0-59之间');
    }
    _updateDateTime(second: value);
  }

  /// 设置语言
  set setLocale(String name) {
    _localeName = name;
  }

  /// 设置年份（方法调用形式，支持链式调用）
  /// [value] 年份值，范围1-9999
  /// 返回当前Dayfl对象以支持链式调用
  Dayfl setYear(int value) {
    year = value;
    return this;
  }

  /// 设置月份（方法调用形式，支持链式调用）
  /// [value] 月份值，范围1-12
  /// 返回当前Dayfl对象以支持链式调用
  Dayfl setMonth(int value) {
    month = value;
    return this;
  }

  /// 设置日期（方法调用形式，支持链式调用）
  /// [value] 日期值，范围1-31（根据月份自动调整）
  /// 返回当前Dayfl对象以支持链式调用
  Dayfl setDay(int value) {
    day = value;
    return this;
  }

  /// 设置小时（方法调用形式，支持链式调用）
  /// [value] 小时值，范围0-23
  /// 返回当前Dayfl对象以支持链式调用
  Dayfl setHour(int value) {
    hour = value;
    return this;
  }

  /// 设置分钟（方法调用形式，支持链式调用）
  /// [value] 分钟值，范围0-59
  /// 返回当前Dayfl对象以支持链式调用
  Dayfl setMinute(int value) {
    minute = value;
    return this;
  }

  /// 设置秒（方法调用形式，支持链式调用）
  /// [value] 秒值，范围0-59
  /// 返回当前Dayfl对象以支持链式调用
  Dayfl setSecond(int value) {
    second = value;
    return this;
  }
}
