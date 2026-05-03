import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/snack_bar.dart';

class BookLiveSession extends StatefulWidget {
  final Map<String, List<String>> teacherAvailability;
  final String teacherName;

  const BookLiveSession({
    super.key,
    required this.teacherAvailability,
    required this.teacherName,
  });

  @override
  State<BookLiveSession> createState() => _BookLiveSessionState();
}

class _BookLiveSessionState extends State<BookLiveSession> {
  DateTime? selectedDay;
  String? selectedHour;

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> sendBooking() async {
    /// هنا تحطي API أو Firebase
    debugPrint("Booking sent");
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final availableDates =
        widget.teacherAvailability.keys
            .where((k) => widget.teacherAvailability[k]!.isNotEmpty)
            .map(DateTime.parse)
            .where(
              (date) => date.isAfter(now.subtract(const Duration(days: 1))),
            )
            .toList()
          ..sort();

    final initialDate = availableDates.isNotEmpty ? availableDates.first : now;

    final selectedKey = selectedDay != null ? formatDate(selectedDay!) : null;

    final hours = selectedKey != null
        ? widget.teacherAvailability[selectedKey] ?? []
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "حجز مع ${widget.teacherName}",
          style: AppTextStyle.primaryStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        forceMaterialTransparency: true,
      ),
      backgroundColor: AppColor.mainBackground,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImage.mainBg, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// CALENDAR
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColor.mainWhite,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: CalendarDatePicker(
                    initialDate: initialDate,
                    firstDate: now,
                    lastDate: DateTime(2030),
                    selectableDayPredicate: (day) {
                      return widget.teacherAvailability.containsKey(
                        formatDate(day),
                      );
                    },
                    onDateChanged: (date) {
                      setState(() {
                        selectedDay = date;
                        selectedHour = null;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                /// HOURS
                if (selectedDay != null) ...[
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "اختر الساعة",
                      style: AppTextStyle.primaryStyle,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hours.map((h) {
                      return ChoiceChip(
                        selectedColor:
                            AppColor.primeryColor, // الخلفية وقت الاختيار
                        backgroundColor: AppColor.mainWhite, // الخلفية العادية
                        side: BorderSide(color: AppColor.primeryColor),
                        label: Text(
                          h,
                          style: TextStyle(
                            color: selectedHour == h
                                ? Colors
                                      .white // النص أبيض لو مختار
                                : AppColor
                                      .primeryColor, // النص أزرق لو مش مختار
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        selected: selectedHour == h,
                        onSelected: (_) {
                          setState(() {
                            selectedHour = h;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 30),

                /// CONFIRM BUTTON
                if (selectedDay != null && selectedHour != null)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final dateText = formatDate(selectedDay!);

                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              backgroundColor:
                                  AppColor.mainWhite, // لون الخلفية
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ), // شكل الحواف
                              ),
                              title: Text(
                                "تأكيد الحجز",
                                style: AppTextStyle.primaryStyle.copyWith(
                                  color: AppColor.primeryColor,
                                ),
                              ),
                              content: Text(
                                "حجز جلسة يوم $dateText الساعة $selectedHour مع ${widget.teacherName}",
                                style: AppTextStyle.primaryStyle.copyWith(
                                  color: AppColor.primaryTextColor,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "إلغاء",
                                    style: AppTextStyle.primaryStyle.copyWith(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.mainWhite,
                                    foregroundColor: AppColor.primeryColor,
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    await sendBooking();

                                    if (!context.mounted) return;

                                    showMySnackBar(
                                      msg: "تم تأكيد الحجز بنجاح",
                                      type: AnimatedSnackBarType.success,
                                      context: context,
                                    );

                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "تأكيد",
                                    style: AppTextStyle.primaryStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: const Text("تأكيد الحجز"),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
