import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yslcrm/src/data/repositories/patient_management/patient_repository.dart';
import 'package:yslcrm/src/models/patients_management/get_all_patients_model.dart';
import 'package:yslcrm/src/utils/ErrorMessageKeys.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientRepository _patientRepository = PatientRepository();
  PatientCubit() : super(PatientLoading());

  Future<void> getPatient({
    String page = "1",
    String search = "",
  }) async {
    try {
      emit(PatientLoading());
      final result =
          await _patientRepository.getPatients(page: page, search: search);
      if (result.data != null) {
        if (result.data!.basedata != null) {
          if (result.data!.basedata!.isNotEmpty) {
            emit(PatientDataSuccess(
                data: result.data!.basedata!,
                msg: result.message ?? "Data Fetched Successfully",
                hasMore: result.data!.basedata!.length > 0 ? true : false,
                hasMoreFetchError: false,
                clearTF: true));
          } else {
            emit(PatientFailure(ErrorMessageKeys.noDataMessage));
          }
        } else {
          emit(PatientFailure(ErrorMessageKeys.noDataMessage));
        }
      } else {
        emit(PatientFailure(ErrorMessageKeys.noDataMessage));
      }
    } catch (e) {
      print(e);
      emit(PatientFailure(e.toString()));
    }
  }

  bool hasMorePatients() {
    return (state is PatientDataSuccess)
        ? (state as PatientDataSuccess).hasMore
        : false;
  }

  Future<void> getMorePatients(
    BuildContext context, {
    required String page,
    String search = "",
  }) async {
    if ((state is PatientDataSuccess)) {
      try {
        final result =
            await _patientRepository.getPatients(page: page, search: search);
        if (result.data != null) {
          if (result.data!.basedata != null) {
            if (result.data!.basedata!.isNotEmpty) {
              final List<PatientData> patientList =
                  (state as PatientDataSuccess).data;
              patientList.addAll(result.data!.basedata!);
              emit(PatientDataSuccess(
                  data: patientList,
                  msg: result.message ?? "Data Fetched Successfully",
                  hasMore: result.data!.basedata!.isNotEmpty ? true : false,
                  hasMoreFetchError: false));
            } else {
              emit(PatientDataSuccess(
                  data: (state as PatientDataSuccess).data,
                  msg: (state as PatientDataSuccess).msg,
                  hasMore: (state as PatientDataSuccess).hasMore,
                  hasMoreFetchError: true));
            }
          } else {
            emit(PatientDataSuccess(
                data: (state as PatientDataSuccess).data,
                msg: (state as PatientDataSuccess).msg,
                hasMore: (state as PatientDataSuccess).hasMore,
                hasMoreFetchError: true));
          }
        } else {
          emit(PatientDataSuccess(
              data: (state as PatientDataSuccess).data,
              msg: (state as PatientDataSuccess).msg,
              hasMore: (state as PatientDataSuccess).hasMore,
              hasMoreFetchError: true));
        }
      } catch (e) {
        print(e);
        emit(PatientDataSuccess(
            data: (state as PatientDataSuccess).data,
            msg: e.toString(),
            hasMore: (state as PatientDataSuccess).hasMore,
            hasMoreFetchError: true));
      }
    }
  }
}
