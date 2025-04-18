import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/legend_section_widget.dart';
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
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final normalizedDay =
                        DateTime.utc(day.year, day.month, day.day);
                    if (provider.customDateColors.containsKey(normalizedDay)) {
                      return Container(
                        decoration: BoxDecoration(
                          color: provider.customDateColors[normalizedDay],
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          //* LegendSection
          const LegendSection(),

          SizedBox(height: 20.h),

          //* Note:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Note:',
                style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.publicSans(
                      color: Colors.black, fontSize: 16.sp),
                  children: [
                    const TextSpan(
                        text:
                            'Our delivery service operates exclusively on weekdays '),
                    TextSpan(
                      text: '(Monday to Saturday, 9 AM to 5 PM)',
                      style:
                          GoogleFonts.publicSans(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text:
                            '. We do not deliver on, Sundays, or public holidays.'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.publicSans(
                      color: Colors.black, fontSize: 14.sp),
                  children: const [
                    TextSpan(
                        text:
                            'If you are unavailable at your delivery address on any specific weekday, you can select the date to disable the delivery. '),
                    TextSpan(
                      text: 'The skipped delivery will be postponed',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            ' as an additional day added to your subscription.'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
