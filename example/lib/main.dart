/*
 * @Author: your name
 * @Date: 2021-11-16 18:47:01
 * @LastEditTime: 2021-11-22 16:02:22
 * @LastEditors: Please set LastEditors
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \dayfl\example\lib\main.dart
 */

import 'package:flutter/material.dart';
import 'package:dayfl/dayfl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Dayfl d = Dayfl().extend();
  String customFormatParse(Dayfl dayfl) {
    return dayfl.year;
  }

  @override
  void initState() {
    super.initState();
    Dayfl.addLocale(
      Locale(
        name: 'en',
        weekStart: 0,
        monthAbbreviations: [
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
        ],
        monthStart: 0,
        weekAbbreviations: [
          'Mon',
          'Tue',
          'Wed',
          'Thu',
          'Fri',
          'Sat',
          'Sun',
        ],
      ),
    );
    Dayfl.addMatchers('BB', customFormatParse);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("当前时间 :${Dayfl().format()}"),
            Text("指定时间 :${Dayfl('2021-06-07').format('DD/MMM/YYYY HH:mm:ss')}"),
            Text(
                "指定时间加上时间 :${Dayfl('2022-11-06').add(DateLocationEnum.month, 5).format()}"),
            Text(
                "指定时间减去时间 :${Dayfl().subtract(DateLocationEnum.month, 5).format()}"),
            Text(
                "指定时间 :${Dayfl('2021-11-13 09:54:20').format('YYYY-MM-DD H:m:s')}"),
            Text(
                "指定时间 :${Dayfl('26\\1/06 13:05:1', 'YY-M-DD HH:mm:s').format('YYYY-MM-DD a h:m:s')}"),
            Text("是否是闰年: ${Dayfl().isLeapYear}"),
            Text("当前日期月份天数: ${Dayfl().daysInMonth}"),
            Text("指定日期月份天数: ${Dayfl('2021-2-9').daysInMonth}"),
            Text(
                "日期比较： ${Dayfl().isSame(Dayfl())}, \n日期比较指定单位: ${Dayfl().isSame(Dayfl(), DateLocationEnum.sec)}"),
            Text(
                "指定语言: en:${Dayfl().format("YYYY-MMM-WW", 'en')},  cn: ${Dayfl().format("YYYY-MMM-WW")}")
          ],
        ),
      ),
    );
  }
}
