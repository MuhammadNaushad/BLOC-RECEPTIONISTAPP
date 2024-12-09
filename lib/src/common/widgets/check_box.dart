import 'package:flutter/material.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          onChanged(!value);
        },
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: value,
                    onChanged: (bool? newValue) {
                      onChanged(newValue!);
                    },
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  label,
                  style: Constant.dashCountTS(
                      14, FontWeight.w400, AppColors.PRIMARY_COLOR),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
