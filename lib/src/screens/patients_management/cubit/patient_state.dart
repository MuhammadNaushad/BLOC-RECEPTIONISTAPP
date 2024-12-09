part of 'patient_cubit.dart';

@immutable
sealed class PatientState {}

final class PatientLoading extends PatientState {}

final class PatientDataSuccess extends PatientState {
  final List<PatientData> data;
  final String msg;
  final bool hasMore;
  final bool hasMoreFetchError;
  final bool clearTF;

  PatientDataSuccess({
    required this.data,
    required this.msg,
    required this.hasMore,
    required this.hasMoreFetchError,
    this.clearTF = false,
  });
}

final class PatientFailure extends PatientState {
  final String msg;
  PatientFailure(this.msg);
}
