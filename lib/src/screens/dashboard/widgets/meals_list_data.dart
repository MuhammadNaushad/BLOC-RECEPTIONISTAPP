class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/images/patient_m.png',
      titleTxt: 'Patient\nManagement',
      meals: <String>[
        '',
      ],
      /* startColor: '#1CC88A',
      endColor: '#1CC88A', */
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    /* MealsListData(
      imagePath: 'assets/images/doctor_m.png',
      titleTxt: 'Doctor\nManagement',
      meals: <String>[''],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ), */
    MealsListData(
      imagePath: 'assets/images/appointment_book.png',
      titleTxt: 'Appointment\nManagement',
      // kacl: 567,
      meals: <String>[''],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
    MealsListData(
      imagePath: 'assets/images/assign_schedule.png',
      titleTxt: 'Assign Schedule',
      meals: <String>[''],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
  ];
}
