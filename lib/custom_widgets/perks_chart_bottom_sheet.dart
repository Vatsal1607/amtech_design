import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/constant.dart';
import '../core/utils/strings.dart';
import '../modules/cart/widgets/select_payment_method_widget.dart';
import 'svg_icon.dart';

void showPerksChartBottomSheeet({
  required BuildContext context,
  required String accountType,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    // isScrollControlled: true,
    builder: (context) {
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 19.h, left: 32.w, right: 32.w),
              // height: 323.h,
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'perks chart'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AMOUNT",
                        style: GoogleFonts.publicSans(
                          fontSize: 12.sp,
                          color: AppColors.seaShell,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "PERKS",
                        style: GoogleFonts.publicSans(
                          fontSize: 12.sp,
                          color: AppColors.seaShell,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  _buildPerkRow(
                      minAmount: "₹ 500 ",
                      maxAmount: "₹ 999",
                      perks: "2%",
                      accountType: accountType),
                  _buildPerkRow(
                      minAmount: "₹ 1,000 ",
                      maxAmount: "₹ 2,499",
                      perks: "2%",
                      accountType: accountType),
                  _buildPerkRow(
                      minAmount: "₹ 2,500 ",
                      maxAmount: "₹ 4,999",
                      perks: "3%",
                      accountType: accountType),
                  _buildPerkRow(
                      minAmount: "₹ 5,000 ",
                      maxAmount: "₹ 9,999",
                      perks: "5%",
                      accountType: accountType),
                  _buildPerkRow(
                      minAmount: "₹ 10,000 ",
                      maxAmount: "₹ 24,999",
                      perks: "5%",
                      accountType: accountType),
                  _buildPerkRow(
                      minAmount: "₹ 25,000 ",
                      maxAmount: "₹ 49,999",
                      perks: "5%",
                      accountType: accountType),
                  _buildPerkRow(
                      minAmount: "₹ 50,000",
                      perks: "7%",
                      accountType: accountType,
                      isDivider: false),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Note:',
                      style: GoogleFonts.publicSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          )),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: capitalizeEachWord(
                            'The perks chart outlines the percentage of '),
                        style: GoogleFonts.publicSans(
                          fontSize: 12.sp,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: capitalizeEachWord('perks you can earn'),
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.seaShell,
                                personalColor: AppColors.seaMist,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: capitalizeEachWord(
                                'based on the recharge amount.'),
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.seaShell,
                                personalColor: AppColors.seaMist,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10.h),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: capitalizeEachWord('perks will be '),
                        style: GoogleFonts.publicSans(
                          fontSize: 12.sp,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: capitalizeEachWord('credited instantly '),
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.seaShell,
                                personalColor: AppColors.seaMist,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: capitalizeEachWord(
                                'to your account upon successful recharge.'),
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.seaShell,
                                personalColor: AppColors.seaMist,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: IgnorePointer(
              ignoring: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Close pressed');
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const SvgIcon(
                    icon: IconStrings.close,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

// Helper method to build each row
Widget _buildPerkRow({
  required String minAmount,
  String? maxAmount,
  required String perks,
  required String accountType,
  final bool isDivider = true,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  minAmount,
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.seaShell,
                      personalColor: AppColors.seaMist,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (maxAmount != null && maxAmount.isNotEmpty)
                  Text(
                    'To ',
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                Text(
                  maxAmount ?? '',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.seaShell,
                      personalColor: AppColors.seaMist,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              perks,
              style: GoogleFonts.publicSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (isDivider)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: DottedDashedLine(
              height: 0.h,
              width: double.infinity,
              axis: Axis.horizontal,
              dashColor: AppColors.seaShell.withOpacity(.5),
            ),
          ),
      ],
    ),
  );
}
