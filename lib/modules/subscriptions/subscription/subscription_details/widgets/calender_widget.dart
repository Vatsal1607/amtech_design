import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../core/utils/app_colors.dart';
import '../subscription_details_provider.dart';

class CalendarWidget extends StatelessWidget {
  final String accountType;
  const CalendarWidget({super.key, required this.accountType});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              child: Consumer<SubscriptionDetailsProvider>(
                //* TableCalendar
                builder: (context, provider, child) => TableCalendar(
                  firstDay: provider.firstDay,
                  lastDay: provider.lastDay,
                  focusedDay: provider.focusedDay,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  headerStyle: HeaderStyle(
                    leftChevronIcon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white, // IconColor
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white, // IconColor
                    ),
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: GoogleFonts.publicSans(color: Colors.white),
                    weekendStyle: GoogleFonts.publicSans(color: Colors.white),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                  selectedDayPredicate: (day) =>
                      isSameDay(provider.selectedDay, day),
                  onDaySelected: provider.onDaySelected,
                  enabledDayPredicate: (day) {
                    final normalizedDay =
                        DateTime(day.year, day.month, day.day);
                    return !normalizedDay
                        .isBefore(provider.firstDay); // disable previous dates
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      final normalizedDay =
                          DateTime.utc(day.year, day.month, day.day);
                      final color = provider.customDateColors[normalizedDay];
                      if (provider.customDateColors
                          .containsKey(normalizedDay)) {
                        return _buildDayCell(
                            day: day, provider: provider, color: color);
                      }
                      return _buildDayCell(
                          day: day, provider: provider, color: color);
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildDayCell(
      {required DateTime day,
      required SubscriptionDetailsProvider provider,
      Color? color}) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    final isSelected = isSameDay(day, provider.selectedDay);
    final color = provider.customDateColors[normalizedDay];

    return Center(
      child: Text(
        '${day.day}',
        style: GoogleFonts.publicSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
