import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/doctors_management/controllers/doctors_management_cntler.dart';
import 'package:yslcrm/src/screens/patients_management/controllers/patients_management_cntler.dart';
import 'package:yslcrm/src/utils/colors.dart';

class DoctorSearchBar extends GetView<DoctorManageController> {
  const DoctorSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 0, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.WHITE,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 0, top: 0, bottom: 0),
                  child: GetBuilder<DoctorManageController>(builder: (cntler) {
                    return TextField(
                      controller: controller.searchCtrler,
                      onChanged: (v) async {
                        if (v.length == 0) {
                          controller.showSearchClearBtn = false;
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.update();
                          await controller.getDoctorsListData();
                        }
                      },
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                          hintText: 'Search doctors...',
                          suffixIcon: controller.showSearchClearBtn
                              ? Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      await Future.delayed(
                                          Duration(milliseconds: 100));
                                      controller.searchCtrler.text = "";
                                      controller.showSearchClearBtn = false;
                                      controller.update();
                                      await controller.getDoctorsListData();
                                    },
                                    child: new Icon(
                                      Icons.close,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink()),
                    );
                  }),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12.withOpacity(0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await controller.getDoctorsListData(
                      search: controller.searchCtrler.text.trim());
                },
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Icon(Icons.search, size: 21, color: AppColors.WHITE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
