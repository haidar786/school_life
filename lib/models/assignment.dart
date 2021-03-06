import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'assignment.g.dart';

@HiveType(typeId: 1)
class Assignment extends HiveObject {
  Assignment(
    this.id,
    this.name,
    this.dueDate,
    this.subjectID,
    this.details,
    this.color,
    this.isDeleted,
  );

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime dueDate;
  @HiveField(3)
  int subjectID;
  @HiveField(4)
  String details;
  @HiveField(5)
  Color color;
  @HiveField(6)
  bool isDeleted;
}
