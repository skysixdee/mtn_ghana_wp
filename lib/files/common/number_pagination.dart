import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:flutter/material.dart';

import 'package:number_paginator/number_paginator.dart';

Widget numberPagination(
    {required int totalCount,
    NumberPaginatorController? numberPaginatorController,
    int? currentPage,
    required Function(int) onTap}) {
  return Visibility(
    visible: (totalCount > pagePerCount),
    child: _NumberPagination(
      numberPaginatorController: numberPaginatorController,
      totalItem: totalCount,
      currentPage: currentPage,
      tappedIndex: (index) {
        onTap(index * pagePerCount);
      },
    ),
  );
}

class _NumberPagination extends StatefulWidget {
  const _NumberPagination(
      {super.key,
      required this.totalItem,
      required this.tappedIndex,
      this.numberPaginatorController,
      this.currentPage});
  final int totalItem;
  final int? currentPage;
  final Function(int) tappedIndex;
  final NumberPaginatorController?
      numberPaginatorController; // = NumberPaginatorController();
  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<_NumberPagination> {
  int _numPages = 0;
  //int _currentPage = 0;
  @override
  void initState() {
    var anc = (widget.totalItem / pagePerCount).ceil(); //.floor(); //
    _numPages = anc;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkTheme(context) ? yellowD : yellow,
      child: NumberPaginator(
        initialPage: widget.currentPage ?? 0,
        config: NumberPaginatorUIConfig(
          height: 40,
          buttonPadding: const EdgeInsets.all(0),
          buttonTextStyle: TextStyle(
              fontFamily: FontName.bold.name, fontSize: 12, color: white),
          buttonUnselectedForegroundColor: black,
          buttonSelectedBackgroundColor: black,
        ),
        controller:
            widget.numberPaginatorController ?? NumberPaginatorController(),
        numberPages: _numPages,
        onPageChange: (int index) {
          widget.tappedIndex(index);
          setState(() {
            //_currentPage = index;
            customPrint("Page tapped $index");
          });
        },
      ),
    );
  }
}
