import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/common/widgets/primary_textfield.dart';
import 'package:yslcrm/src/screens/profile/controllers/my_profile_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';
import 'package:get/get.dart';

import 'currency_dropD.dart';
import 'vendorCat_dropD.dart';

class ProfileDetails extends GetView<MyProfileController> with CommonWidget {
  const ProfileDetails({super.key});

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
                        children: [
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.vendorCodeCtrler,
                            isVerticalLabel: true,
                            label: 'Vendor Code *',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.companyCtrler,
                            isVerticalLabel: true,
                            label: 'Company *',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.vatNoCtrler,
                            isVerticalLabel: true,
                            label: 'VAT Number',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.phoneCtrler,
                            isVerticalLabel: true,
                            label: 'Phone',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.websiteCtrler,
                            isVerticalLabel: true,
                            label: 'Website',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          VendorCatDropDowPage(),
                          SizedBox(height: 7.0),
                          CurrencyDropDowPage(),
                          SizedBox(height: 14.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.addressCtrler,
                            isVerticalLabel: true,
                            label: 'Address',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.cityCtrler,
                            isVerticalLabel: true,
                            label: 'City',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.stateCtrler,
                            isVerticalLabel: true,
                            label: 'State',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.zipcodeCtrler,
                            isVerticalLabel: true,
                            label: 'Zipcode',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.countryCtrler,
                            isVerticalLabel: true,
                            label: 'Country',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.bankDetailsCtrler,
                            isVerticalLabel: true,
                            label: 'Bank Details',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                            maxLines: 2,
                          ),
                          SizedBox(height: 7.0),
                          PrimaryTextField(
                            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
                            controller: MyProfileController.paymentTermsCtrler,
                            isVerticalLabel: true,
                            label: 'Payment Terms',
                            keyboardType: TextInputType.text,
                            inputDecoration: textFieldStyle2(),
                            inputTextColor: AppColors.PRIMARY_LIGHT,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
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
