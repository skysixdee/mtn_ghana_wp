import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeDatePicker extends StatefulWidget {
  TimeDatePicker(
      {super.key, this.dateTime, this.onConfirm, this.onlyTime = false});
  final DateTime? dateTime;
  final bool onlyTime;
  final Function(DateTime)? onConfirm;
  DateTime localDateTime = DateTime.now();
  final RxInt pickedHour = 0.obs;
  final RxInt pickedMinute = 0.obs;
  @override
  State<TimeDatePicker> createState() => _TimeDatePickerState();
}

class _TimeDatePickerState extends State<TimeDatePicker> {
  @override
  void initState() {
    widget.localDateTime = widget.dateTime ?? DateTime.now();
    widget.pickedHour.value = widget.localDateTime.hour;
    widget.pickedMinute.value = widget.localDateTime.minute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: transparent,
        child: ResponsiveBuilder(
          builder: (context, si) {
            return Container(
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
                  dateAndTimeContainer(si),
                  //  customDivider(si),
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
      onTap: () {
        print("date is ${widget.localDateTime}");
        if (widget.onConfirm != null) {
          widget.onConfirm!(widget.localDateTime);
        }
      },
    );
  }

  Widget dateAndTimeContainer(SizingInformation si) {
    return si.isMobile
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.onlyTime ? const SizedBox() : _calender(),
              _timePicker(),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.onlyTime
                  ? const SizedBox()
                  : Flexible(child: SizedBox(child: _calender())),
              _timePicker(),
            ],
          );
  }

  Widget _calender() {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(border: Border.all(color: lightGrey)),
      child: SfCalendar(
        cellBorderColor: lightGrey,
        headerStyle: headerStyle(),
        viewHeaderStyle: viewHeaderStyle(),
        monthViewSettings: _monthCellDecoration(),
        selectionDecoration: dateSectionDecoration(),
        initialSelectedDate: widget.localDateTime,
        onSelectionChanged: (csd) {
          widget.localDateTime = DateTime(
            csd.date?.year ?? 0,
            csd.date?.month ?? 0,
            csd.date?.day ?? 0,
            widget.localDateTime.hour,
            widget.localDateTime.minute,
          );
        },
        todayTextStyle: TextStyle(color: black, fontFamily: FontName.bold.name),
        firstDayOfWeek: 7,
        view: CalendarView.month,
        initialDisplayDate: widget.localDateTime,
        todayHighlightColor: yellow,
        showDatePickerButton: true,
        showCurrentTimeIndicator: true,
        showNavigationArrow: true,
        minDate: DateTime(2021, 03, 05, 10, 0, 0),
        maxDate: DateTime(2080, 03, 05, 10, 0, 0),
      ),
    );
  }

  CalendarHeaderStyle headerStyle() {
    return CalendarHeaderStyle(
      textStyle:
          TextStyle(color: black, fontSize: 16, fontFamily: FontName.bold.name),
      textAlign: TextAlign.center,
    );
  }

  ViewHeaderStyle viewHeaderStyle() {
    return ViewHeaderStyle(
        dayTextStyle: TextStyle(fontFamily: FontName.semiBold.name),
        dateTextStyle: dateTextStyle());
  }

  TextStyle dateTextStyle() =>
      TextStyle(color: black, fontFamily: FontName.bold.name);

  BoxDecoration dateSectionDecoration() {
    return BoxDecoration(
        color: yellow.withOpacity(0.3),
        border: Border.all(color: red, width: 3),
        borderRadius: BorderRadius.circular(4));
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
    return SizedBox(
      width: widget.onlyTime ? 300 : null,
      height: widget.onlyTime ? 200 : null,
      child: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hourBuilder(),
            minuteBuilder(),
          ],
        ),
      ),
    );
  }

  Column minuteBuilder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(title: minuteStr, fontName: FontName.bold),
        Obx(
          () {
            return customNumberPicker(widget.pickedMinute.value, 59, (value) {
              print("_minutePicker");
              widget.pickedMinute.value = value;
              widget.localDateTime = DateTime(
                  widget.localDateTime.year,
                  widget.localDateTime.month,
                  widget.localDateTime.day,
                  widget.localDateTime.hour,
                  value);
            });
          },
        ),
      ],
    );
  }

  Column hourBuilder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(title: hourStr, fontName: FontName.bold),
        Obx(
          () {
            return customNumberPicker(
              widget.pickedHour.value,
              23,
              (value) {
                print("_hourPicker");
                widget.pickedHour.value = value;
                widget.localDateTime = DateTime(
                  widget.localDateTime.year,
                  widget.localDateTime.month,
                  widget.localDateTime.day,
                  value,
                  widget.localDateTime.minute,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget customNumberPicker(int value, int max, Function(int) onSelected) {
    return NumberPicker(
        textStyle: TextStyle(fontFamily: FontName.regular.name, color: grey),
        selectedTextStyle: TextStyle(
            fontFamily: FontName.bold.name, color: black, fontSize: 18),
        itemHeight: 35,
        itemCount: 3,
        value: value,
        minValue: 0,
        maxValue: max,
        onChanged: (value) {
          onSelected(value);
        });
  }
}
