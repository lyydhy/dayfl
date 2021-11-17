/*
 * @Author: your name
 * @Date: 2021-11-16 11:48:22
 * @LastEditTime: 2021-11-17 08:35:38
 * @LastEditors: Please set LastEditors
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \flutter_dayjs\lib\dayjs.dart
 */

import 'format.dart';

class Dayfl {
  late DateTime _datetime;

  Dayfl([var datetime, String formatStr = '']) {
    _object(datetime, formatStr);
  }

  /// 设置秒数
  void second(int num) {
    if (num > 60 || num < 0) return;
  }

  /// 之前
  ///
  /// [date] 接收时间可以是 Dayfl 或者 时间字符串 两者都不是 return false;
  ///
  /// [unit] 第二个参数 指定单位比较 可选 year, month, day, hour,minute, second
  bool isBefore(var date, [String unit = '']) {
    if (date is Dayfl) {
      return _datetime.isBefore(date.getDateTime());
    } else if (date is String) {
      return false;
    }

    return false;
  }

  /// 之后
  ///
  /// [date] 接收时间可以是 Dayfl 或者 时间字符串 两者都不是 return false;
  ///
  /// [unit] 第二个参数 指定单位比较 可选 year, month, day, hour,minute, second
  bool isAfter(var date, [String unit = '']) {
    if (date is Dayfl) {
      return _datetime.isAfter(date.getDateTime());
    } else if (date is String) {
      return false;
    }

    return false;
  }

  /// 获取时间 返回 DateTime
  DateTime getDateTime() {
    return _datetime;
  }

  /// 获取时间搓 单位毫秒
  int valueOf() {
    return _datetime.millisecondsSinceEpoch;
  }

  /// 格式化
  String format([String formatStr = '']) {
    if (formatStr.isEmpty) {
      return Format(date: _datetime).value();
    }
    return Format(date: _datetime, formatStr: formatStr).value();
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
      if (formatStr.isEmpty && formatStr != '') {
        _datetime = DateTime.parse(datetime);
      } else {
        _datetime =
            Format(timeStr: datetime, formatStr: formatStr).getDateTime();
      }
    } else if (datetime is DateTime) {
      _datetime = datetime;
    } else if (datetime is int) {
      _datetime = DateTime(datetime);
    } else {
      _datetime = DateTime.now();
    }
  }
}
