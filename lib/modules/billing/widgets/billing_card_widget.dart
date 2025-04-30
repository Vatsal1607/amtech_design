import 'dart:developer';

import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/billing/billing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../../models/billing_model.dart';

class BillingCardWidget extends StatelessWidget {
  final String period;
  final List<Invoice> invoices;
  final String accountType;
  const BillingCardWidget({
    super.key,
    required this.period,
    required this.invoices,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Title
            Center(
              child: Text(
                period.toUpperCase(),
                style: GoogleFonts.publicSans(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Divider(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell.withOpacity(.5),
                personalColor: AppColors.seaMist.withOpacity(.5),
              ),
              thickness: 1,
            ),
            SizedBox(height: 8.h),

            // List of invoices
            ...invoices.map((invoice) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.seaShell,
                      personalColor: AppColors.seaMist,
                    ),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  // //* Details Row
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Date Time Container
                            Flexible(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(left: 14.w),
                                child: Text(
                                  Utils().convertIsoToFormattedDateDynamic(
                                      invoice.generatedAt),
                                  style: GoogleFonts.publicSans(
                                    fontWeight: FontWeight.bold,
                                    color: getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.primaryColor,
                                      personalColor: AppColors.darkGreenGrey,
                                    ),
                                    fontSize: 13.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                            /// Invoice Number Container
                            Flexible(
                              flex: 3,
                              child: RichText(
                                text: TextSpan(
                                  text: 'INVOICE: ',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14.sp,
                                    color: getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.disabledColor,
                                      personalColor: AppColors.bayLeaf,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: invoice.invoiceNumber,
                                      style: GoogleFonts.publicSans(
                                        color: const Color(0xFF3E6AD2),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// Download Icon Container
                            Consumer<BillingProvider>(
                              builder: (context, provider, child) =>
                                  GestureDetector(
                                onTap: () async {
                                  log('Download pressed');
                                  final invoiceUrl = invoice.invoiceUrl;
                                  final fileName =
                                      'Invoice_${invoice.invoiceNumber}.pdf';
                                  await provider.downloadInvoiceToDownloads(
                                      invoiceUrl, fileName);
                                  await provider.downloadInvoiceToDownloads(
                                      invoiceUrl, fileName);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: const Icon(Icons.download),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
