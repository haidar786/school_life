import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'single_day_schedule.g.dart';

@HiveType()
class SingleDaySchedule {
  @HiveField(0)
  int day;
  @HiveField(1)
  TimeOfDay startTime;
  @HiveField(2)
  TimeOfDay endTime;

  SingleDaySchedule(this.day, this.startTime, this.endTime);
}
