import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/bottom_blur_on_page.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/order/order_list/widgets/order_list_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../provider/socket_provider.dart';
import 'order_list_provider.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<OrderListProvider>(context, listen: false);
      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);
      provider.emitAndListenAllOrderStatus(socketProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        accountType: accountType,
        title: 'Orders',
      ),
      body: Stack(
        children: [
          Consumer<OrderListProvider>(
            builder: (context, provider, child) => provider.isLoading
                ? Center(
                    child: CustomLoader(
                      backgroundColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  )
                : (provider.allOrderStatusModel != null &&
                        provider.allOrderStatusModel!.data != null &&
                        provider.allOrderStatusModel!.data!.isNotEmpty)
                    ? ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: 32.w, right: 32.w, top: 16.h, bottom: 40.h),
                        itemCount: provider.allOrderStatusModel!.data!.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h);
                        },
                        itemBuilder: (context, index) {
                          final allOrder =
                              provider.allOrderStatusModel?.data?[index];
                          final List<String> itemNames = allOrder?.items
                                  ?.map((e) => e.itemName ?? '')
                                  .toList() ??
                              [];
                          //* Widget
                          return OrderListStatusWidget(
                            accountType: accountType,
                            orderId: allOrder?.orderId,
                            orderStatus: allOrder?.orderStatus,
                            itemNames: itemNames,
                            createdAt: allOrder?.createdAt,
                            currentStatus: allOrder?.currentStatus,
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "No Order Status Found",
                          style: GoogleFonts.publicSans(
                            fontSize: 20.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
          ),
          BottomBlurOnPage(
            accountType: accountType,
          ),
          BottomBlurOnPage(
            isTopBlur: true,
            accountType: accountType,
          ),
        ],
      ),
    );
  }
}
