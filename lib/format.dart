/*
 * @Author: your name
 * @Date: 2021-11-16 18:48:03
 * @LastEditTime: 2021-11-16 18:48:04
 * @LastEditors: Please set LastEditors
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \workProject\dayfl\lib\format.dart
 */
class Format {
  String timeStr = '';
  String formatStr = '';
  late DateTime _dateTime = DateTime.now();
  String _year = '';
  String _month = '';
  String _day = '';
  String _hour = '';
  String _minute = '';
  String _sec = '';
  Format({this.timeStr = '', this.formatStr = '', var date}) {
    if (date != null && date is DateTime) {
      _dateTime = date;
    } else if (formatStr.isNotEmpty && formatStr != '') {
      _fetchDateTime();
    }
  }

  DateTime getDateTime() {
    return _dateTime;
  }

  String value() {
    _fetchData();
    if (formatStr.isEmpty) {
      return '$_year-${_fillZero(_month, 2)}-${_fillZero(_day, 2)} ${_fillZero(_hour, 2)}:${_fillZero(_minute, 2)}:$_sec';
    }
    String _newDate = formatStr;
    if (RegExp(r"YYYY").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"YYYY", _year);
    } else if (RegExp(r"YY").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"YY", _year.substring(2));
    }
    if (RegExp(r"MMM").hasMatch(formatStr)) {
      _newDate =
          _newDate.replaceAll(r"MMM", _monthToEnglishAbbreviations(_month));
    } else if (RegExp(r"MM").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"MM", _fillZero(_month, 2));
    } else if (RegExp(r"M").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"M", _month);
    }
    if (RegExp(r"DD").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"DD", _fillZero(_day, 2));
    } else if (RegExp(r"D").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"D", _day);
    }

    if (RegExp(r"HH").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"HH", _fillZero(_hour, 2));
    } else if (RegExp(r"H").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"H", _day);
    }

    if (RegExp(r"mm").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"mm", _fillZero(_minute, 2));
    } else if (RegExp(r"m").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"m", _minute);
    }

    if (RegExp(r"ss").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"ss", _fillZero(_sec, 2));
    } else if (RegExp(r"s").hasMatch(formatStr)) {
      _newDate = _newDate.replaceAll(r"s", _sec);
    }

    return _newDate;
  }

  /// 根据格式化字符串转换成正确的事件字符串
  void _fetchDateTime() {
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
        if (_cur.length == 2) {
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
  }

  // 刷新数据
  void _fetchData() {
    _year = _dateTime.year.toString();
    _month = _dateTime.month.toString();
    _day = _dateTime.day.toString();
    _hour = _dateTime.hour.toString();
    _minute = _dateTime.minute.toString();
    _sec = _dateTime.second.toString();
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

  // month转英文缩写
  String _monthToEnglishAbbreviations(String month) {
    List<String> _list = [
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
    return _list[int.parse(month)];
  }
}
