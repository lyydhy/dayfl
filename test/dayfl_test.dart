import 'package:test/test.dart';
import 'package:dayfl/dayfl.dart';

void main() {
  group('Dayfl Getters and Setters Tests', () {
    test('year getter should return int', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      expect(dayfl.year, isA<int>());
      expect(dayfl.year, equals(2023));
    });

    test('month getter should return int', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      expect(dayfl.month, isA<int>());
      expect(dayfl.month, equals(5));
    });

    test('day getter should return int', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      expect(dayfl.day, isA<int>());
      expect(dayfl.day, equals(15));
    });

    test('hour getter should return int', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      expect(dayfl.hour, isA<int>());
      expect(dayfl.hour, equals(14));
    });

    test('minute getter should return int', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      expect(dayfl.minute, isA<int>());
      expect(dayfl.minute, equals(30));
    });

    test('second getter should return int', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      expect(dayfl.second, isA<int>());
      expect(dayfl.second, equals(25));
    });

    test('year setter should work correctly', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      dayfl.year = 2024;
      expect(dayfl.year, equals(2024));
      expect(dayfl.format('YYYY-MM-DD'), equals('2024-05-15'));
    });

    test('month setter should work correctly', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      dayfl.month = 12;
      expect(dayfl.month, equals(12));
      expect(dayfl.format('YYYY-MM-DD'), equals('2023-12-15'));
    });

    test('day setter should work correctly', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      dayfl.day = 20;
      expect(dayfl.day, equals(20));
      expect(dayfl.format('YYYY-MM-DD'), equals('2023-05-20'));
    });

    test('hour setter should work correctly', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      dayfl.hour = 18;
      expect(dayfl.hour, equals(18));
      expect(dayfl.format('HH:mm:ss'), equals('18:30:25'));
    });

    test('minute setter should work correctly', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      dayfl.minute = 45;
      expect(dayfl.minute, equals(45));
      expect(dayfl.format('HH:mm:ss'), equals('14:45:25'));
    });

    test('second setter should work correctly', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      dayfl.second = 59;
      expect(dayfl.second, equals(59));
      expect(dayfl.format('HH:mm:ss'), equals('14:30:59'));
    });

    test('setter validation should work', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      
      // Test invalid year
      expect(() => dayfl.year = 0, throwsA(isA<RangeError>()));
      expect(() => dayfl.year = 10000, throwsA(isA<RangeError>()));
      
      // Test invalid month
      expect(() => dayfl.month = 0, throwsA(isA<RangeError>()));
      expect(() => dayfl.month = 13, throwsA(isA<RangeError>()));
      
      // Test invalid day
      expect(() => dayfl.day = 0, throwsA(isA<RangeError>()));
      expect(() => dayfl.day = 32, throwsA(isA<RangeError>()));
      
      // Test invalid hour
      expect(() => dayfl.hour = -1, throwsA(isA<RangeError>()));
      expect(() => dayfl.hour = 24, throwsA(isA<RangeError>()));
      
      // Test invalid minute
      expect(() => dayfl.minute = -1, throwsA(isA<RangeError>()));
      expect(() => dayfl.minute = 60, throwsA(isA<RangeError>()));
      
      // Test invalid second
      expect(() => dayfl.second = -1, throwsA(isA<RangeError>()));
      expect(() => dayfl.second = 60, throwsA(isA<RangeError>()));
    });

    test('toArray should return int array', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final array = dayfl.toArray();
      expect(array, isA<List<int>>());
      expect(array, equals([2023, 5, 15, 14, 30, 25]));
    });

    test('isLeapYear should work correctly', () {
      final leapYear = Dayfl('2024-01-01');
      final normalYear = Dayfl('2023-01-01');
      
      expect(leapYear.isLeapYear, isTrue);
      expect(normalYear.isLeapYear, isFalse);
    });
  });

  group('Dayfl Chainable Methods Tests', () {
    test('setYear should return Dayfl instance for chaining', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final result = dayfl.setYear(2024);
      expect(result, same(dayfl));
      expect(dayfl.year, equals(2024));
    });

    test('setMonth should return Dayfl instance for chaining', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final result = dayfl.setMonth(12);
      expect(result, same(dayfl));
      expect(dayfl.month, equals(12));
    });

    test('setDay should return Dayfl instance for chaining', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final result = dayfl.setDay(20);
      expect(result, same(dayfl));
      expect(dayfl.day, equals(20));
    });

    test('setHour should return Dayfl instance for chaining', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final result = dayfl.setHour(18);
      expect(result, same(dayfl));
      expect(dayfl.hour, equals(18));
    });

    test('setMinute should return Dayfl instance for chaining', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final result = dayfl.setMinute(45);
      expect(result, same(dayfl));
      expect(dayfl.minute, equals(45));
    });

    test('setSecond should return Dayfl instance for chaining', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final result = dayfl.setSecond(50);
      expect(result, same(dayfl));
      expect(dayfl.second, equals(50));
    });

    test('chainable methods should work together', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      final result = dayfl
          .setYear(2025)
          .setMonth(8)
          .setDay(10)
          .setHour(9)
          .setMinute(15)
          .setSecond(30);
      
      expect(result, same(dayfl));
      expect(dayfl.format('YYYY-MM-DD HH:mm:ss'), equals('2025-08-10 09:15:30'));
    });

    test('chainable methods should validate input ranges', () {
      final dayfl = Dayfl('2023-05-15 14:30:25');
      
      expect(() => dayfl.setYear(0), throwsA(isA<RangeError>()));
      expect(() => dayfl.setMonth(0), throwsA(isA<RangeError>()));
      expect(() => dayfl.setMonth(13), throwsA(isA<RangeError>()));
      expect(() => dayfl.setDay(0), throwsA(isA<RangeError>()));
      expect(() => dayfl.setDay(32), throwsA(isA<RangeError>()));
      expect(() => dayfl.setHour(-1), throwsA(isA<RangeError>()));
      expect(() => dayfl.setHour(24), throwsA(isA<RangeError>()));
      expect(() => dayfl.setMinute(-1), throwsA(isA<RangeError>()));
      expect(() => dayfl.setMinute(60), throwsA(isA<RangeError>()));
      expect(() => dayfl.setSecond(-1), throwsA(isA<RangeError>()));
      expect(() => dayfl.setSecond(60), throwsA(isA<RangeError>()));
    });
  });

  group('Dayfl endOf Tests', () {
    test('endOf month should return the last day of the month', () {
      final dayfl = Dayfl('2023-02-10');
      dayfl.endOf(DateLocationEnum.month);
      expect(dayfl.format('YYYY-MM-DD HH:mm:ss.SSS'), '2023-02-28 23:59:59.999');
    });

    test('endOf year should return the last day of the year', () {
      final dayfl = Dayfl('2023-02-10');
      dayfl.endOf(DateLocationEnum.year);
      expect(dayfl.format('YYYY-MM-DD HH:mm:ss.SSS'), '2023-12-31 23:59:59.999');
    });

    test('endOf day should return the end of the day', () {
      final dayfl = Dayfl('2023-02-10 10:20:30');
      dayfl.endOf(DateLocationEnum.day);
      expect(dayfl.format('YYYY-MM-DD HH:mm:ss.SSS'), '2023-02-10 23:59:59.999');
    });

    test('endOf hour should return the end of the hour', () {
      final dayfl = Dayfl('2023-02-10 10:20:30');
      dayfl.endOf(DateLocationEnum.hour);
      expect(dayfl.format('YYYY-MM-DD HH:mm:ss.SSS'), '2023-02-10 10:59:59.999');
    });

    test('endOf minute should return the end of the minute', () {
      final dayfl = Dayfl('2023-02-10 10:20:30');
      dayfl.endOf(DateLocationEnum.minute);
      expect(dayfl.format('YYYY-MM-DD HH:mm:ss.SSS'), '2023-02-10 10:20:59.999');
    });

    test('endOf second should return the end of the second', () {
      final dayfl = Dayfl('2023-02-10 10:20:30.123');
      dayfl.endOf(DateLocationEnum.sec);
      expect(dayfl.format('YYYY-MM-DD HH:mm:ss.SSS'), '2023-02-10 10:20:30.999');
    });
  });

  group('Dayfl diffIn Tests', () {
    test('diffIn years should calculate year difference', () {
      final dayfl1 = Dayfl('2023-05-15');
      final dayfl2 = Dayfl('2021-05-15');
      expect(dayfl1.diffIn(dayfl2, DateLocationEnum.year), equals(2));
      expect(dayfl2.diffIn(dayfl1, DateLocationEnum.year), equals(-2));
    });

    test('diffIn months should calculate month difference', () {
      final dayfl1 = Dayfl('2022-05-15');
      final dayfl2 = Dayfl('2023-02-15');
      expect(dayfl1.diffIn(dayfl2, DateLocationEnum.month), equals(-9));
      expect(dayfl2.diffIn(dayfl1, DateLocationEnum.month), equals(9));
    });

    test('diffIn months across years should work correctly', () {
      final dayfl1 = Dayfl('2023-03-15');
      final dayfl2 = Dayfl('2022-11-15');
      expect(dayfl1.diffIn(dayfl2, DateLocationEnum.month), equals(4));
    });

    test('diffIn days should calculate day difference', () {
      final dayfl1 = Dayfl('2023-05-15');
      final dayfl2 = Dayfl('2023-05-10');
      expect(dayfl1.diffIn(dayfl2, DateLocationEnum.day), equals(5));
      expect(dayfl2.diffIn(dayfl1, DateLocationEnum.day), equals(-5));
    });

    test('diffIn hours should calculate hour difference', () {
      final dayfl1 = Dayfl('2023-05-15 14:30:00');
      final dayfl2 = Dayfl('2023-05-15 10:30:00');
      expect(dayfl1.diffIn(dayfl2, DateLocationEnum.hour), equals(4));
      expect(dayfl2.diffIn(dayfl1, DateLocationEnum.hour), equals(-4));
    });

    test('diffIn minutes should calculate minute difference', () {
      final dayfl1 = Dayfl('2023-05-15 14:30:00');
      final dayfl2 = Dayfl('2023-05-15 14:15:00');
      expect(dayfl1.diffIn(dayfl2, DateLocationEnum.minute), equals(15));
      expect(dayfl2.diffIn(dayfl1, DateLocationEnum.minute), equals(-15));
    });

    test('diffIn seconds should calculate second difference', () {
      final dayfl1 = Dayfl('2023-05-15 14:30:30');
      final dayfl2 = Dayfl('2023-05-15 14:30:00');
      expect(dayfl1.diffIn(dayfl2, DateLocationEnum.sec), equals(30));
      expect(dayfl2.diffIn(dayfl1, DateLocationEnum.sec), equals(-30));
    });

    test('diffIn should work with DateTime objects', () {
      final dayfl = Dayfl('2023-05-15 14:30:00');
      final dateTime = DateTime(2023, 5, 15, 10, 30, 0);
      expect(dayfl.diffIn(dateTime, DateLocationEnum.hour), equals(4));
    });
  });

}
