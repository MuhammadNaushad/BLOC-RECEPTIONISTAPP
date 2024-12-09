import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yslcrm/src/common/widgets/shimmer_widget.dart';

class ShimmerForListView extends StatelessWidget {
  final double? height;
  final double? width;
  const ShimmerForListView({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.transparent,
        direction: ShimmerDirection.ltr,
        period: Duration(seconds: 1),
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(
                    child: Container(
                      width: Get.width * .75,
                      height: 50,
                      decoration: boxDecorationWithRoundedCorners(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
                          ),
                          backgroundColor: context.cardColor),
                    ),
                  ),
                  ShimmerWidget(child: CircleAvatar())
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    //scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ShimmerWidget(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Container(
                            width: Get.width,
                            height: height ?? Get.height * 0.18,
                            decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: context.cardColor),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
