import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 01, 01),
        lastDay: DateTime.utc(2030, 01, 01),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() => _calendarFormat = format);
          }
        },
        onPageChanged: (focusedDay) => _focusedDay = focusedDay,
        calendarStyle: CalendarStyle(
          canMarkersOverflow: true,
          defaultTextStyle: TextStyle(fontSize: 14),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
        ),
      ),
    );
  }
}
