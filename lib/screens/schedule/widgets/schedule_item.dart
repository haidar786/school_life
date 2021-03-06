import 'package:flutter/material.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/util/days_util.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(
    this.subject, {
    Key key,
    this.isFirst,
    this.isLast,
    @required this.selectedDay,
  }) : super(key: key);

  final Subject subject;
  final bool isFirst;
  final bool isLast;
  final DateTime selectedDay;

  static const Radius RADIUS = Radius.circular(10);

  BorderRadius get leftBorderRadius {
    if (isFirst & isLast) {
      return const BorderRadius.horizontal(left: RADIUS);
    } else if (isFirst) {
      return const BorderRadius.only(topLeft: RADIUS);
    } else if (isLast) {
      return const BorderRadius.only(bottomLeft: RADIUS);
    }
    return null;
  }

  BorderRadius get rightBorderRadius {
    if (isFirst & isLast) {
      return const BorderRadius.horizontal(right: RADIUS);
    } else if (isFirst) {
      return const BorderRadius.only(topRight: RADIUS);
    } else if (isLast) {
      return const BorderRadius.only(bottomRight: RADIUS);
    }
    return null;
  }

  BorderRadius get borderRadius {
    if (isFirst & isLast) {
      return const BorderRadius.all(RADIUS);
    } else if (isFirst) {
      return const BorderRadius.vertical(top: RADIUS);
    } else if (isLast) {
      return const BorderRadius.vertical(bottom: RADIUS);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String weekdayString = selectedDay.weekday.toString();
    final String dayOfWeek = daysFromIntegerString[weekdayString];
    final String startTime = subject.schedule[dayOfWeek][0].format(context);
    final String endTime = subject.schedule[dayOfWeek][1].format(context);

    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            decoration: BoxDecoration(
              borderRadius: leftBorderRadius,
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFFff8878),
                  Color(0xFFffb187),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  startTime,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  endTime,
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 3,
            height: 50,
            color: subject.color,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: rightBorderRadius,
                ),
                child: Text(
                  subject.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
