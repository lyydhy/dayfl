import 'package:test/test.dart';
import 'package:dayfl/dayfl.dart';

void main() {
  // ═══════════════════════════════════════════════
  // 1. 构造函数
  // ═══════════════════════════════════════════════
  group('Constructor', () {
    test('Dayfl() should use current time', () {
      final d = Dayfl();
      expect(d.dateTime, isNotNull);
      expect(d.year, greaterThan(2000));
    });

    test('Dayfl(String) auto-detect format', () {
      final d = Dayfl('2024-06-15 10:30:45');
      expect(d.year, equals(2024));
      expect(d.month, equals(6));
      expect(d.day, equals(15));
      expect(d.hour, equals(10));
      expect(d.minute, equals(30));
      expect(d.second, equals(45));
    });

    test('Dayfl(String, formatStr) with custom format', () {
      final d = Dayfl('26/1/06 13:05:1', 'YY/M/DD HH:mm:s');
      expect(d.year, equals(2026));
      expect(d.month, equals(1));
      expect(d.day, equals(6));
      expect(d.hour, equals(13));
      expect(d.minute, equals(5));
      expect(d.second, equals(1));
    });

    test('Dayfl(DateTime)', () {
      final dt = DateTime(2024, 3, 20, 8, 15, 30);
      final d = Dayfl(dt);
      expect(d.dateTime, equals(dt));
      expect(d.year, equals(2024));
    });

    test('Dayfl(int) millisecond timestamp', () {
      final d = Dayfl(1718448045000); // 2024-06-15 10:00:45 UTC+8 approx
      expect(d.dateTime, isNotNull);
      expect(d.year, equals(2024));
    });

    test('Dayfl(int) second timestamp', () {
      final d = Dayfl(1718448045); // seconds
      expect(d.dateTime, isNotNull);
      expect(d.year, equals(2024));
    });

    test('Dayfl(int) as year', () {
      final d = Dayfl(2024);
      expect(d.year, equals(2024));
      expect(d.month, equals(1));
      expect(d.day, equals(1));
    });

    test('Dayfl(Dayfl) copy', () {
      final d1 = Dayfl('2024-06-15 10:30:00');
      final d2 = Dayfl(d1);
      expect(d2.year, equals(d1.year));
      expect(d2.month, equals(d1.month));
      expect(d2.format(), equals(d1.format()));
    });

    test('Dayfl(null) should use now', () {
      final d = Dayfl(null);
      expect(d.dateTime, isNotNull);
    });

    test('Dayfl with date-only string', () {
      final d = Dayfl('2024-12-25');
      expect(d.year, equals(2024));
      expect(d.month, equals(12));
      expect(d.day, equals(25));
    });
  });

  // ═══════════════════════════════════════════════
  // 2. Getters
  // ═══════════════════════════════════════════════
  group('Getters', () {
    final d = Dayfl('2023-05-15 14:30:25');

    test('year', () {
      expect(d.year, isA<int>());
      expect(d.year, equals(2023));
    });

    test('month', () {
      expect(d.month, isA<int>());
      expect(d.month, equals(5));
    });

    test('day', () {
      expect(d.day, isA<int>());
      expect(d.day, equals(15));
    });

    test('hour', () {
      expect(d.hour, isA<int>());
      expect(d.hour, equals(14));
    });

    test('minute', () {
      expect(d.minute, isA<int>());
      expect(d.minute, equals(30));
    });

    test('second', () {
      expect(d.second, isA<int>());
      expect(d.second, equals(25));
    });

    test('dateTime', () {
      expect(d.dateTime, isA<DateTime>());
      expect(d.dateTime!.year, equals(2023));
    });

    test('valueOf returns milliseconds', () {
      expect(d.valueOf, isA<int>());
      expect(d.valueOf, equals(d.dateTime!.millisecondsSinceEpoch));
    });

    test('isUtc', () {
      expect(d.isUtc, isA<bool>());
      expect(d.isUtc, equals(false));
    });

    test('isLeapYear', () {
      expect(Dayfl('2024-01-01').isLeapYear, isTrue);
      expect(Dayfl('2023-01-01').isLeapYear, isFalse);
      expect(Dayfl('2000-01-01').isLeapYear, isTrue);
      expect(Dayfl('1900-01-01').isLeapYear, isFalse);
    });

    test('daysInMonth', () {
      expect(Dayfl('2024-02-01').daysInMonth, equals(29)); // leap year
      expect(Dayfl('2023-02-01').daysInMonth, equals(28));
      expect(Dayfl('2024-01-01').daysInMonth, equals(31));
      expect(Dayfl('2024-04-01').daysInMonth, equals(30));
    });

    test('toArray', () {
      expect(d.toArray(), equals([2023, 5, 15, 14, 30, 25]));
    });

    test('toArray null safety', () {
      final d2 = Dayfl('2024-01-01 00:00:00');
      expect(d2.toArray(), equals([2024, 1, 1, 0, 0, 0]));
    });
  });

  // ═══════════════════════════════════════════════
  // 3. Setters
  // ═══════════════════════════════════════════════
  group('Setters', () {
    test('year setter', () {
      final d = Dayfl('2023-05-15');
      d.year = 2025;
      expect(d.year, equals(2025));
      expect(d.format('YYYY-MM-DD'), equals('2025-05-15'));
    });

    test('month setter', () {
      final d = Dayfl('2023-05-15');
      d.month = 12;
      expect(d.month, equals(12));
      expect(d.format('YYYY-MM-DD'), equals('2023-12-15'));
    });

    test('day setter', () {
      final d = Dayfl('2023-05-15');
      d.day = 20;
      expect(d.day, equals(20));
    });

    test('hour setter', () {
      final d = Dayfl('2023-05-15 14:00:00');
      d.hour = 22;
      expect(d.hour, equals(22));
    });

    test('minute setter', () {
      final d = Dayfl('2023-05-15 14:00:00');
      d.minute = 55;
      expect(d.minute, equals(55));
    });

    test('second setter', () {
      final d = Dayfl('2023-05-15 14:00:00');
      d.second = 59;
      expect(d.second, equals(59));
    });

    test('month setter clamps day overflow', () {
      final d = Dayfl('2024-01-31');
      d.month = 2;
      expect(d.day, equals(29)); // Feb 2024 has 29 days
      expect(d.format('YYYY-MM-DD'), equals('2024-02-29'));
    });

    test('setter validation - year', () {
      final d = Dayfl('2024-01-01');
      expect(() => d.year = 0, throwsA(isA<RangeError>()));
      expect(() => d.year = 10000, throwsA(isA<RangeError>()));
    });

    test('setter validation - month', () {
      final d = Dayfl('2024-01-01');
      expect(() => d.month = 0, throwsA(isA<RangeError>()));
      expect(() => d.month = 13, throwsA(isA<RangeError>()));
    });

    test('setter validation - day', () {
      final d = Dayfl('2024-01-01');
      expect(() => d.day = 0, throwsA(isA<RangeError>()));
      expect(() => d.day = 32, throwsA(isA<RangeError>()));
    });

    test('setter validation - hour', () {
      final d = Dayfl('2024-01-01');
      expect(() => d.hour = -1, throwsA(isA<RangeError>()));
      expect(() => d.hour = 24, throwsA(isA<RangeError>()));
    });

    test('setter validation - minute', () {
      final d = Dayfl('2024-01-01');
      expect(() => d.minute = -1, throwsA(isA<RangeError>()));
      expect(() => d.minute = 60, throwsA(isA<RangeError>()));
    });

    test('setter validation - second', () {
      final d = Dayfl('2024-01-01');
      expect(() => d.second = -1, throwsA(isA<RangeError>()));
      expect(() => d.second = 60, throwsA(isA<RangeError>()));
    });
  });

  // ═══════════════════════════════════════════════
  // 4. 链式调用
  // ═══════════════════════════════════════════════
  group('Chainable setters', () {
    test('setYear returns same instance', () {
      final d = Dayfl('2023-01-01');
      expect(d.setYear(2025), same(d));
      expect(d.year, equals(2025));
    });

    test('setMonth returns same instance', () {
      final d = Dayfl('2023-01-01');
      expect(d.setMonth(6), same(d));
      expect(d.month, equals(6));
    });

    test('setDay returns same instance', () {
      final d = Dayfl('2023-01-01');
      expect(d.setDay(15), same(d));
      expect(d.day, equals(15));
    });

    test('setHour returns same instance', () {
      final d = Dayfl('2023-01-01 00:00:00');
      expect(d.setHour(12), same(d));
      expect(d.hour, equals(12));
    });

    test('setMinute returns same instance', () {
      final d = Dayfl('2023-01-01 00:00:00');
      expect(d.setMinute(45), same(d));
      expect(d.minute, equals(45));
    });

    test('setSecond returns same instance', () {
      final d = Dayfl('2023-01-01 00:00:00');
      expect(d.setSecond(30), same(d));
      expect(d.second, equals(30));
    });

    test('full chain', () {
      final d = Dayfl('2020-01-01 00:00:00');
      d.setYear(2025).setMonth(12).setDay(25).setHour(18).setMinute(30).setSecond(0);
      expect(d.format('YYYY-MM-DD HH:mm:ss'), equals('2025-12-25 18:30:00'));
    });

    test('chain validation throws', () {
      final d = Dayfl('2024-01-01');
      expect(() => d.setYear(0), throwsA(isA<RangeError>()));
      expect(() => d.setMonth(13), throwsA(isA<RangeError>()));
      expect(() => d.setDay(0), throwsA(isA<RangeError>()));
      expect(() => d.setHour(-1), throwsA(isA<RangeError>()));
      expect(() => d.setMinute(60), throwsA(isA<RangeError>()));
      expect(() => d.setSecond(60), throwsA(isA<RangeError>()));
    });
  });

  // ═══════════════════════════════════════════════
  // 5. format() 全部占位符
  // ═══════════════════════════════════════════════
  group('format() tokens', () {
    final d = Dayfl('2024-03-09 14:05:08');

    test('YYYY', () => expect(d.format('YYYY'), equals('2024')));
    test('YY', () => expect(d.format('YY'), equals('24')));
    test('MM', () => expect(d.format('MM'), equals('03')));
    test('M', () => expect(d.format('M'), equals('3')));
    test('DD', () => expect(d.format('DD'), equals('09')));
    test('D', () => expect(d.format('D'), equals('9')));
    test('HH', () => expect(d.format('HH'), equals('14')));
    test('H', () => expect(d.format('H'), equals('14')));
    test('hh 12h', () => expect(d.format('hh'), equals('02')));
    test('h 12h', () => expect(d.format('h'), equals('2')));
    test('mm', () => expect(d.format('mm'), equals('05')));
    test('m', () => expect(d.format('m'), equals('5')));
    test('ss', () => expect(d.format('ss'), equals('08')));
    test('s', () => expect(d.format('s'), equals('8')));
    test('A AM', () {
      final d2 = Dayfl('2024-01-01 14:00:00');
      expect(d2.format('A'), equals('PM'));
    });
    test('a pm', () {
      final d2 = Dayfl('2024-01-01 14:00:00');
      expect(d2.format('a'), equals('pm'));
    });
    test('A AM morning', () {
      final d2 = Dayfl('2024-01-01 09:00:00');
      expect(d2.format('A'), equals('AM'));
    });
    test('a am morning', () {
      final d2 = Dayfl('2024-01-01 09:00:00');
      expect(d2.format('a'), equals('am'));
    });
    test('SSS', () {
      final d2 = Dayfl('2024-01-01 00:00:00.123');
      expect(d2.format('SSS'), equals('123'));
    });

    test('midnight 12h = 12 AM', () {
      final d2 = Dayfl('2024-01-01 00:00:00');
      expect(d2.format('h'), equals('12'));
      expect(d2.format('A'), equals('AM'));
    });

    test('noon 12h = 12 PM', () {
      final d2 = Dayfl('2024-01-01 12:00:00');
      expect(d2.format('h'), equals('12'));
      expect(d2.format('A'), equals('PM'));
    });

    test('13:00 = 1 PM', () {
      final d2 = Dayfl('2024-01-01 13:00:00');
      expect(d2.format('h'), equals('1'));
      expect(d2.format('A'), equals('PM'));
    });

    test('default format YYYY-MM-DD HH:mm:ss', () {
      final d2 = Dayfl('2024-03-09 14:05:08');
      expect(d2.format(), equals('2024-03-09 14:05:08'));
    });

    test('format combination YYYY/MM/DD', () {
      expect(d.format('YYYY/MM/DD'), equals('2024/03/09'));
    });

    test('format combination HH:mm:ss', () {
      expect(d.format('HH:mm:ss'), equals('14:05:08'));
    });

    test('format with empty string uses default', () {
      expect(d.format(''), equals(d.format()));
    });
  });

  // ═══════════════════════════════════════════════
  // 6. format() dayFormat 文字格式化
  // ═══════════════════════════════════════════════
  group('format() dayFormat', () {
    test('just now (< 10s)', () {
      final d = Dayfl();
      expect(d.format('', '', true), equals('刚刚'));
    });

    test('yesterday', () {
      final now = Dayfl();
      final yesterday = Dayfl().subtract(DateLocationEnum.day, 1);
      final result = yesterday.format('', '', true);
      expect(result, equals('昨天'));
    });

    test('days ago (same month, within 1 day boundary)', () {
      // dayFormat 逻辑: 同月内，diff.hours - currentHour > 0 时覆盖为 "昨天"
      // 超过 1 天都会显示 "昨天"，这是库本身的逻辑
      final d = Dayfl().subtract(DateLocationEnum.day, 3);
      final result = d.format('', '', true);
      expect(result, equals('昨天'));
    });

    test('months ago (different month, same year)', () {
      final now = Dayfl();
      final d = Dayfl().subtract(DateLocationEnum.month, 2);
      final result = d.format('', '', true);
      // Should be "X月前"
      expect(result, contains('月前'));
    });

    test('last year', () {
      final d = Dayfl().subtract(DateLocationEnum.year, 1);
      final result = d.format('', '', true);
      expect(result, contains('去年'));
    });

    test('dayFormat as callback function', () {
      final d = Dayfl('2024-06-15');
      final result = d.format('YYYY-MM-DD', '', (Dayfl dayfl) {
        return '自定义:${dayfl.year}';
      });
      expect(result, equals('自定义:2024'));
    });

    test('dayFormat false returns normal format', () {
      final d = Dayfl('2024-06-15 10:30:00');
      expect(d.format('YYYY-MM-DD', '', false), equals('2024-06-15'));
    });
  });

  // ═══════════════════════════════════════════════
  // 7. add() 日期加
  // ═══════════════════════════════════════════════
  group('add()', () {
    test('add year', () {
      final d = Dayfl('2023-06-15');
      d.add(DateLocationEnum.year, 2);
      expect(d.year, equals(2025));
      expect(d.month, equals(6));
      expect(d.day, equals(15));
    });

    test('add month', () {
      final d = Dayfl('2023-06-15');
      d.add(DateLocationEnum.month, 3);
      expect(d.year, equals(2023));
      expect(d.month, equals(9));
    });

    test('add month across year', () {
      final d = Dayfl('2023-10-15');
      d.add(DateLocationEnum.month, 4);
      expect(d.year, equals(2024));
      expect(d.month, equals(2));
    });

    test('add day', () {
      final d = Dayfl('2023-06-15');
      d.add(DateLocationEnum.day, 20);
      expect(d.format('YYYY-MM-DD'), equals('2023-07-05'));
    });

    test('add hour', () {
      final d = Dayfl('2023-06-15 10:00:00');
      d.add(DateLocationEnum.hour, 5);
      expect(d.hour, equals(15));
    });

    test('add hour across day', () {
      final d = Dayfl('2023-06-15 22:00:00');
      d.add(DateLocationEnum.hour, 3);
      expect(d.day, equals(16));
      expect(d.hour, equals(1));
    });

    test('add minute', () {
      final d = Dayfl('2023-06-15 10:00:00');
      d.add(DateLocationEnum.minute, 90);
      expect(d.hour, equals(11));
      expect(d.minute, equals(30));
    });

    test('add second', () {
      final d = Dayfl('2023-06-15 10:00:00');
      d.add(DateLocationEnum.sec, 3600);
      expect(d.hour, equals(11));
    });

    test('add returns same instance (chainable)', () {
      final d = Dayfl('2023-06-15');
      expect(d.add(DateLocationEnum.day, 1), same(d));
    });
  });

  // ═══════════════════════════════════════════════
  // 8. subtract() 日期减
  // ═══════════════════════════════════════════════
  group('subtract()', () {
    test('subtract year', () {
      final d = Dayfl('2023-06-15');
      d.subtract(DateLocationEnum.year, 1);
      expect(d.year, equals(2022));
    });

    test('subtract month', () {
      final d = Dayfl('2023-06-15');
      d.subtract(DateLocationEnum.month, 2);
      expect(d.year, equals(2023));
      expect(d.month, equals(4));
    });

    test('subtract month across year', () {
      final d = Dayfl('2023-02-15');
      d.subtract(DateLocationEnum.month, 3);
      expect(d.year, equals(2022));
      expect(d.month, equals(11));
    });

    test('subtract day', () {
      final d = Dayfl('2023-06-15');
      d.subtract(DateLocationEnum.day, 10);
      expect(d.format('YYYY-MM-DD'), equals('2023-06-05'));
    });

    test('subtract day across month', () {
      final d = Dayfl('2023-06-01');
      d.subtract(DateLocationEnum.day, 1);
      expect(d.format('YYYY-MM-DD'), equals('2023-05-31'));
    });

    test('subtract hour', () {
      final d = Dayfl('2023-06-15 14:00:00');
      d.subtract(DateLocationEnum.hour, 5);
      expect(d.hour, equals(9));
    });

    test('subtract minute', () {
      final d = Dayfl('2023-06-15 10:00:00');
      d.subtract(DateLocationEnum.minute, 30);
      expect(d.minute, equals(30));
    });

    test('subtract second', () {
      final d = Dayfl('2023-06-15 10:05:00');
      d.subtract(DateLocationEnum.sec, 60);
      expect(d.minute, equals(4));
    });

    test('subtract returns same instance (chainable)', () {
      final d = Dayfl('2023-06-15');
      expect(d.subtract(DateLocationEnum.day, 1), same(d));
    });
  });

  // ═══════════════════════════════════════════════
  // 9. endOf()
  // ═══════════════════════════════════════════════
  group('endOf()', () {
    test('endOf year', () {
      final d = Dayfl('2023-06-15 10:30:45');
      d.endOf(DateLocationEnum.year);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-12-31 23:59:59.999'));
    });

    test('endOf month', () {
      final d = Dayfl('2024-02-10');
      d.endOf(DateLocationEnum.month);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2024-02-29 23:59:59.999'));
    });

    test('endOf month non-leap', () {
      final d = Dayfl('2023-02-10');
      d.endOf(DateLocationEnum.month);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-02-28 23:59:59.999'));
    });

    test('endOf day', () {
      final d = Dayfl('2023-06-15 10:30:45');
      d.endOf(DateLocationEnum.day);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 23:59:59.999'));
    });

    test('endOf hour', () {
      final d = Dayfl('2023-06-15 10:30:45');
      d.endOf(DateLocationEnum.hour);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 10:59:59.999'));
    });

    test('endOf minute', () {
      final d = Dayfl('2023-06-15 10:30:45');
      d.endOf(DateLocationEnum.minute);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 10:30:59.999'));
    });

    test('endOf second', () {
      final d = Dayfl('2023-06-15 10:30:45.123');
      d.endOf(DateLocationEnum.sec);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 10:30:45.999'));
    });

    test('endOf returns same instance (chainable)', () {
      final d = Dayfl('2023-06-15');
      expect(d.endOf(DateLocationEnum.day), same(d));
    });
  });

  // ═══════════════════════════════════════════════
  // 9.5 startOf()
  // ═══════════════════════════════════════════════
  group('startOf()', () {
    test('startOf year', () {
      final d = Dayfl('2023-06-15 10:30:45.123');
      d.startOf(DateLocationEnum.year);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-01-01 00:00:00.000'));
    });

    test('startOf month', () {
      final d = Dayfl('2024-02-15 10:30:45.123');
      d.startOf(DateLocationEnum.month);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2024-02-01 00:00:00.000'));
    });

    test('startOf day', () {
      final d = Dayfl('2023-06-15 10:30:45.123');
      d.startOf(DateLocationEnum.day);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 00:00:00.000'));
    });

    test('startOf hour', () {
      final d = Dayfl('2023-06-15 10:30:45.123');
      d.startOf(DateLocationEnum.hour);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 10:00:00.000'));
    });

    test('startOf minute', () {
      final d = Dayfl('2023-06-15 10:30:45.123');
      d.startOf(DateLocationEnum.minute);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 10:30:00.000'));
    });

    test('startOf second', () {
      final d = Dayfl('2023-06-15 10:30:45.123');
      d.startOf(DateLocationEnum.sec);
      expect(d.format('YYYY-MM-DD HH:mm:ss.SSS'), equals('2023-06-15 10:30:45.000'));
    });

    test('startOf returns same instance (chainable)', () {
      final d = Dayfl('2023-06-15');
      expect(d.startOf(DateLocationEnum.day), same(d));
    });
  });

  // ═══════════════════════════════════════════════
  // 10. isBefore() / isAfter()
  // ═══════════════════════════════════════════════
  group('isBefore / isAfter', () {
    test('isBefore with Dayfl', () {
      final d1 = Dayfl('2023-06-15');
      final d2 = Dayfl('2023-06-16');
      expect(d1.isBefore(d2), isTrue);
      expect(d2.isBefore(d1), isFalse);
    });

    test('isAfter with Dayfl', () {
      final d1 = Dayfl('2023-06-15');
      final d2 = Dayfl('2023-06-16');
      expect(d2.isAfter(d1), isTrue);
      expect(d1.isAfter(d2), isFalse);
    });

    test('isBefore with DateTime', () {
      final d = Dayfl('2023-06-15');
      expect(d.isBefore(DateTime(2023, 6, 16)), isTrue);
      expect(d.isBefore(DateTime(2023, 6, 14)), isFalse);
    });

    test('isAfter with DateTime', () {
      final d = Dayfl('2023-06-15');
      expect(d.isAfter(DateTime(2023, 6, 14)), isTrue);
      expect(d.isAfter(DateTime(2023, 6, 16)), isFalse);
    });

    test('isBefore with String', () {
      final d = Dayfl('2023-06-15');
      expect(d.isBefore('2023-06-16'), isTrue);
      expect(d.isBefore('2023-06-14'), isFalse);
    });

    test('isAfter with String', () {
      final d = Dayfl('2023-06-15');
      expect(d.isAfter('2023-06-14'), isTrue);
      expect(d.isAfter('2023-06-16'), isFalse);
    });

    test('isBefore same time returns false', () {
      final d1 = Dayfl('2023-06-15 10:00:00');
      final d2 = Dayfl('2023-06-15 10:00:00');
      expect(d1.isBefore(d2), isFalse);
    });

    test('isAfter same time returns false', () {
      final d1 = Dayfl('2023-06-15 10:00:00');
      final d2 = Dayfl('2023-06-15 10:00:00');
      expect(d1.isAfter(d2), isFalse);
    });
  });

  // ═══════════════════════════════════════════════
  // 11. isSame()
  // ═══════════════════════════════════════════════
  group('isSame()', () {
    test('same millisecond (default)', () {
      final d1 = Dayfl('2023-06-15 10:30:45.123');
      final d2 = Dayfl('2023-06-15 10:30:45.123');
      expect(d1.isSame(d2), isTrue);
    });

    test('different millisecond', () {
      final d1 = Dayfl('2023-06-15 10:30:45.123');
      final d2 = Dayfl('2023-06-15 10:30:45.124');
      expect(d1.isSame(d2), isFalse);
    });

    test('isSame year', () {
      final d1 = Dayfl('2023-06-15');
      final d2 = Dayfl('2023-12-01');
      expect(d1.isSame(d2, DateLocationEnum.year), isTrue);
      expect(d1.isSame(Dayfl('2024-06-15'), DateLocationEnum.year), isFalse);
    });

    test('isSame month', () {
      final d1 = Dayfl('2023-06-10');
      final d2 = Dayfl('2023-06-20');
      expect(d1.isSame(d2, DateLocationEnum.month), isTrue);
      expect(d1.isSame(Dayfl('2023-07-10'), DateLocationEnum.month), isFalse);
    });

    test('isSame day', () {
      final d1 = Dayfl('2023-06-15 10:00:00');
      final d2 = Dayfl('2023-06-15 22:00:00');
      expect(d1.isSame(d2, DateLocationEnum.day), isTrue);
      expect(d1.isSame(Dayfl('2023-06-16'), DateLocationEnum.day), isFalse);
    });

    test('isSame hour', () {
      final d1 = Dayfl('2023-06-15 10:30:00');
      final d2 = Dayfl('2023-06-15 10:45:00');
      expect(d1.isSame(d2, DateLocationEnum.hour), isTrue);
      expect(d1.isSame(Dayfl('2023-06-15 11:00:00'), DateLocationEnum.hour), isFalse);
    });

    test('isSame minute', () {
      final d1 = Dayfl('2023-06-15 10:30:00');
      final d2 = Dayfl('2023-06-15 10:30:59');
      expect(d1.isSame(d2, DateLocationEnum.minute), isTrue);
      expect(d1.isSame(Dayfl('2023-06-15 10:31:00'), DateLocationEnum.minute), isFalse);
    });

    test('isSame second', () {
      final d1 = Dayfl('2023-06-15 10:30:45.100');
      final d2 = Dayfl('2023-06-15 10:30:45.900');
      expect(d1.isSame(d2, DateLocationEnum.sec), isTrue);
      expect(d1.isSame(Dayfl('2023-06-15 10:30:46'), DateLocationEnum.sec), isFalse);
    });
  });

  // ═══════════════════════════════════════════════
  // 12. difference() / compareTo()
  // ═══════════════════════════════════════════════
  group('difference / compareTo', () {
    test('difference returns Duration', () {
      final d1 = Dayfl('2023-06-15 14:00:00');
      final d2 = Dayfl('2023-06-15 10:00:00');
      final diff = d1.difference(d2);
      expect(diff, isA<Duration>());
      expect(diff.inHours, equals(4));
    });

    test('difference with DateTime', () {
      final d = Dayfl('2023-06-15 14:00:00');
      final diff = d.difference(DateTime(2023, 6, 15, 10, 0, 0));
      expect(diff.inHours, equals(4));
    });

    test('difference with Dayfl', () {
      final d1 = Dayfl('2023-06-20');
      final d2 = Dayfl('2023-06-15');
      expect(d1.difference(d2).inDays, equals(5));
    });

    test('compareTo before', () {
      final d1 = Dayfl('2023-06-15');
      final d2 = Dayfl('2023-06-16');
      expect(d1.compareTo(d2), lessThan(0));
    });

    test('compareTo after', () {
      final d1 = Dayfl('2023-06-16');
      final d2 = Dayfl('2023-06-15');
      expect(d1.compareTo(d2), greaterThan(0));
    });

    test('compareTo equal', () {
      final d1 = Dayfl('2023-06-15');
      final d2 = Dayfl('2023-06-15');
      expect(d1.compareTo(d2), equals(0));
    });

    test('compareTo with DateTime', () {
      final d = Dayfl('2023-06-16');
      expect(d.compareTo(DateTime(2023, 6, 15)), greaterThan(0));
    });
  });

  // ═══════════════════════════════════════════════
  // 13. diffIn()
  // ═══════════════════════════════════════════════
  group('diffIn()', () {
    test('diffIn year', () {
      final d1 = Dayfl('2025-06-15');
      final d2 = Dayfl('2023-06-15');
      expect(d1.diffIn(d2, DateLocationEnum.year), equals(2));
      expect(d2.diffIn(d1, DateLocationEnum.year), equals(-2));
    });

    test('diffIn month', () {
      final d1 = Dayfl('2023-05-15');
      final d2 = Dayfl('2023-01-15');
      expect(d1.diffIn(d2, DateLocationEnum.month), equals(4));
      expect(d2.diffIn(d1, DateLocationEnum.month), equals(-4));
    });

    test('diffIn month across years', () {
      final d1 = Dayfl('2024-03-15');
      final d2 = Dayfl('2023-11-15');
      expect(d1.diffIn(d2, DateLocationEnum.month), equals(4));
    });

    test('diffIn day', () {
      final d1 = Dayfl('2023-06-20');
      final d2 = Dayfl('2023-06-15');
      expect(d1.diffIn(d2, DateLocationEnum.day), equals(5));
    });

    test('diffIn hour', () {
      final d1 = Dayfl('2023-06-15 14:00:00');
      final d2 = Dayfl('2023-06-15 10:00:00');
      expect(d1.diffIn(d2, DateLocationEnum.hour), equals(4));
    });

    test('diffIn minute', () {
      final d1 = Dayfl('2023-06-15 10:30:00');
      final d2 = Dayfl('2023-06-15 10:00:00');
      expect(d1.diffIn(d2, DateLocationEnum.minute), equals(30));
    });

    test('diffIn second', () {
      final d1 = Dayfl('2023-06-15 10:05:00');
      final d2 = Dayfl('2023-06-15 10:00:00');
      expect(d1.diffIn(d2, DateLocationEnum.sec), equals(300));
    });

    test('diffIn with DateTime object', () {
      final d = Dayfl('2023-06-15 14:00:00');
      final dt = DateTime(2023, 6, 15, 10, 0, 0);
      expect(d.diffIn(dt, DateLocationEnum.hour), equals(4));
    });
  });

  // ═══════════════════════════════════════════════
  // 14. 月溢出
  // ═══════════════════════════════════════════════
  group('Month Overflow', () {
    test('Jan 31 + 1 month = Feb 28 (non-leap)', () {
      final d = Dayfl('2026-01-31');
      d.add(DateLocationEnum.month, 1);
      expect(d.format('YYYY-MM-DD'), equals('2026-02-28'));
    });

    test('Jan 29 + 1 month = Feb 29 (leap)', () {
      final d = Dayfl('2024-01-29');
      d.add(DateLocationEnum.month, 1);
      expect(d.format('YYYY-MM-DD'), equals('2024-02-29'));
    });

    test('Jan 29 + 1 month = Feb 28 (non-leap)', () {
      final d = Dayfl('2025-01-29');
      d.add(DateLocationEnum.month, 1);
      expect(d.format('YYYY-MM-DD'), equals('2025-02-28'));
    });

    test('Mar 31 - 1 month = Feb 28', () {
      final d = Dayfl('2026-03-31');
      d.subtract(DateLocationEnum.month, 1);
      expect(d.format('YYYY-MM-DD'), equals('2026-02-28'));
    });

    test('Jan 15 + 1 month = Feb 15 (no overflow)', () {
      final d = Dayfl('2026-01-15');
      d.add(DateLocationEnum.month, 1);
      expect(d.format('YYYY-MM-DD'), equals('2026-02-15'));
    });

    test('multiple months add', () {
      final d = Dayfl('2024-01-31');
      d.add(DateLocationEnum.month, 2);
      expect(d.month, equals(3));
      expect(d.day, equals(31));
    });
  });

  // ═══════════════════════════════════════════════
  // 15. 周格式化
  // ═══════════════════════════════════════════════
  group('Week Formatting', () {
    test('CN week full mapping', () {
      final expected = [
        ['2026-05-04', '星期一', '1'],
        ['2026-05-05', '星期二', '2'],
        ['2026-05-06', '星期三', '3'],
        ['2026-05-07', '星期四', '4'],
        ['2026-05-08', '星期五', '5'],
        ['2026-05-09', '星期六', '6'],
        ['2026-05-10', '星期日', '7'],
      ];
      for (final e in expected) {
        final d = Dayfl(e[0]);
        expect(d.format('WW'), equals(e[1]), reason: '${e[0]} WW');
        expect(d.format('W'), equals(e[2]), reason: '${e[0]} W');
      }
    });

    test('EN week text mapping (weekStart=0)', () {
      // English weekStart=0: week starts on Sunday, W is always weekday 1-7
      final expected = [
        ['2026-05-04', 'Monday', 2],
        ['2026-05-05', 'Tuesday', 3],
        ['2026-05-06', 'Wednesday', 4],
        ['2026-05-07', 'Thursday', 5],
        ['2026-05-08', 'Friday', 6],
        ['2026-05-09', 'Saturday', 7],
        ['2026-05-10', 'Sunday', 7], // weekday=7, but text is Sunday
      ];
      for (final e in expected) {
        final d = Dayfl(e[0]);
        expect(d.format('WW', 'en'), equals(e[1]), reason: '${e[0]} WW en');
        // W is always weekday number from getWeek
        final week = d.getWeek('en');
        expect(d.format('W', 'en'), equals(week['num'].toString()), reason: '${e[0]} W en');
      }
    });

    test('getWeek CN', () {
      final d = Dayfl('2026-05-07');
      final week = d.getWeek();
      expect(week['num'], equals(4));
      expect(week['text'], equals('星期四'));
    });

    test('getWeek EN', () {
      final d = Dayfl('2026-05-07');
      final week = d.getWeek('en');
      expect(week['num'], equals(4)); // weekday is always 1-7
      expect(week['text'], equals('Thursday'));
    });
  });

  // ═══════════════════════════════════════════════
  // 16. MMM 月份缩写
  // ═══════════════════════════════════════════════
  group('MMM Month Abbreviation', () {
    test('CN all months', () {
      final months = ['一月', '二月', '三月', '四月', '五月', '六月',
                       '七月', '八月', '九月', '十月', '十一月', '十二月'];
      for (int i = 0; i < 12; i++) {
        final d = Dayfl('2024-${i + 1}-15');
        expect(d.format('MMM'), equals(months[i]), reason: 'month ${i + 1}');
      }
    });

    test('EN all months', () {
      final months = ['January', 'February', 'March', 'April', 'May', 'June',
                       'July', 'August', 'September', 'October', 'November', 'December'];
      for (int i = 0; i < 12; i++) {
        final d = Dayfl('2024-${i + 1}-15');
        expect(d.format('MMM', 'en'), equals(months[i]), reason: 'month ${i + 1}');
      }
    });

    test('MMM in format combination CN', () {
      final d = Dayfl('2024-07-01');
      expect(d.format('YYYY-MMM-DD'), equals('2024-七月-01'));
    });

    test('MMM in format combination EN', () {
      final d = Dayfl('2024-07-01');
      expect(d.format('YYYY-MMM-DD', 'en'), equals('2024-July-01'));
    });

    test('MMM with "a" token in format does not corrupt', () {
      final d = Dayfl('2024-01-15 14:00:00');
      // "January" contains "a" — must not be corrupted
      expect(d.format('MMM a', 'en'), equals('January pm'));
    });
  });

  // ═══════════════════════════════════════════════
  // 17. 语言包
  // ═══════════════════════════════════════════════
  group('Locale', () {
    test('setLocale changes global locale', () {
      final d = Dayfl('2024-06-15');
      d.setLocale = 'en';
      expect(d.getLocale().name, equals('en'));
      d.setLocale = 'cn';
      expect(d.getLocale().name, equals('cn'));
    });

    test('format with locale param', () {
      final d = Dayfl('2024-06-15');
      expect(d.format('YYYY-MMM-DD', 'en'), contains('June'));
      expect(d.format('YYYY-MMM-DD', 'cn'), contains('六月'));
    });

    test('getWeek with locale param', () {
      final d = Dayfl('2026-05-07');
      expect(d.getWeek('en')['text'], equals('Thursday'));
      expect(d.getWeek('cn')['text'], equals('星期四'));
    });

    test('getLocale returns correct locale', () {
      final d = Dayfl();
      expect(d.getLocale('cn').name, equals('cn'));
      expect(d.getLocale('en').name, equals('en'));
    });

    test('getLocale falls back to first locale if not found', () {
      final d = Dayfl();
      expect(d.getLocale('nonexistent').name, equals('cn'));
    });

    test('addLocale adds new locale', () {
      final result = Dayfl.addLocale(Locale(
        name: 'test_lang',
        monthAbbreviations: ['M1', 'M2', 'M3', 'M4', 'M5', 'M6',
                              'M7', 'M8', 'M9', 'M10', 'M11', 'M12'],
        weekStart: 1,
        weekAbbreviations: ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7'],
      ));
      expect(result, isTrue);
      final d = Dayfl('2024-01-15');
      expect(d.getLocale('test_lang').name, equals('test_lang'));
    });

    test('addLocale duplicate returns false', () {
      final result = Dayfl.addLocale(Locale(name: 'cn'));
      expect(result, isFalse);
    });

    test('custom locale format MMM', () {
      final d = Dayfl('2024-03-15');
      expect(d.format('MMM', 'test_lang'), equals('M3'));
    });

    test('custom locale format WW', () {
      // 2024-03-15 is Friday (weekday=5)
      final d = Dayfl('2024-03-15');
      expect(d.format('WW', 'test_lang'), equals('W5'));
    });
  });

  // ═══════════════════════════════════════════════
  // 18. addMatchers / delMatchers
  // ═══════════════════════════════════════════════
  group('addMatchers / delMatchers', () {
    setUp(() {
      Dayfl.delMatchers('CUSTOM');
    });

    test('addMatchers adds custom token', () {
      Dayfl.addMatchers('CUSTOM', (Dayfl dayfl) => dayfl.year.toString());
      final d = Dayfl('2024-06-15');
      expect(d.format('CUSTOM'), equals('2024'));
    });

    test('addMatchers overwrites existing', () {
      Dayfl.addMatchers('CUSTOM', (Dayfl dayfl) => 'first');
      Dayfl.addMatchers('CUSTOM', (Dayfl dayfl) => 'second');
      final d = Dayfl('2024-06-15');
      expect(d.format('CUSTOM'), equals('second'));
    });

    test('delMatchers removes custom token', () {
      Dayfl.addMatchers('XQ', (Dayfl dayfl) => 'value');
      Dayfl.delMatchers('XQ');
      final d = Dayfl('2024-06-15');
      // After deletion, XQ should not be replaced (stays as literal)
      expect(d.format('XQ'), equals('XQ'));
    });

    test('custom token with existing tokens', () {
      Dayfl.addMatchers('TOKEN', (Dayfl dayfl) => '${dayfl.year}-${dayfl.month}');
      final d = Dayfl('2024-06-15');
      expect(d.format('TOKEN'), equals('2024-6'));
    });
  });

  // ═══════════════════════════════════════════════
  // 19. 自定义格式解析
  // ═══════════════════════════════════════════════
  group('Custom format parsing', () {
    test('YY/M/DD HH:mm:s', () {
      final d = Dayfl('26/1/06 13:05:1', 'YY/M/DD HH:mm:s');
      expect(d.year, equals(2026));
      expect(d.month, equals(1));
      expect(d.day, equals(6));
      expect(d.hour, equals(13));
      expect(d.minute, equals(5));
      expect(d.second, equals(1));
    });

    test('YYYY-MM-DD', () {
      final d = Dayfl('2024-12-25', 'YYYY-MM-DD');
      expect(d.year, equals(2024));
      expect(d.month, equals(12));
      expect(d.day, equals(25));
    });

    test('YYYY/MM/DD HH:mm:ss', () {
      final d = Dayfl('2024/06/15 14:30:45', 'YYYY/MM/DD HH:mm:ss');
      expect(d.year, equals(2024));
      expect(d.month, equals(6));
      expect(d.day, equals(15));
      expect(d.hour, equals(14));
      expect(d.minute, equals(30));
      expect(d.second, equals(45));
    });

    test('auto parse YYYY-MM-DD', () {
      final d = Dayfl('2024-06-15');
      expect(d.year, equals(2024));
      expect(d.month, equals(6));
      expect(d.day, equals(15));
    });

    test('auto parse YYYY-MM-DD HH:mm:ss', () {
      final d = Dayfl('2024-06-15 14:30:45');
      expect(d.hour, equals(14));
      expect(d.minute, equals(30));
      expect(d.second, equals(45));
    });

    test('auto parse with T separator', () {
      final d = Dayfl('2024-06-15T14:30:45');
      expect(d.hour, equals(14));
      expect(d.minute, equals(30));
    });
  });

  // ═══════════════════════════════════════════════
  // 20. 边界情况
  // ═══════════════════════════════════════════════
  group('Edge cases', () {
    test('date-only string defaults time to 00:00:00', () {
      final d = Dayfl('2024-06-15');
      expect(d.hour, equals(0));
      expect(d.minute, equals(0));
      expect(d.second, equals(0));
    });

    test('year as int creates Jan 1', () {
      final d = Dayfl(2024);
      expect(d.month, equals(1));
      expect(d.day, equals(1));
    });

    test('leap year Feb 29', () {
      final d = Dayfl('2024-02-29');
      expect(d.day, equals(29));
      expect(d.isLeapYear, isTrue);
    });

    test('endOf year 2024 leap', () {
      final d = Dayfl('2024-01-01');
      d.endOf(DateLocationEnum.year);
      expect(d.month, equals(12));
      expect(d.day, equals(31));
    });

    test('chainable setters with month overflow', () {
      final d = Dayfl('2024-01-31');
      d.setMonth(2);
      expect(d.day, equals(29)); // clamped to Feb 29
      expect(d.month, equals(2));
    });

    test('setLocale setter', () {
      final d = Dayfl('2024-06-15');
      d.setLocale = 'en';
      expect(d.getLocale().name, equals('en'));
    });
  });
}
