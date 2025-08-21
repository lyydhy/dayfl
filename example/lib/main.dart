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
    return dayfl.year.toString();
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
            Text("指定时间 :${Dayfl('2021-06-01').format('YYYY-MM-DD HH:mm:ss')}"),
            Text(
                "指定时间加上时间 :${Dayfl('2022-11-06').add(DateLocationEnum.month, 5).format()}"),
            Text(
                "指定时间减去时间 :${Dayfl().subtract(DateLocationEnum.month, 5).format()}"),
            Text(
                "指定时间 :${Dayfl('2021-11-13 09:54:20').format('YYYY-MM-DD H:m:s')}"),
            Text(
                "指定时间 :${Dayfl('26/1/06 13:05:1', 'YY/M/DD HH:mm:s').format('YYYY-MM-DD a h:m:s')}"),
            Text("是否是闰年: ${Dayfl('2022-01-01').year}"),
            Text("当前日期月份天数: ${Dayfl().daysInMonth}"),
            Text("指定日期月份天数: ${Dayfl('2021-02-01').daysInMonth}"),
            Text(
                "日期比较： ${Dayfl().isSame(Dayfl())}, \n日期比较指定单位: ${Dayfl().isSame(Dayfl(), DateLocationEnum.sec)}"),
            Text(
                "指定语言: en:${Dayfl().format("YYYY-MMM-WW", 'en')},  cn: ${Dayfl().format("YYYY-MMM-WW")}"),
            Text("获取毫秒: ${Dayfl().valueOf}"),
            Text(
                "之前：${Dayfl().isBefore(Dayfl("2022-12-01"))}, 相反: ${Dayfl("2022-12-01").isBefore(Dayfl())}"),
            Text(
                "之后：${Dayfl().isAfter(Dayfl("2022-12-01"))}, 相反: ${Dayfl("2022-12-01").isAfter(Dayfl())}"),
            Text(
                "isDayFormat: ${Dayfl().subtract(DateLocationEnum.hour, 15).format('', '', true)}"),
                Text("setMonth: ${Dayfl().setMonth(1).format()}"),
            Text("链式调用: ${Dayfl().setYear(2025).setMonth(12).setDay(25).setHour(18).setMinute(30).format('YYYY-MM-DD HH:mm')}")
          ],
        ),
      ),  
    );
  }
}
