import 'package:etisalat/files/common/number_pagination.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:flutter/material.dart';

Widget numberPagination({int totalCount = 0, Function(int)? onTap}) {
  return Visibility(
    visible: (totalCount > pagePerCount),
    child: NumberPagination(
      totalItem: totalCount,
      tappedIndex: (index) {
        if (onTap != null) {
          onTap(index * pagePerCount);
        }
      },
    ),
  );
}
