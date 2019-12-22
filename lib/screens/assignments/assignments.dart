import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/assignments/widgets/all_assignments/all_assignments.dart';
import 'package:school_life/screens/forms/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/settings/children/assignments-set.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  Future<List<Assignment>> future;
  Map<int, Subject> assignmentSubjectsByID;
  bool _userHasSubjects = false;

  @override
  void initState() {
    super.initState();
    future = AssignmentsRepository.getAllAssignments();
    _doesUserHaveSubjects();
    _getAssignmentSubjects();
  }

  void _doesUserHaveSubjects() async {
    List<Subject> subjects = await SubjectsRepository.getAllSubjects();
    if (subjects.isNotEmpty) {
      setState(() {
        _userHasSubjects = true;
      });
    }
  }

  void _getAssignmentSubjects() async {
    List<int> assignmentSubjectIDs = await _getSubjectsList();
    Map<int, Subject> assignmentSubjectsMap =
        await _getSubjectsMap(assignmentSubjectIDs);
    setState(() {
      assignmentSubjectsByID = assignmentSubjectsMap;
    });
  }

  Future<List<int>> _getSubjectsList() async {
    // get list of assignments
    final List<Assignment> assignments = await future;
    // create list that holds the ids of all assignments
    final List<int> assignmentSubjectIDs =
        assignments.map((assignment) => assignment.subjectID).toList();
    return assignmentSubjectIDs;
  }

  Future<Map<int, Subject>> _getSubjectsMap(
      List<int> assignmentSubjectIDs) async {
    // create temp map
    Map<int, Subject> subjectsByID = {};
    // loop through given subject ids
    for (int subjectID in assignmentSubjectIDs) {
      // get subject from current id
      final _subject = await SubjectsRepository.getSubject(subjectID);
      // assign subject id to its subject
      subjectsByID[subjectID] = _subject;
    }
    return subjectsByID;
  }

  void deleteAssignment(Assignment assignment) async {
    await assignment.delete();
    refreshAssignments();
  }

  void refreshAssignments() {
    setState(() {
      future = AssignmentsRepository.getAllAssignments();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (assignmentSubjectsByID == null)
      return Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: CustomAppBar(
        "Assignments",
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignmentsSettingsPage(),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleAddAssignmentPress(context),
        label: const Text("Add Assignment"),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        primary: false,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: AllAssignments(
            future,
            assignmentSubjectsByID,
            deleteAssignment,
          ),
        ),
      ),
    );
  }

  void _handleAddAssignmentPress(BuildContext context) {
    if (!_userHasSubjects) {
      _showNoSubjectsDialog(context);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAssignmentPage(),
      ),
    );
  }

  void _showNoSubjectsDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("No subjects found"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
