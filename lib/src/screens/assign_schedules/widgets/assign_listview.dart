import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/models/schedule_management/get_all_slot_model.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/utils/hex_color.dart';

import '../controllers/assign_schedule_cntler.dart';

class AssignScheduleListView extends GetView<AssignScheduleController> {
  const AssignScheduleListView(
      {Key? key,
      this.data,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final SlotData? data;
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
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 4, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(2.5, 2.5),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextIcon(
                                            textStyle: AppTheme.title,
                                            text: "${data!.timeSlots!}",
                                            prefix: Icon(Icons.schedule,
                                                size: 18,
                                                color: AppTheme.nearlyBlack),
                                            expandedText: false,
                                            useMarquee: true,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: HexColor("#FA7D82"),
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
                                              text:
                                                  "${data!.id!}", //providerData.email.validate(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /* TextIcon(
                                        spacing: 7,
                                        textStyle: AppTheme.caption,
                                        onTap: () {
                                          // launchMail("${widget.providerData.email.validate()}");
                                        },
                                        prefix: Image.asset(Constant.emailIcon,
                                            width: 16,
                                            height: 16,
                                            color: Colors.black),
                                        text:
                                            "${data!.email!}", //providerData.email.validate(),
                                        expandedText: true,
                                        useMarquee: true,
                                      ), */
                                      TextIcon(
                                        spacing: 7,
                                        textStyle: AppTheme.caption,
                                        onTap: () {
                                          // launchMail("${widget.providerData.email.validate()}");
                                        },
                                        prefix: Icon(Icons.token_outlined,
                                            size: 18,
                                            color: AppTheme.nearlyBlack),
                                        text:
                                            "${data!.noOfTokens}", //providerData.email.validate(),
                                        expandedText: true,
                                        useMarquee: true,
                                      ),
                                      /* Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: TextIcon(
                                              spacing: 7,
                                              textStyle: AppTheme.caption,
                                              onTap: () {
                                                // launchMail("${widget.providerData.email.validate()}");
                                              },
                                              prefix: Image.asset(
                                                  Constant.personIcon,
                                                  width: 16,
                                                  height: 16,
                                                  color: Colors.black),
                                              text:
                                                  "${data!.gender!}", //providerData.email.validate(),
                                              expandedText: false,
                                              useMarquee: false,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: TextIcon(
                                              spacing: 7,
                                              textStyle: AppTheme.caption,
                                              onTap: () {
                                                // launchMail("${widget.providerData.email.validate()}");
                                              },
                                              prefix: Image.asset(
                                                  Constant.calendarIcon,
                                                  width: 16,
                                                  height: 16,
                                                  color: AppTheme.dark_grey),
                                              text:
                                                  "${data!.age!}", //providerData.email.validate(),
                                              expandedText: false,
                                              useMarquee: false,
                                            ),
                                          ),
                                        ],
                                      ), */
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
