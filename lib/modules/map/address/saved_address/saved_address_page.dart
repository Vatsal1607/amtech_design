import 'dart:developer';

import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/textfield/custom_searchfield.dart';
import 'package:amtech_design/modules/map/address/saved_address/saved_address_provider.dart';
import 'package:amtech_design/modules/map/address/saved_address/widgets/add_location_card_widget.dart';
import 'package:amtech_design/modules/map/google_map_provider.dart';
import 'package:amtech_design/modules/recharge/widgets/center_title_with_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import '../../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../../routes.dart';
import '../../../provider/socket_provider.dart';
import 'widgets/saved_location_card.dart';

class SavedAddressPage extends StatefulWidget {
  const SavedAddressPage({super.key});

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);
      final provider =
          Provider.of<SavedAddressProvider>(context, listen: false);
      final googleMapProvider =
          Provider.of<GoogleMapProvider>(context, listen: false);

      log('Socket isConnected ${socketProvider.isConnected}');
      Future.delayed(const Duration(milliseconds: 300), () {
        provider.emitAndListenSavedAddress(socketProvider);
        provider.emitAndListenNearBy(
          socketProvider: socketProvider,
          lat: googleMapProvider.currentLocation?.latitude,
          long: googleMapProvider.currentLocation?.longitude,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String accountType = 'business'; //Todo set dynamic
    final provider = Provider.of<SavedAddressProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Change Location',
        accountType: accountType,
        //! Temp action icon
        isAction: true,
        actionIcon: IconStrings.info,
        actionIconColor: Colors.amber,
        onTapAction: () {
          Navigator.pushNamed(context, Routes.googleMapPage);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 32.w,
        ),
        child: Column(
          children: [
            //* SearchField
            CustomSearchField(
              provider: provider,
              accountType: accountType,
              borderWidth: 2.w,
              hint: 'Search for area, street, etc.',
              controller: searchController,
              iconColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              borderColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              fillColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell,
                personalColor: AppColors.seaMist,
              ),
            ),
            SizedBox(height: 20.h),
            //* Add new location card:
            const AddLocationCard(),
            SizedBox(height: 20.h),
            CenterTitleWithDivider(
              accountType: accountType,
              title: 'SAVED LOCATIONS',
              fontSize: 15.sp,
            ),
            SizedBox(height: 20.h),

            //* Saved address card
            const SavedLocationCard(),

            SizedBox(height: 20.h),
            CenterTitleWithDivider(
              accountType: accountType,
              title: 'NEARBY LOCATIONS',
              fontSize: 15.sp,
            ),
            SizedBox(height: 20.h),
            const SavedLocationCard(
              isNearBy: true,
            ),
          ],
        ),
      ),
    );
  }
}
