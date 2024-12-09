class MyProfileModel {
  bool? success;
  String? message;
  ProfileData? data;

  MyProfileModel({this.success, this.message, this.data});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }
}

class ProfileData {
  Client? client;
  String? title;
  List<CurrencyList>? currencyList;
  List<VendorCategory>? vendorCategory;

  ProfileData(
      {this.client, this.title, this.currencyList, this.vendorCategory});

  ProfileData.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    title = json['title'];
    if (json['currency_list'] != null) {
      currencyList = <CurrencyList>[];
      json['currency_list'].forEach((v) {
        currencyList!.add(new CurrencyList.fromJson(v));
      });
    }
    if (json['vendor_category'] != null) {
      vendorCategory = <VendorCategory>[];
      json['vendor_category'].forEach((v) {
        vendorCategory!.add(new VendorCategory.fromJson(v));
      });
    }
  }
}

class Client {
  String? userid;
  String? company;
  String? vat;
  String? phonenumber;
  String? country;
  String? city;
  String? zip;
  String? state;
  String? address;
  String? website;
  String? datecreated;
  String? active;
  String? leadid;
  String? billingStreet;
  String? billingCity;
  String? billingState;
  String? billingZip;
  String? billingCountry;
  String? shippingStreet;
  String? shippingCity;
  String? shippingState;
  String? shippingZip;
  String? shippingCountry;
  String? longitude;
  String? latitude;
  String? defaultLanguage;
  String? defaultCurrency;
  String? showPrimaryContact;
  String? stripeId;
  String? registrationConfirmed;
  String? addedfrom;
  List<dynamic>? category;
  String? bankDetail;
  String? paymentTerms;
  String? vendorCode;
  String? returnWithinDay;
  String? returnOrderFee;
  String? returnPolicies;

  Client(
      {this.userid,
      this.company,
      this.vat,
      this.phonenumber,
      this.country,
      this.city,
      this.zip,
      this.state,
      this.address,
      this.website,
      this.datecreated,
      this.active,
      this.leadid,
      this.billingStreet,
      this.billingCity,
      this.billingState,
      this.billingZip,
      this.billingCountry,
      this.shippingStreet,
      this.shippingCity,
      this.shippingState,
      this.shippingZip,
      this.shippingCountry,
      this.longitude,
      this.latitude,
      this.defaultLanguage,
      this.defaultCurrency,
      this.showPrimaryContact,
      this.stripeId,
      this.registrationConfirmed,
      this.addedfrom,
      this.category,
      this.bankDetail,
      this.paymentTerms,
      this.vendorCode,
      this.returnWithinDay,
      this.returnOrderFee,
      this.returnPolicies});

  Client.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    company = json['company'];
    vat = json['vat'];
    phonenumber = json['phonenumber'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    state = json['state'];
    address = json['address'];
    website = json['website'];
    datecreated = json['datecreated'];
    active = json['active'];
    leadid = json['leadid'];
    billingStreet = json['billing_street'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    billingZip = json['billing_zip'];
    billingCountry = json['billing_country'];
    shippingStreet = json['shipping_street'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    shippingZip = json['shipping_zip'];
    shippingCountry = json['shipping_country'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    defaultLanguage = json['default_language'];
    defaultCurrency = json['default_currency'];
    showPrimaryContact = json['show_primary_contact'];
    stripeId = json['stripe_id'];
    registrationConfirmed = json['registration_confirmed'];
    addedfrom = json['addedfrom'];
    category = json['category'];
    bankDetail = json['bank_detail'];
    paymentTerms = json['payment_terms'];
    vendorCode = json['vendor_code'];
    returnWithinDay = json['return_within_day'];
    returnOrderFee = json['return_order_fee'];
    returnPolicies = json['return_policies'];
  }
}

class CurrencyList {
  String? id;
  String? text;

  CurrencyList({this.id, this.text});

  CurrencyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'] ?? "";
  }
}

class VendorCategory {
  String? id;
  String? categoryName;
  String? description;

  VendorCategory({this.id, this.categoryName, this.description});

  VendorCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'] ?? "";
    description = json['description'] ?? "";
  }
}
