import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AddScheduleFormBloc extends FormBloc<String, dynamic> {
  AddScheduleFormBloc() : super(isLoading: true);

  // ignore: close_sinks
  final subjectField = SelectFieldBloc(
    validators: [FieldBlocValidators.requiredSelectFieldBloc],
  );

  // ignore: close_sinks
  final scheduleDaysField = MultiSelectFieldBloc(
    validators: [FieldBlocValidators.requiredMultiSelectFieldBloc],
    items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
  );

  // ignore: close_sinks
  final sameTimeEveryday = BooleanFieldBloc(initialValue: false);

  @override
  List<FieldBloc> get fieldBlocs => [
        subjectField,
        scheduleDaysField,
        sameTimeEveryday,
      ];

  @override
  Stream<FormBlocState<String, dynamic>> onLoading() async* {
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onReload() async* {
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onSubmitting() async* {
    yield state.toSuccess();
  }

  Stream<FormBlocState<String, dynamic>> _setSubjectFieldValues() async* {
    List<Subject> subjects = await SubjectsRepository.getAllSubjects();
    for (Subject subject in subjects) {
      subjectField.addItem(subject.name);
    }
    subjectField.updateInitialValue(subjects.first.name);
    yield state.toLoaded();
  }
}
