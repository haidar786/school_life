import 'package:flutter/material.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class Validators {
  static String maxLength(String value, int maxLength) {
    if (value.trim().length > maxLength)
      return 'Shorten to $maxLength characters please.';
    return null;
  }

  static String notSameStartTime(TimeOfDay time, String selectedDay) {
    final List<Subject> applicableSubjects =
        getIt<SubjectsRepository>().getSubjectsWithSameDaySchedule(selectedDay);
    for (Subject subject in applicableSubjects) {
      if (subject.schedule[selectedDay][0] == time) {
        return 'Same start time';
      }
    }
    return null;
  }
}
