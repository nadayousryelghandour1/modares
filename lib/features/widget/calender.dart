import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class MaterialCalendar extends StatefulWidget {
  final Map<String, List<String>> availability;
  final Function(DateTime, List<String>) onSelect;

  const MaterialCalendar({
    super.key,
    required this.availability,
    required this.onSelect,
  });

  @override
  State<MaterialCalendar> createState() => _MaterialCalendarState();
}

class _MaterialCalendarState extends State<MaterialCalendar> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  String format(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime(2035),
          focusedDay: focusedDay,

          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },

          enabledDayPredicate: (day) {
            return widget.availability.containsKey(format(day));
          },

          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;
            });

            final key = format(selected);
            final hours = widget.availability[key] ?? [];

            widget.onSelect(selected, hours);
          },

          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            todayDecoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: Color(0xff1e3b8a),
              shape: BoxShape.circle,
            ),
            selectedTextStyle: const TextStyle(color: Colors.white),
            defaultTextStyle: const TextStyle(fontWeight: FontWeight.w500),
            outsideDaysVisible: false,
          ),

         headerStyle: HeaderStyle(
  formatButtonVisible: false,
  titleCentered: true,
  titleTextStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
        ),
      ),
    );
  }
}