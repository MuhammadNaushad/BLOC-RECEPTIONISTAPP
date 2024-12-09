import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/common/widgets/primary_textfield.dart';
import 'package:yslcrm/src/screens/profile/controllers/my_profile_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class BillingsAndShippings extends GetView<MyProfileController>
    with CommonWidget {
  const BillingsAndShippings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
                decoration: BoxDecoration(
                    color: AppTheme.nearlyWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(22.0),
                      topLeft: Radius.circular(22.0),
                      bottomRight: Radius.circular(22.0),
                      bottomLeft: Radius.circular(22.0),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Billing Address
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Billing Address",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {},
                              child: Ink(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: Text(
                                  "Same as vendor info.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.PRIMARY_COLOR),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppTheme.grey,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.streetBtCtrler,
                        isVerticalLabel: true,
                        label: 'Street',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                        maxLines: 3,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.cityBCtrler,
                        isVerticalLabel: true,
                        label: 'City',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.stateBCtrler,
                        isVerticalLabel: true,
                        label: 'State',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.zipCodeBCtrler,
                        isVerticalLabel: true,
                        label: 'Zip Code',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.CountryBCtrler,
                        isVerticalLabel: true,
                        label: 'Country',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),

                      //Billing Address
                      /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping Address",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {
                                MyProfileController.streetStCtrler.text =
                                    MyProfileController.streetBtCtrler.text;
                                MyProfileController.citySCtrler.text =
                                    MyProfileController.cityBCtrler.text;
                                MyProfileController.stateSCtrler.text =
                                    MyProfileController.stateBCtrler.text;
                                MyProfileController.zipCodeSCtrler.text =
                                    MyProfileController.zipCodeBCtrler.text;
                                MyProfileController.CountrySCtrler.text =
                                    MyProfileController.CountryBCtrler.text;
                              },
                              child: Ink(
                                padding:
                                    EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                                child: Text(
                                  "Copy billing address",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.PRIMARY_COLOR),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppTheme.grey,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.streetStCtrler,
                        isVerticalLabel: true,
                        label: 'Street',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                        maxLines: 3,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.citySCtrler,
                        isVerticalLabel: true,
                        label: 'City',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.stateSCtrler,
                        isVerticalLabel: true,
                        label: 'State',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.zipCodeSCtrler,
                        isVerticalLabel: true,
                        label: 'Zip Code',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),
                      SizedBox(height: 7.0),
                      PrimaryTextField(
                        vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                        controller: MyProfileController.CountrySCtrler,
                        isVerticalLabel: true,
                        label: 'Country',
                        keyboardType: TextInputType.text,
                        inputDecoration: textFieldStyle2(),
                        inputTextColor: AppColors.PRIMARY_LIGHT,
                      ),
                      */
                      // SizedBox(height: 20.0),
                      /* CommonWidget.commonButton(
                          text: 'Done',
                          onPressed: () async {
                            Utilities.delay(100);
                          }) */
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: AppTheme.nearlyWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0.0),
              topLeft: Radius.circular(0.0),
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: CommonWidget.commonButton(
              text: 'Save',
              onPressed: () async {
                Utilities.delay(100);
                FocusManager.instance.primaryFocus?.unfocus();
                controller.validation();
              }),
        ),
      ),
    );
  }
}
