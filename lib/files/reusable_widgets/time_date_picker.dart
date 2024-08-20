import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Widget timeDatePicker(bool onlyTime) {
  return Center(
    child: Material(
      color: transparent,
      child: ResponsiveBuilder(
        builder: (context, si) {
          return Container(
            width: si.isMobile ? 300 : null,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                dateAndTimeContainer(si, onlyTime),
                customDivider(si),
                _bottomButtons(context)
              ],
            ),
          );
        },
      ),
    ),
  );
}

Padding _bottomButtons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        confirmButton(),
        const SizedBox(width: 14),
        cancelButton(context)
      ],
    ),
  );
}

SizedBox customDivider(SizingInformation si) {
  return si.isMobile
      ? SizedBox(
          child: Container(height: 1, color: lightGrey),
        )
      : SizedBox(child: Container(height: 1, width: 400, color: lightGrey));
}

GenericButton cancelButton(BuildContext context) {
  return GenericButton(
    height: 35,
    bgColor: white,
    fontName: FontName.regular,
    borderColor: lightGrey,
    title: cancelStr,
    padding: EdgeInsets.symmetric(horizontal: 20),
    onTap: () {
      Navigator.of(context).pop();
    },
  );
}

GenericButton confirmButton() {
  return GenericButton(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 35,
    bgColor: yellow,
    fontName: FontName.regular,
    title: confirmStr,
  );
}

Widget dateAndTimeContainer(SizingInformation si, bool onlyTime) {
  return si.isMobile
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            onlyTime
                ? const SizedBox()
                : SizedBox(height: 300, child: _calender()),
            SizedBox(height: 130, child: _timePicker()),
          ],
        )
      : onlyTime
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: _timePicker()),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                onlyTime
                    ? const SizedBox()
                    : Flexible(child: SizedBox(width: 300, child: _calender())),
                SizedBox(width: 150, child: _timePicker()),
              ],
            );
}

Widget _calender() {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: lightGrey)),
    child: SfCalendar(
      cellBorderColor: lightGrey,
      headerStyle: CalendarHeaderStyle(
        textStyle: TextStyle(
            color: black, fontSize: 16, fontFamily: FontName.bold.name),
        textAlign: TextAlign.center,
      ),
      viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(fontFamily: FontName.semiBold.name),
          dateTextStyle:
              TextStyle(color: black, fontFamily: FontName.bold.name)),
      monthViewSettings: _monthCellDecoration(),
      selectionDecoration: BoxDecoration(
          border: Border.all(color: yellow, width: 2),
          borderRadius: BorderRadius.circular(4)),
      initialSelectedDate: DateTime.now(),
      onSelectionChanged: (calendarSelectionDetails) {
        print("calendarSelectionDetails === ${calendarSelectionDetails.date}");
      },
      todayTextStyle: TextStyle(color: black, fontFamily: FontName.bold.name),
      firstDayOfWeek: 7,
      view: CalendarView.month,
      initialDisplayDate: DateTime.now(),
      todayHighlightColor: yellow,
      showDatePickerButton: true,
      showCurrentTimeIndicator: true,
      showNavigationArrow: true,
      minDate: DateTime(2021, 03, 05, 10, 0, 0),
      maxDate: DateTime(2080, 03, 05, 10, 0, 0),
    ),
  );
}

MonthViewSettings _monthCellDecoration() {
  return MonthViewSettings(
    showAgenda: false,
    monthCellStyle: MonthCellStyle(
        textStyle:
            TextStyle(fontFamily: FontName.regular.name, color: Colors.black),
        leadingDatesTextStyle:
            TextStyle(fontFamily: FontName.regular.name, color: Colors.grey),
        trailingDatesTextStyle:
            TextStyle(fontFamily: FontName.regular.name, color: Colors.grey)),
  );
}

Widget _timePicker() {
  return Container(
    height: 20,
    width: 30,
    color: red,
  );
}
