import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/widgets/appBar.dart';
import 'package:yslcrm/src/common/widgets/errorContainerWidget.dart';
import 'package:yslcrm/src/common/widgets/shimmers.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import 'package:yslcrm/src/screens/patients_management/cubit/patient_cubit.dart';
import 'package:yslcrm/src/screens/patients_management/cubit/searchbar_cubit.dart';
import 'package:yslcrm/src/screens/patients_management/widgets/patients_searchbar.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/ErrorMessageKeys.dart';
import 'package:yslcrm/src/utils/colors.dart';

import '../../utils/utilities.dart';
import 'widgets/patient_list_main.dart';

class PatientManagementBLOC extends StatefulWidget {
  @override
  State<PatientManagementBLOC> createState() => _PatientManagementBLOCState();
}

class _PatientManagementBLOCState extends State<PatientManagementBLOC>
    with TickerProviderStateMixin {
  late final ScrollController controller = ScrollController()
    ..addListener(hasMoreNotiScrollListener);
  AnimationController? animationController;
  int _page = 1;
  final searchCtrler = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    searchCtrler..addListener(listenTf);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    await context.read<PatientCubit>().getPatient(page: _page.toString());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(viewType: 'Patients Management'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: BlocConsumer<PatientCubit, PatientState>(
          listener: (context, state) {
            if (state is PatientDataSuccess) {
              if (state.clearTF) {
                searchCtrler.text = "";
              }
              Utilities.showToast(message: state.msg);
            }
            if (state is PatientFailure) {
              Utilities.showToast(message: state.msg);
            }
          },
          builder: (context, state) {
            if (state is PatientDataSuccess) {
              final patientList = state.data;
              return Column(children: [
                PatientSearchBar(searchCntler: searchCtrler),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                      child: Text(
                        "Swipe left for more actions",
                        style: TextStyle(
                            color: AppColors.LIGHT_BLACK.withOpacity(0.8)),
                      ),
                    )),
                Expanded(
                  child: PatientsListMain(
                    data: patientList,
                    hasMore: state.hasMore,
                    hasMoreFetchError: state.hasMoreFetchError,
                    animationController: animationController!,
                    pController: controller,
                    page: _page.toString(),
                  ),
                )
              ]);
            }
            if (state is PatientFailure) {
              return ErrorContainerWidget(
                  errorMsg: (state.msg.contains(ErrorMessageKeys.noInternet))
                      ? "No Internet Available"
                      : 'No Data Found',
                  onRetry: _init);
            }
            return ShimmerForListView(
              height: Get.height * .16,
            );
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Icon(
            Icons.add,
            color: AppTheme.nearlyWhite,
          ),
          onPressed: () async {
            await Utilities.delay(100);
            final param = {"patient_id": ""};
            final result =
                await Get.toNamed(Routes.AddPatient, arguments: param)!;
            if (result != null) {
              await context.read<PatientCubit>().getPatient(page: "1");
            }
          }),
    );
  }

  void hasMoreNotiScrollListener() async {
    if (controller.position.maxScrollExtent == controller.offset) {
      if (context.read<PatientCubit>().hasMorePatients()) {
        _page++;
        await context.read<PatientCubit>().getMorePatients(
              context,
              page: _page.toString(),
              search: searchCtrler.text,
            );
      }
    }
  }

  void listenTf() async {
    if (searchCtrler.text.length > 0) {
      context.read<PatientSearchBarCubit>().showHideCrossBtn(true);
    } else {
      context.read<PatientSearchBarCubit>().showHideCrossBtn(false);
    }
  }
}
