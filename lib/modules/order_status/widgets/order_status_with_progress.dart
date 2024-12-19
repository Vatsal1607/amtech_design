import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

class OrderStatusWithProgress extends StatelessWidget {
  const OrderStatusWithProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.disabledColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SvgIcon(
                icon: IconStrings.orderStatus1,
                color: AppColors.seaShell,
              ),
              Expanded(
                child: Container(
                  height: 2.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  color: Colors.black,
                ),
              ),
              const SvgIcon(
                icon: IconStrings.orderStatus2,
                color: AppColors.seaShell,
              ),
              Expanded(
                child: Container(
                  height: 2.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  color: Colors.black,
                ),
              ),
              const SvgIcon(
                icon: IconStrings.orderStatus3,
                color: AppColors.seaShell,
              ),
              Expanded(
                child: Container(
                  height: 2.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  color: Colors.black,
                ),
              ),
              const SvgIcon(
                icon: IconStrings.orderStatus4,
                color: AppColors.seaShell,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your Order Is",
              style: GoogleFonts.publicSans(
                fontSize: 12.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Placed Successfully!",
              style: GoogleFonts.publicSans(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Divider(
            color: AppColors.primaryColor.withOpacity(.3),
            thickness: 2,
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              minTileHeight: 20.h,
              // showTrailingIcon: false,
              // * new title
              // title: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     Text(
              //       'View Order Details',
              //       style: GoogleFonts.publicSans(
              //         fontSize: 12.sp,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black,
              //       ),
              //     ),
              //     Icon(
              //       true ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              //       color: Colors.black,
              //     ),
              //   ],
              // ),
              // * Old title
              title: Text(
                'View Order Details',
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              children: const [
                Text('data 1'),
                Text('data 2'),
              ],
            ),
          ),
          // SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
