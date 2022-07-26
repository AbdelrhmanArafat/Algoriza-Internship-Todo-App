/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'gestures/tap.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color? selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final bool? showDay;
  Gradient gradient;

  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.showDay,
    this.gradient=const LinearGradient(
      colors: <Color>[
        Colors.greenAccent,
        Colors.greenAccent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: width,
          // margin: EdgeInsets.all(3.0),
              decoration: (selectionColor==null)?BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: selectionColor,
                border: Border.all(color: Colors.green,width: 1),
            gradient: gradient,
          ):BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.grey,width: 1),

              ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Text(
                //     new DateFormat("MMM", locale)
                //         .format(date)
                //         .toUpperCase(), // Month
                //     style: monthTextStyle),
                if (showDay ?? false)
                  Text(
                      new DateFormat("E", locale)
                          .format(date)
                          .toUpperCase(), // WeekDay
                      style: dayTextStyle),
                Text(date.day.toString(), // Date
                    style: dateTextStyle),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(this.date);
        }
      },
    );
  }
}
