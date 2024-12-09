import 'package:flutter/material.dart';
import 'package:yslcrm/src/utils/colors.dart';

import 'billing_n_shipping.dart';
import 'profile_details.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: AppColors.PRIMARY_COLOR,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Vendor Details',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Billing & Shipping',
                ),
              ],
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [ProfileDetails(), BillingsAndShippings()],
            ),
          ),
        ],
      ),
    );
  }
}
