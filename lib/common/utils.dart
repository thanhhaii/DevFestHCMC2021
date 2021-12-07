
import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final double money;
  final bool isPay;
  final DateTime date;
  final String userUID;

  Event(this.title, this.money, this.isPay, this.date, this.userUID);

}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Tien An',30000,true,DateTime.parse("20211206"),"q8Uc07e0eSTDkygN3KVwKkYRKxL2")))
  ..addAll({
    kToday: [
      Event('Tien An',30000,true,DateTime.parse("20211206"),"q8Uc07e0eSTDkygN3KVwKkYRKxL2")
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);