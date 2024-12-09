import 'package:flutter/cupertino.dart';
import 'package:yslcrm/src/common/widgets/fade_in_animation.dart';

extension ListUtils<T> on List<T> {
  num sumBy(num f(T element)) {
    num sum = 0;
    for (var item in this) {
      sum += f(item);
    }
    return sum;
  }
}

extension WidgetExtention on Widget {
  Align alignAtStart() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: this,
    );
  }

  Align alignAtEnd() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: this,
    );
  }

  Align alignAtCenter() {
    return Align(
      alignment: AlignmentDirectional.center,
      child: this,
    );
  }
}

extension StringExtension on String {
  String get addOverFlow {
    if (length < 15) {
      return this;
    } else {
      return "${substring(0, 15)}...";
    }
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var result = <T>[];
    forEach(
      (element) {
        if (!result
            .any((x) => getCompareValue(x) == getCompareValue(element))) {
          result.add(element);
        }
      },
    );
    return result;
  }
}

/* extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) {
    return FadeInAnimation(delay: delay, child: this);
  }
} */
