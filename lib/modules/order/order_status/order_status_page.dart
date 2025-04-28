import 'dart:developer';

import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'order_status_provider.dart';
import 'widgets/order_status_with_progress.dart';

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  // bool isBack = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<OrderStatusProvider>(context, listen: false);
      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      String orderId = args?['orderId'] ?? '';
      provider.setIsBack(args?['isBack'] ?? false);
      provider.emitAndListenOrderStatus(socketProvider, orderId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final isBack = context.watch<OrderStatusProvider>().isBack;
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        accountType: accountType,
        title: 'Order',
        isBack: isBack,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 80.h),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 50.h),
                child: Column(
                  children: [
                    // * Lottie file
                    SizedBox(
                      height: 340.h,
                      child: Consumer<OrderStatusProvider>(
                        builder: (context, provider, child) => Lottie.asset(
                          provider.getLottieFile(
                              accountType, provider.orderStatusEnum),
                          // accountType == 'business'
                          //     ? provider.orderStatusEnum == OrderStatus.placed
                          //         ? LottieStrings.orderPlaced
                          //         : provider.orderStatusEnum ==
                          //                 OrderStatus.confirmed
                          //             ? LottieStrings.orderConfirm
                          //             : provider.orderStatusEnum ==
                          //                     OrderStatus.prepared
                          //                 ? LottieStrings.orderPreparation
                          //                 : provider.orderStatusEnum ==
                          //                         OrderStatus.outForDelivery
                          //                     ? LottieStrings
                          //                         .orderOutForDelivery
                          //                     : provider.orderStatusEnum ==
                          //                             OrderStatus.delivered
                          //                         ? LottieStrings
                          //                             .orderDelivered
                          //                         : LottieStrings.orderPlaced
                          //     : provider.orderStatusEnum == OrderStatus.placed
                          //         ? LottieStrings.orderPlacedPersonal
                          //         : provider.orderStatusEnum ==
                          //                 OrderStatus.confirmed
                          //             ? LottieStrings.orderConfirmPersonal
                          //             : provider.orderStatusEnum ==
                          //                     OrderStatus.prepared
                          //                 ? LottieStrings
                          //                     .orderPreparationPersonal
                          //                 : provider.orderStatusEnum ==
                          //                         OrderStatus.outForDelivery
                          //                     ? LottieStrings
                          //                         .orderOutForDeliveryPersonal
                          //                     : provider.orderStatusEnum ==
                          //                             OrderStatus.delivered
                          //                         ? LottieStrings
                          //                             .orderDeliveredPersonal
                          //                         : LottieStrings
                          //                             .orderPlacedPersonal // fallback
                        ),
                      ),
                    ),
                    Text(
                      "Your Order Has Been",
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Consumer<OrderStatusProvider>(
                      builder: (context, provider, child) => Text(
                        // "Placed Successfully!",
                        provider.getOrderStatusText(
                            accountType, provider.orderStatusEnum),
                        style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.disabledColor,
                            personalColor: AppColors.bayLeaf,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // * Order status with progress indicator
                    OrderStatusWithProgressWidget(
                      accountType: accountType,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 48.h),
                child: CustomButton(
                  height: 55.h,
                  bgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(Routes.bottomBarPage));
                  },
                  text: 'GO TO HOME',
                  textColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
