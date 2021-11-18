/// 解析类
import 'location.dart';

class Format {
  /// 时间字符串
  String timeStr = '';
  /// 解析格式字符串
  String formatStr = '';
  /// datetime
  late DateTime _dateTime = DateTime.now();

  Format({this.timeStr = '', this.formatStr = '', var date}) {
    if (date != null && date is DateTime) {
      _dateTime = date;
    } else if (formatStr.isNotEmpty && formatStr != '') {
      _fetchDateTime();
    }
  }

  /// 返回dateTime
  DateTime getDateTime() {
    return _dateTime;
  }

  /// 根据格式化字符串转换成正确的事件字符串
  void _fetchDateTime() {
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
      _dateTime =
          DateTime.parse("$_year1-$_month1-$_day1 $_hour1:$_minute1:$_sec1");
    } else {
      // 没得格式化字符串
      List<RegExpMatch> d = Location.regexParse.allMatches(timeStr).toList();
      if (d.isNotEmpty) {
        int m = 0;
        if (d[2].group(0) != null) {
          m = int.parse(d[2].group(0).toString()) - 1;
        }
        String ms = "0";
        if (d[7].group(0) != null) {
          ms = d[7].group(0).toString().substring(0, 3);
        }
        int _y = int.parse(d[1].group(0).toString());
        // ignore: non_constant_identifier_names
        int _D = 1;
        if (d[3].group(0) != null) {
          _D = int.parse(d[3].group(0).toString());
        }
        // ignore: non_constant_identifier_names
        int _H = 0;
        if (d[4].group(0) != null) {
          _H = int.parse(d[4].group(0).toString());
        }
        int _m = 0;
        if (d[5].group(0) != null) {
          _m = int.parse(d[5].group(0).toString());
        }
        int _s = 0;
        if (d[6].group(0) != null) {
          _s = int.parse(d[6].group(0).toString());
        }
        _dateTime = DateTime(_y, m, _D, _H, _m, _s, int.parse(ms));
      }
      // _dateTime = DateTime.now();
    }
  }
}
