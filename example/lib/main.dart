/*
 * @Author: your name
 * @Date: 2021-11-16 18:47:01
 * @LastEditTime: 2021-11-18 11:28:13
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
  String customFormatParse(
    datetime, {
    String year = '',
    String month = '',
    String day = '',
    String hour = '',
    String minute = '',
    String second = '',
  }) {
    return year;
  }

  @override
  void initState() {
    super.initState();
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
            Text("当前时间 :${Dayfl('2021-06-07').format('DD/MM/YYYY HH:mm:ss')}"),
            Text(
                "指定时间 :${Dayfl('2022-01-06').add(const Duration(days: 2)).format('YYYY-MM-BB HH:mm:ss')}"),
            Text(
                "指定时间 :${Dayfl('26\\1/06 12:05:1', 'YY-M-DD HH:mm:s').format('YYYY-MM-DD H:m:s')}"),
            Text(
                "指定时间 :${Dayfl('26\\1/06 13:05:1', 'YY-M-DD HH:mm:s').format('YYYY-MM-DD a h:m:s')}"),
          ],
        ),
      ),
    );
  }
}
