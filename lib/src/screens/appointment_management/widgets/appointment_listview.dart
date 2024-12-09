import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/appointment_management/get_all_appoint_data_model.dart';
import 'package:yslcrm/src/models/patients_management/get_all_patients_model.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/appointment_management/edit_appointment/controllers/edit_appointment_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/hex_color.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../controllers/appointment_management_cntler.dart';
import 'appointment_status_dropD.dart';
import 'token_status_dropD.dart';

class AppointmentListView extends GetView<AppointmentManagementController> {
  const AppointmentListView(
      {Key? key,
      this.data,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final AppointmentData? data;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 10),
              child: GetBuilder<AppointmentManagementController>(
                  builder: (cntler) {
                return Row(
                  children: [
                    data!.isSelected!
                        ? Checkbox(
                            activeColor: Colors.blueGrey,
                            value: data!.isSelected!,
                            onChanged: (_) {
                              print("onChanged press");
                              data!.isSelected = !data!.isSelected!;
                              HapticFeedback.vibrate();
                              controller.isShowSelectAllBtn = true;
                              if (data!.isSelected!) {
                                controller.appointmentIdListToPost
                                    .add(data!.id.toString());
                              } else {
                                controller.appointmentIdListToPost
                                    .remove(data!.id.toString());
                              }
                              if (controller.appointmentIdListToPost.isEmpty) {
                                controller.isShowSelectAllBtn = false;
                              }
                              debugPrint(
                                  "AppointmentIDList: ${controller.appointmentIdListToPost.toString()}");
                              controller.update();
                            })
                        : SizedBox.shrink(),
                    Expanded(
                      child: GestureDetector(
                        onLongPress: () {
                          /* print("Long press");
                          data!.isSelected = !data!.isSelected!;
                          HapticFeedback.vibrate();
                          controller.isShowSelectAllBtn = true;
                          if (data!.isSelected!) {
                            controller.appointmentIdListToPost
                                .add(data!.id.toString());
                          } else {
                            controller.appointmentIdListToPost
                                .remove(data!.id.toString());
                          }
                          if (controller.appointmentIdListToPost.isEmpty) {
                            controller.isShowSelectAllBtn = false;
                          }
                          debugPrint(
                              "AppointmentIDList: ${controller.appointmentIdListToPost.toString()}");
                          controller.update(); */
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: data!.isSelected!
                                ? Colors.blueGrey
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(2.5, 2.5),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.transparent,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: !data!.isSelected!
                                                ? Colors.blueGrey
                                                : Colors.white,
                                            child: Text(
                                              "${data!.name![0].capitalize}",
                                              style: AppTheme.title.copyWith(
                                                fontSize: 19,
                                                color: data!.isSelected!
                                                    ? Colors.blueGrey
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                          4.width,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: TextIcon(
                                                        textStyle: AppTheme
                                                            .title
                                                            .copyWith(
                                                          color: data!
                                                                  .isSelected!
                                                              ? Colors.white
                                                              : AppTheme
                                                                  .nearlyBlack,
                                                        ),
                                                        text:
                                                            "${data!.name!.capitalize}", //providerData.email.validate(),
                                                        expandedText: true,
                                                        useMarquee: true,
                                                      ),
                                                    ),
                                                    Obx(() {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: data!.status!
                                                                          .value ==
                                                                      "0" ||
                                                                  data!.status!
                                                                          .value ==
                                                                      "Completed"
                                                              ? AppColors
                                                                  .PRIMARY_COLOR
                                                              : HexColor(
                                                                  "#FA7D82"),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          50.0)),
                                                          boxShadow: <BoxShadow>[
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              offset:
                                                                  const Offset(
                                                                      2.5, 2.5),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                        child: TextIcon(
                                                          textStyle: AppTheme
                                                              .title
                                                              .copyWith(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .white),
                                                          text: data!.status!
                                                                      .value ==
                                                                  "0"
                                                              ? "Active"
                                                              : "${data!.status!.value}", //providerData.email.validate(),
                                                        ),
                                                      );
                                                    }),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Material(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Utilities
                                                                .delay(100);

                                                            final param = {
                                                              "id": data!.id
                                                                  .toString(),
                                                              "doctor_id": data!
                                                                  .doctorId
                                                                  .toString(),
                                                              "slot_id": data!
                                                                  .availId
                                                                  .toString(),
                                                              "time_slot": data!
                                                                  .timeSlots
                                                                  .toString(),
                                                              "status": data!
                                                                  .status
                                                                  .toString(),
                                                              "token_status": data!
                                                                  .tokenStatus
                                                                  .toString(),
                                                              "date": data!.date
                                                                  .toString(),
                                                              "amount": data!
                                                                  .price
                                                                  .toString()
                                                            };
                                                            debugPrint(param
                                                                .toString());
                                                            final result =
                                                                await Get.toNamed(
                                                                    Routes
                                                                        .EditAppointment,
                                                                    parameters:
                                                                        param)!;
                                                            if (result !=
                                                                null) {
                                                              await controller
                                                                  .getAppointmentListData();
                                                            }
                                                          },
                                                          child: Ink(
                                                            child: Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 18,
                                                              color: AppTheme
                                                                  .dark_grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                TextIcon(
                                                  spacing: 7,
                                                  textStyle:
                                                      AppTheme.caption.copyWith(
                                                    color: data!.isSelected!
                                                        ? Colors.white
                                                        : AppTheme.nearlyBlack,
                                                  ),
                                                  onTap: () {
                                                    // launchMail("${widget.providerData.email.validate()}");
                                                  },
                                                  prefix: Image.asset(
                                                    Constant.callIcon,
                                                    width: 16,
                                                    height: 16,
                                                    color: data!.isSelected!
                                                        ? Colors.white
                                                        : AppTheme.nearlyBlack,
                                                  ),
                                                  text:
                                                      "${data!.phone!}", //providerData.email.validate(),
                                                  expandedText: true,
                                                  useMarquee: true,
                                                ),
                                                TextIcon(
                                                  spacing: 7,
                                                  textStyle:
                                                      AppTheme.caption.copyWith(
                                                    color: data!.isSelected!
                                                        ? Colors.white
                                                        : AppTheme.nearlyBlack,
                                                  ),
                                                  onTap: () {
                                                    // launchMail("${widget.providerData.email.validate()}");
                                                  },
                                                  prefix: Image.asset(
                                                    Constant.personIcon,
                                                    width: 16,
                                                    height: 16,
                                                    color: data!.isSelected!
                                                        ? AppTheme.notWhite
                                                        : AppTheme.nearlyBlack,
                                                  ),
                                                  text:
                                                      "${data!.doctorName}", //providerData.email.validate(),
                                                  expandedText: true,
                                                  useMarquee: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Divider(
                                    color: data!.isSelected!
                                        ? AppTheme.notWhite
                                        : AppTheme.lightText.withOpacity(0.5),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Date",
                                                    style:
                                                        AppTheme.title.copyWith(
                                                      fontSize: 14,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                                Text("${data!.date}",
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      fontSize: 13.5,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Slot",
                                                    style:
                                                        AppTheme.title.copyWith(
                                                      fontSize: 14,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                                /* Divider(
                                                  height: 1.4,
                                                  color: data!.isSelected!
                                                      ? AppTheme.notWhite
                                                      : AppTheme.lightText
                                                          .withOpacity(0.5),
                                                ), */
                                                Text("${data!.timeSlots}",
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      fontSize: 13.5,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Token No.",
                                                    style:
                                                        AppTheme.title.copyWith(
                                                      fontSize: 14,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                                Text("${data!.token}",
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      fontSize: 13.5,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Token Status",
                                                    style:
                                                        AppTheme.title.copyWith(
                                                      fontSize: 14,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                                /* Divider(
                                                  height: 1.4,
                                                  color: data!.isSelected!
                                                      ? AppTheme.notWhite
                                                      : AppTheme.lightText
                                                          .withOpacity(0.5),
                                                ), */
                                                Obx(() {
                                                  return Text(
                                                      data!.tokenStatus!
                                                                  .value ==
                                                              "1"
                                                          ? "Active"
                                                          : data!.tokenStatus!
                                                                      .value ==
                                                                  "2"
                                                              ? "InProgress"
                                                              : data!.tokenStatus!
                                                                          .value ==
                                                                      "3"
                                                                  ? "Cancelled"
                                                                  : "Completed",
                                                      style: AppTheme.caption
                                                          .copyWith(
                                                        fontSize: 13.5,
                                                        color: data!.isSelected!
                                                            ? AppTheme.notWhite
                                                            : AppTheme
                                                                .nearlyBlack,
                                                      ));
                                                }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Price",
                                                    style:
                                                        AppTheme.title.copyWith(
                                                      fontSize: 14,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                                Text("${data!.price}",
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      fontSize: 13.5,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Payment Mode",
                                                    style:
                                                        AppTheme.title.copyWith(
                                                      fontSize: 14,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                                /* Divider(
                                                  height: 1.4,
                                                  color: data!.isSelected!
                                                      ? AppTheme.notWhite
                                                      : AppTheme.lightText
                                                          .withOpacity(0.5),
                                                ), */
                                                Text(data!.mode.toString(),
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      fontSize: 13.5,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Payment Status",
                                                    style:
                                                        AppTheme.title.copyWith(
                                                      fontSize: 14,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                                Text(
                                                    data!.paymentStatus!
                                                                .toString() ==
                                                            "1"
                                                        ? "Completed"
                                                        : "Pending",
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      fontSize: 13.5,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Receipt No.",
                                                        style: AppTheme.title
                                                            .copyWith(
                                                          fontSize: 14,
                                                          color: data!
                                                                  .isSelected!
                                                              ? AppTheme
                                                                  .notWhite
                                                              : AppTheme
                                                                  .nearlyBlack,
                                                        )),
                                                    Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: InkWell(
                                                          onTap: () async {
                                                            if (data!.phone ==
                                                                    null ||
                                                                data!.phone ==
                                                                    "") {
                                                              Utilities.showToast(
                                                                  message:
                                                                      "Mobile number is missing");
                                                            } else if (data!
                                                                        .receipt ==
                                                                    null ||
                                                                data!.receipt ==
                                                                    "") {
                                                              Utilities.showToast(
                                                                  message:
                                                                      "Receipt link not available");
                                                            } else {
                                                              controller.whatsappAPI(
                                                                  phone: data!
                                                                      .phone!,
                                                                  pname: data!
                                                                          .name ??
                                                                      "",
                                                                  recieptURL:
                                                                      "${HttpHelper.whatsappBaseURL}${data!.receipt}");
                                                              /* print(
                                                                  "${HttpHelper.whatsappBaseURL}${data!.receipt}"); */
                                                              /* await controller.whatsappAPI(
                                                                  phone:
                                                                      "9511242559",
                                                                  pname:
                                                                      "Naushad",
                                                                  recieptURL:
                                                                      "${HttpHelper.whatsappBaseURL}${data!.receipt}"); */
                                                            }
                                                          },
                                                          child: Ink(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 7.0,
                                                                      right:
                                                                          7.0),
                                                              child:
                                                                  Image.asset(
                                                                Constant
                                                                    .whatsappIcon,
                                                                height: 15,
                                                              ))),
                                                    ),
                                                    Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: InkWell(
                                                          onTap: () async {
                                                            await controller
                                                                .printPDF(
                                                                    "${HttpHelper.whatsappBaseURL}${data!.receipt}");
                                                          },
                                                          child: Ink(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 5.0,
                                                                      right:
                                                                          00),
                                                              child: Icon(
                                                                Icons
                                                                    .print_outlined,
                                                                size: 20,
                                                              ))),
                                                    )
                                                  ],
                                                ),
                                                /* Divider(
                                                  height: 1.4,
                                                  color: data!.isSelected!
                                                      ? AppTheme.notWhite
                                                      : AppTheme.lightText
                                                          .withOpacity(0.5),
                                                ), */
                                                Text(data!.receiptno.toString(),
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      fontSize: 13.5,
                                                      color: data!.isSelected!
                                                          ? AppTheme.notWhite
                                                          : AppTheme
                                                              .nearlyBlack,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      5.height,
                                      Row(
                                        mainAxisAlignment:
                                            (data!.status.toString() !=
                                                    "Cancelled")
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.center,
                                        children: [
                                          /* Expanded(
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: InkWell(
                                                onTap: () async {
                                                  await Utilities.delay(100);
                                                  controller
                                                      .appointmentIdListToPost
                                                      .clear();
                                                  controller
                                                      .appointmentIdListToPost
                                                      .add(
                                                          data!.id!.toString());
                                                  controller
                                                          .appointmentDDValueToPostServer =
                                                      "Completed";
                                                  await controller
                                                      .changeAppointmentStatus();
                                                },
                                                child: Container(
                                                  height: 27,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.PRIMARY_COLOR,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50.0)),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.6),
                                                        offset: const Offset(
                                                            2.5, 2.5),
                                                        blurRadius: 3,
                                                      ),
                                                    ],
                                                  ),
                                                  child: TextIcon(
                                                    textStyle: AppTheme.title
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                    text: "Completed",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          5.width,
                                          Expanded(
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: InkWell(
                                                onTap: () async {
                                                  await Utilities.delay(100);
                                                  controller
                                                      .appointmentIdListToPost
                                                      .clear();
                                                  controller
                                                      .appointmentIdListToPost
                                                      .add(
                                                          data!.id!.toString());
                                                  controller
                                                          .appointmentDDValueToPostServer =
                                                      "Cancelled";
                                                  await controller
                                                      .changeAppointmentStatus();
                                                },
                                                child: Container(
                                                  height: 27,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: HexColor("#FA7D82"),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50.0)),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.6),
                                                        offset: const Offset(
                                                            2.5, 2.5),
                                                        blurRadius: 3,
                                                      ),
                                                    ],
                                                  ),
                                                  child: TextIcon(
                                                    textStyle: AppTheme.title
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                    text: "Cancelled",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ), */
                                          if (data!.status.toString() !=
                                              "Cancelled")
                                            Expanded(
                                                child: Container(
                                                    height: 27,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blueGrey,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  50.0)),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.6),
                                                          offset: const Offset(
                                                              2.5, 2.5),
                                                          blurRadius: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    child:
                                                        AppointmentStatusDropDown(
                                                      appointmmentId: data!.id!,
                                                    )))
                                          else
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                  height: 27,
                                                  width: Get.width * .5,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50.0)),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.6),
                                                        offset: const Offset(
                                                            2.5, 2.5),
                                                        blurRadius: 3,
                                                      ),
                                                    ],
                                                  ),
                                                  child:
                                                      AppointmentStatusDropDown(
                                                    appointmmentId: data!.id!,
                                                  )),
                                            ),
                                          5.width,
                                          if (data!.status.toString() !=
                                              "Cancelled")
                                            Expanded(
                                                child: Container(
                                                    height: 27,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blueGrey,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  50.0)),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.6),
                                                          offset: const Offset(
                                                              2.5, 2.5),
                                                          blurRadius: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    child: TokenStatusDropDown(
                                                      appointmmentId: data!.id!,
                                                    )))
                                          /* Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                  offset:
                                                      const Offset(2.5, 2.5),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: TextIcon(
                                              textStyle: AppTheme.title
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                              text: "Token Status",
                                            ),
                                          ), */
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                15.height,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
