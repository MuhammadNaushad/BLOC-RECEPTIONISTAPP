import 'package:flutter_bloc/flutter_bloc.dart';

sealed class PatientSearchBarState {}

final class PatientSearchBarStateInitila extends PatientSearchBarState {
  final bool isShowCrossBtn;
  PatientSearchBarStateInitila(this.isShowCrossBtn);
}

class PatientSearchBarCubit extends Cubit<PatientSearchBarState> {
  PatientSearchBarCubit() : super(PatientSearchBarStateInitila(false));

  Future<void> showHideCrossBtn(bool isShowCrossBtn) async {
    emit(PatientSearchBarStateInitila(isShowCrossBtn));
  }
}
