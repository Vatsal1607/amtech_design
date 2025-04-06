import 'dart:developer';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/process_to_pay_bottom_sheet.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/constants/keys.dart';
import '../../custom_widgets/svg_icon.dart';
import '../../routes.dart';
import '../../services/local/shared_preferences_service.dart';
import 'widgets/cart_widget.dart';
import 'widgets/you_may_like_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // Wait until the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().getListCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<CartProvider>(context, listen: false);
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        accountType: accountType,
        title: 'Cart',
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: 100.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<CartProvider>(
                      builder: (context, _, child) {
                        log('provider.cartItemList length: ${provider.cartItemList?.length}');
                        return provider.cartItemList == null
                            ? Center(
                                child: CustomLoader(
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                itemCount: provider.cartItemList?.length ?? 0,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                    left: 31.w, right: 31.w, top: 27.h),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemBuilder: (context, index) {
                                  final cartItems =
                                      provider.cartItemList?[index];

                                  return CartWidget(
                                    accountType: accountType,
                                    cartItems: cartItems,
                                  );
                                },
                              );
                      },
                    ),
                    SizedBox(height: 12.h),

                    // * Continue shopping Widget
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, (route) {
                          // Keep popping until the condition is met
                          return route.settings.name == Routes.bottomBarPage;
                        });
                        showCartSnackbar(
                          context: context,
                          message: 'This is the msg',
                          items: 'items',
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 32.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 15.h,
                        ),
                        decoration: BoxDecoration(
                            color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.disabledColor,
                                personalColor: AppColors.bayLeaf),
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'CONTINUE SHOPPING',
                              style: GoogleFonts.publicSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                              ),
                            ),
                            Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const SvgIcon(
                                icon: IconStrings.iosArrowNext,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 170.h,
                      width: 1.sw,
                      margin: EdgeInsets.symmetric(
                        horizontal: 31.w,
                      ),
                      decoration: BoxDecoration(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.disabledColor,
                          personalColor: AppColors.bayLeaf,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 19.h,
                              left: 22.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgIcon(
                                  icon: IconStrings.youMayLike,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'You May Like',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.primaryColor,
                                      personalColor: AppColors.darkGreenGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            height: 100.h,
                            child: ListView.separated(
                              itemCount: 4,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 21.w),
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 21.w);
                              },
                              itemBuilder: (context, index) {
                                return YouMayLikeWidget(
                                  accountType: accountType,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    //* Expansion tile
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 31.w),
                      decoration: BoxDecoration(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Consumer<CartProvider>(
                        builder: (context, _, child) => ExpansionTile(
                          onExpansionChanged: provider.onExpansionChanged,
                          leading: SvgIcon(
                            icon: IconStrings.totalBill,
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ),
                          ),
                          trailing: Icon(
                            provider.isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: AppColors.seaShell,
                          ),
                          title: Row(
                            children: [
                              Text(
                                'Total Bill ',
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
                                '₹${provider.totalAmount} ',
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
                              Text(
                                'Incl. taxes & charges',
                                style: GoogleFonts.publicSans(
                                  fontSize: 10.sp,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.seaShell,
                                    personalColor: AppColors.seaMist,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, bottom: 15.h),
                              child: Column(
                                children: [
                                  //* Base amount
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Base Amount',
                                        style: GoogleFonts.publicSans(
                                          color: AppColors.seaShell,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Builder(builder: (context) {
                                        double totalAmount = double.tryParse(
                                                provider.totalAmount ?? '0') ??
                                            0.0;
                                        double gstAmount =
                                            provider.calculateGST(totalAmount);
                                        return Text(
                                          '₹ ${totalAmount - gstAmount}',
                                          style: GoogleFonts.publicSans(
                                            fontSize: 12.sp,
                                            color: AppColors.seaShell,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  //* GST
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'GST Charges',
                                        style: GoogleFonts.publicSans(
                                          color: AppColors.seaShell,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        '₹ ${provider.calculateGST(double.tryParse(provider.totalAmount ?? '0') ?? 0)} (5%)',
                                        style: GoogleFonts.publicSans(
                                          fontSize: 12.sp,
                                          color: AppColors.seaShell,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  //* Delivery
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Delivery Charges',
                                        style: GoogleFonts.publicSans(
                                          color: AppColors.seaShell,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        'FREE',
                                        style: GoogleFonts.publicSans(
                                          fontSize: 12.sp,
                                          color: AppColors.seaShell,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 50.h,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Consumer<CartProvider>(builder: (context, _, child) {
                  return CustomButton(
                    onTap: provider.cartItemList == null
                        ? () {
                            debugPrint('CART is Empty');
                          }
                        : () {
                            final limitedCartItems = provider.cartItemList
                                ?.map((item) => item.toLimitedJson())
                                .toList();
                            final Map<String, dynamic> orderCreateData = {
                              "userId": sharedPrefsService
                                      .getString(SharedPrefsKeys.userId) ??
                                  '',
                              "userType": accountType == 'business'
                                  ? 'BusinessUser'
                                  : 'User',
                              "items": limitedCartItems,
                              "totalAmount": double.parse(
                                provider.totalAmount.toString(),
                              ),
                              "paymentMethod": provider
                                  .selectedPaymentMethod, // 'UPI', 'Perks'
                              "deliveryAddress":
                                  menuProvider.homeMenuResponse?.data?.address,
                            };
                            log('OrderCreateData: $orderCreateData');
                            provider.isConfirmed = false;
                            showProcessToPayBottomSheeet(
                              context: context,
                              accountType: accountType,
                              //! Emit order-create
                              orderCreateData: orderCreateData,
                            );
                          },
                    height: 55.h,
                    width: double.infinity,
                    bgColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    text: 'proceed to pay ₹ ${provider.totalAmount ?? '0'}',
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
