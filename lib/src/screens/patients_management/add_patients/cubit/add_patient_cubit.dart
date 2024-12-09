import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yslcrm/src/models/patients_management/existing_user_data_model.dart';
import 'package:yslcrm/src/utils/ErrorMessageKeys.dart';

import '../../../../data/repositories/patient_management/add_patient/add_patient_repository.dart';

part 'add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  final AddPatientRepository _addPatientRepository = AddPatientRepository();
  AddPatientCubit() : super(AddPatientLoading());

  Future<void> checkPatient({required String phone_no}) async {
    try {
      emit(AddPatientLoading());
      final result =
          await _addPatientRepository.checkPatient(phone_no: phone_no);
      if (result.data != null) {
        if (result.data!.userStatus != null) {
          if (result.data!.userStatus!) {
            if (result.data!.data != null) {
              emit(AddPatientDataSuccess(
                  msg: result.message ?? "User Found",
                  data: result.data!.data!,
                  isShowPatientView: true,
                  isShowUserView: true,
                  isShowSearchBtn: false,
                  patienID: result.data!.data!.id!.toString(),
                  clearTF: true));
            } else {
              emit(AddPatientFailure(result.message.toString()));
            }
          } else {
            emit(AddPatientDataSuccess(
                msg: result.message ?? "User not Found",
                data: result.data!.data!,
                isShowPatientView: false,
                isShowUserView: true,
                isShowSearchBtn: false,
                patienID: "",
                clearTF: true));
          }
        } else {
          emit(AddPatientFailure(result.message.toString()));
        }
      } else {
        emit(AddPatientFailure(result.message.toString()));
      }
    } catch (e) {
      print(e);
      emit(AddPatientFailure(e.toString().contains(ErrorMessageKeys.noInternet)
          ? ErrorMessageKeys.noInternet
          : ErrorMessageKeys.defaultErrorMessage));
    }
  }

  Future<void> addUser(
      {required String phone_no,
      required String name,
      required String age,
      required String gender,
      required String address,
      required String status}) async {
    try {
      emit(AddPatientLoading());
      final result =
          await _addPatientRepository.checkPatient(phone_no: phone_no);
      if (result.data != null) {
        if (result.data!.userStatus != null) {
          if (result.data!.userStatus!) {
            if (result.data!.data != null) {
              emit(AddPatientDataSuccess(
                  msg: result.message ?? "User Found",
                  data: result.data!.data!,
                  isShowPatientView: true,
                  isShowUserView: true,
                  isShowSearchBtn: false,
                  patienID: result.data!.data!.id!.toString(),
                  clearTF: true));
            } else {
              emit(AddPatientFailure(result.message.toString()));
            }
          } else {
            emit(AddPatientDataSuccess(
                msg: result.message ?? "User not Found",
                data: result.data!.data!,
                isShowPatientView: false,
                isShowUserView: true,
                isShowSearchBtn: false,
                patienID: "",
                clearTF: true));
          }
        } else {
          emit(AddPatientFailure(result.message.toString()));
        }
      } else {
        emit(AddPatientFailure(result.message.toString()));
      }
    } catch (e) {
      print(e);
      emit(AddPatientFailure(e.toString().contains(ErrorMessageKeys.noInternet)
          ? ErrorMessageKeys.noInternet
          : ErrorMessageKeys.defaultErrorMessage));
    }
  }

  void setInit() {
    emit(AddPatientLoading(
        isShowSearchBtn: true,
        isShowPatientView: false,
        isShowUserView: false));
  }

  bool setState(String value) {
    if (value.isNotEmpty && value != "0") {
      return true;
    }
    return false;
  }
}
