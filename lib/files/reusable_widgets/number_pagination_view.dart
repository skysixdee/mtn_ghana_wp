import 'package:etisalat/files/common/number_pagination.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

Widget numberPagination(
    {int totalCount = 0,
    NumberPaginatorController? numberPaginatorController,
    Function(int)? onTap}) {
  return Visibility(
    visible: (totalCount > pagePerCount),
    child: NumberPagination(
      numberPaginatorController: numberPaginatorController,
      totalItem: totalCount,
      tappedIndex: (index) {
        if (onTap != null) {
          onTap(index * pagePerCount);
        }
      },
    ),
  );
}
