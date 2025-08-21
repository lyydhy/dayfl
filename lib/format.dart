/// 解析类
import 'location.dart';

class Format {
  /// 时间字符串
  String timeStr = '';

  /// 解析格式字符串
  String formatStr = '';

  /// datetime
  DateTime? _dateTime;

  /// 构造方法
  Format({this.timeStr = '', this.formatStr = ''}) {
    _fetchDateTime();
  }

  /// 返回dateTime
  DateTime get dateTime {
    if (_dateTime == null) {
      throw StateError('日期时间解析失败，无法获取有效的DateTime对象');
    }
    return _dateTime!;
  }

  /// 根据格式化字符串转换成正确的事件字符串
  void _fetchDateTime() {
    try {
      if (formatStr != "" && formatStr.isNotEmpty) {
        // 有格式化字符串
        String _year1 = DateTime.now().year.toString();
        String _month1 = '01';
        String _day1 = '01';
        String _hour1 = '00';
        String _minute1 = '00';
        String _sec1 = '00';
        RegExp ref = RegExp(r"-|:|\s|\/|\\");
        List<String> _forList = formatStr.split(ref);
        List<String> _dateList = timeStr.split(ref);
        
        // 确保两个列表长度匹配
        if (_forList.length != _dateList.length) {
          throw FormatException('格式字符串与日期字符串不匹配: 格式"$formatStr"需要${_forList.length}个部分，但日期"$timeStr"只有${_dateList.length}个部分');
        }
        
        List.generate(_forList.length, (index) {
          
          String _cur = _forList[index];
          if (_cur.contains(r"Y")) {
            if (_cur.length == 4) {
              _year1 = _dateList[index];
            } else if (_cur.length == 2) {
              _year1 = _year1.substring(0, 2) + _dateList[index];
            }
          }
          if (_cur.contains(r"M")) {
            if (_cur.length == 3) {
            } else if (_cur.length == 2) {
              _month1 = _dateList[index];
            } else {
              _month1 = "0" + _dateList[index];
            }
          }
          if (_cur.contains(r"D")) {
            if (_cur.length == 2) {
              _day1 = _dateList[index];
            } else {
              _day1 = "0" + _dateList[index];
            }
          }
          if (_cur.contains(r"H")) {
            if (_cur.length == 2) {
              _hour1 = _dateList[index];
            } else {
              _hour1 = "0" + _dateList[index];
            }
          }
          if (_cur.contains(r"m")) {
            if (_cur.length == 2) {
              _minute1 = _dateList[index];
            } else {
              _minute1 = "0" + _dateList[index];
            }
          }
          if (_cur.contains(r"s")) {
            if (_cur.length == 2) {
              _sec1 = _dateList[index];
            } else {
              _sec1 = "0" + _dateList[index];
            }
          }
        });
        // print("事件 $_year1-$_month1-$_day1 $_hour1:$_minute1:$_sec1");
        try {
          _dateTime =
              DateTime.parse("$_year1-$_month1-$_day1 $_hour1:$_minute1:$_sec1");
        } catch (e) {
          throw FormatException('日期解析失败: 无法解析日期字符串 "$_year1-$_month1-$_day1 $_hour1:$_minute1:$_sec1"');
        }
      } else {
        // 没得格式化字符串
        try {
          List<RegExpMatch> d = Location.regexParse.allMatches(timeStr).toList();

          if (d.isNotEmpty) {
            int m = 0;
            if (d[0].group(2) != null) {
              m = int.parse(d[0].group(2).toString());
            }

            String ms = "0";
            if (d[0].group(7) != null) {
              String msStr = d[0].group(7).toString();
              ms = msStr.length >= 3 ? msStr.substring(0, 3) : msStr;
            }
            int _y = int.parse(d[0].group(1).toString());
            // ignore: non_constant_identifier_names
            int _D = 1;
            if (d[0].group(3) != null) {
              _D = int.parse(d[0].group(3).toString());
              // print(_D);
            }
            // ignore: non_constant_identifier_names
            int _H = 0;
            if (d[0].group(4) != null) {
              _H = int.parse(d[0].group(4).toString());
            }
            int _m = 0;
            if (d[0].group(5) != null) {
              _m = int.parse(d[0].group(5).toString());
            }
            int _s = 0;
            if (d[0].group(6) != null) {
              _s = int.parse(d[0].group(6).toString());
            }

            _dateTime = DateTime(_y, m, _D, _H, _m, _s, int.parse(ms));
          } else {
            throw FormatException('无法解析日期字符串: $timeStr');
          }
        } catch (e) {
          throw FormatException('日期解析失败: 无法解析日期字符串 "$timeStr"');
        }
      }
    } catch (e) {
      // 如果e已经是FormatException，直接重新抛出，避免嵌套
      if (e is FormatException) {
        rethrow;
      }
      throw FormatException('格式化处理失败: $e');
    }
  }
}
