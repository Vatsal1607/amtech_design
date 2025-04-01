import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../subscription_summary_provider.dart';

class DayWiseDetailsListWidget extends StatelessWidget {
  const DayWiseDetailsListWidget({
    super.key,
    required this.provider,
  });

  final SubscriptionSummaryProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: provider.subscriptionDetails.length,
      itemBuilder: (context, index) {
        final dayData = provider.subscriptionDetails[index];
        return Padding(
          padding: EdgeInsets.only(top: 8.h, left: 10.w, bottom: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dayData['day'],
                style: GoogleFonts.publicSans(
                    fontSize: 20.sp,
                    color: AppColors.seaShell,
                    fontWeight: FontWeight.bold),
              ),
              ...dayData['timeslots'].map<Widget>((timeslot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '# ${timeslot['time']}',
                      style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          color: Colors.white54,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1 x ${timeslot['item']}',
                            style: GoogleFonts.publicSans(
                              fontSize: 16.sp,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            '[ ${timeslot['description']} ]',
                            style: GoogleFonts.publicSans(
                                fontSize: 14.sp, color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
