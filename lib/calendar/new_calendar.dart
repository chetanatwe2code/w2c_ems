import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../theme/app_colors.dart';
import '../view/admin/home/logic.dart';
import '../view/common/punching/view.dart';
import 'my_calendar.dart';

class NewCalendar extends StatefulWidget {
  final SelectedDate? selectedDate;
  final List<Holiday>? holidays;
  final DateTime? lastDay;
  const NewCalendar({Key? key, this.selectedDate,this.holidays,this.lastDay}) : super(key: key);

  @override
  State<NewCalendar> createState() => _NewCalendarState();
}

class _NewCalendarState extends State<NewCalendar> {
  DateTime? _selectedDate;


  CalendarFormat _calendarFormat = CalendarFormat.week;

  // Function to check if the day is a weekend (Saturday or Sunday)
  bool _isWeekend(DateTime day) {
    return day.weekday == DateTime.sunday || checkHolidays(day);
  }

  checkHolidays(DateTime day){
    for(int i = 0; i < (widget.holidays?.length??0);i++){
      if(isSameDay(day, widget.holidays![i].dateTime)){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = AppColors.secondary;
    Color holidayTextColor = AppColors.secondaryDark;
    return Container(
      decoration: getDecoration(color: themeColor),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _selectedDate ?? DateTime.now(),
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if(widget.lastDay != null){
            if(selectedDay.isAfter(widget.lastDay!)){
              return;
            }
          }
          if (!_isWeekend(selectedDay)) {
            setState(() {
              _selectedDate = selectedDay;
            });
            if (widget.selectedDate != null) {
              widget.selectedDate!(selectedDay);
            }
          }
        },
        enabledDayPredicate: (day) {
          return !_isWeekend(day);
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday) {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: holidayTextColor),
                ),
              );
            }
            return null;
          },
          selectedBuilder: (context, date, events) {
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white30,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          todayBuilder: (context, date, events) {
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          defaultBuilder: (context, date, events) {
            if(widget.lastDay != null){
              bool isAfterLastDay = date.isAfter(widget.lastDay!);
              if(isAfterLastDay){
               return Center(child: Text('${date.day}',
                 style: const TextStyle(
                   color: Colors.white54,
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),
               ));
              }
            }
          },
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          rightChevronIcon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          leftChevronIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          formatButtonTextStyle: const TextStyle(
            color: Colors.white
          ),
          formatButtonDecoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          titleCentered: true,
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
              color: Colors.white
          ),
          weekendStyle: TextStyle(
              color: Colors.white,
          ),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          weekendTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          disabledTextStyle: TextStyle(
            color: holidayTextColor,
            fontSize: 18,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.bold,
          ), //
        ),
      ),
    );
  }
}
