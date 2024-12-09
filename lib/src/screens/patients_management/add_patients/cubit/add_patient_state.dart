part of 'add_patient_cubit.dart';

@immutable
sealed class AddPatientState {}

final class AddPatientLoading extends AddPatientState {
  //Handling View Stuff
  final bool isShowSearchBtn;
  final bool isShowUserView;
  final bool isShowPatientView;
  AddPatientLoading({
    this.isShowPatientView = false,
    this.isShowSearchBtn = true,
    this.isShowUserView = false,
  });
}

final class AddPatientDataSuccess extends AddPatientState {
  final ExistingUserData data;
  final String msg;
  final bool clearTF;
//Handling View Stuff
  final bool isShowSearchBtn;
  final bool isShowUserView;
  final bool isShowPatientView;
  final String patientIdToPost;
  final String patienID;

  AddPatientDataSuccess({
    required this.data,
    required this.msg,
    this.clearTF = false,
    this.isShowPatientView = false,
    this.isShowSearchBtn = false,
    this.isShowUserView = false,
    this.patientIdToPost = "",
    this.patienID = "",
  });
}

final class AddPatientFailure extends AddPatientState {
  final String msg;
  AddPatientFailure(this.msg);
}

final class AddUserLoading extends AddPatientState {}

final class AddUserSuccess extends AddPatientState {
  final String msg;
  AddUserSuccess(this.msg);
}

final class AddUserFailure extends AddPatientState {
  final String msg;
  AddUserFailure(this.msg);
}
