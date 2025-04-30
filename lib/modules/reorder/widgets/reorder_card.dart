import 'dart:math';
import 'dart:developer' as dev;
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/models/add_to_cart_request_model.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/utils.dart';
import '../../../models/reorder_model.dart';
import '../../../routes.dart';

class ReorderCardWidget extends StatelessWidget {
  final String accountType;
  final ReOrders reorder;
  final int index;
  const ReorderCardWidget({
    super.key,
    required this.accountType,
    required this.reorder,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 145.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // '9/12/2024 05:55PM',
                    Utils().convertIsoToFormattedDate(reorder.createdAt ?? ''),
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${reorder.totalAmount}',
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Divider(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell.withOpacity(.5),
                  personalColor: AppColors.seaMist.withOpacity(.5),
                ),
                thickness: 1,
              ),
              SizedBox(height: 8.h),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero, // imp
                      shrinkWrap: true,
                      itemCount: min(reorder.items?.length ?? 0, 2),
                      itemBuilder: (context, index) {
                        return Text(
                          '${reorder.items?[index].quantity} × ${reorder.items?[index].itemName} | Size: ${reorder.items?[index].size?[0].sizeName?.substring(0, 1)}',
                          style: GoogleFonts.publicSans(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 1.h),
                    SizedBox(height: 1.h),
                    Text(
                      '& MORE',
                      style: GoogleFonts.publicSans(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.seaShell.withOpacity(.5),
                          personalColor: AppColors.seaMist.withOpacity(.5),
                        ),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20.w,
          bottom: 25.h,
          // * Reorder Button
          child: GestureDetector(
            onTap: () async {
              List<RequestItems>? requestItemsList = reorder.items
                  ?.map((item) => RequestItems(
                        menuId: item.menuId,
                        quantity: item.quantity,
                        size: item.size
                            ?.map((s) => RequestSize(
                                  sizeId: s.sizeId,
                                ))
                            .toList(),
                      ))
                  .toList();
              //* API call
              context.read<MenuProvider>().addToCart(
                    context: context,
                    menuId: '',
                    sizeId: '',
                    size: '',
                    index: index,
                    items: requestItemsList,
                    callback: (isSuccess) {
                      if (isSuccess) {
                        Navigator.pushNamed(context, Routes.cart);
                      } else {
                        dev.log('isSuccess: $isSuccess');
                      }
                    },
                  );
            },
            child: Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Consumer<MenuProvider>(
                  builder: (context, menuProvider, child) {
                final isIndexLoading = menuProvider.isIndexLoading(index);
                return isIndexLoading
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          child: const CustomLoader(
                            backgroundColor: AppColors.primaryColor,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            icon: IconStrings.reorderBtn,
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'REORDER',
                            style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                            ),
                          ),
                        ],
                      );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
