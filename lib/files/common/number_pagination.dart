import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:flutter/material.dart';

import 'package:number_paginator/number_paginator.dart';

class NumberPagination extends StatefulWidget {
  const NumberPagination(
      {super.key, required this.totalItem, required this.tappedIndex});
  final int totalItem;
  final Function(int) tappedIndex;
  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  NumberPaginatorController controller = NumberPaginatorController();
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
    return NumberPaginator(
      config: NumberPaginatorUIConfig(
        height: 40,
        buttonPadding: const EdgeInsets.all(0),
        buttonTextStyle:
            TextStyle(fontFamily: FontName.bold.name, fontSize: 12),
        buttonUnselectedForegroundColor: black,
        buttonSelectedBackgroundColor: yellow,
      ),
      controller: controller,
      numberPages: _numPages,
      onPageChange: (int index) {
        widget.tappedIndex(index);
        setState(() {
          //_currentPage = index;
          customPrint("Page tapped $index");
        });
      },
    );
  }
}
