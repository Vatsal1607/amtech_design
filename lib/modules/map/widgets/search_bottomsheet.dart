import 'dart:developer';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/textfield/custom_searchfield.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/loader/custom_loader.dart';
import '../../provider/socket_provider.dart';
import '../address/saved_address/saved_address_provider.dart';
import '../address/saved_address/widgets/saved_location_card.dart';
import '../google_map_provider.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);
      final provider =
          Provider.of<SavedAddressProvider>(context, listen: false);
      final googleMapProvider =
          Provider.of<GoogleMapProvider>(context, listen: false);
      Future.delayed(const Duration(milliseconds: 300), () {
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
    final accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<SavedAddressProvider>(context, listen: false);
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    final googleMapProvider =
        Provider.of<GoogleMapProvider>(context, listen: false);
    TextEditingController searchController = TextEditingController();

    return FocusableActionDetector(
      autofocus: true,
      onFocusChange: (value) {
        if (value == true) {
          provider.filteredSearchLocationList =
              provider.nearByAddressList ?? [];
        } else if (value == false) {
          provider.filteredSearchLocationList.clear(); //* Clear list
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.seaShell,
            personalColor: AppColors.seaMist,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            //* Sticky Search Bar
            CustomSearchField(
              cursorColor: Colors.white,
              provider: provider,
              hint: 'Search for a place or address',
              onChanged: (value) {
                provider.onSearchChanged(
                  value: value,
                  socketProvider: socketProvider,
                  lat: googleMapProvider.currentLocation?.latitude,
                  long: googleMapProvider.currentLocation?.longitude,
                );
              },
              accountType: accountType,
              controller: searchController,
              fillColor: AppColors.primaryColor.withOpacity(.8),
            ),
            SizedBox(height: 10.h),

            //* Expanded ListView
            Consumer<SavedAddressProvider>(
              builder: (context, provider, child) => provider.isLoadingNearBy
                  ? Center(
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: CustomLoader(
                          backgroundColor: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemCount: provider.filteredSearchLocationList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final nearByAddress =
                              provider.filteredSearchLocationList[index];
                          return GestureDetector(
                            onTap: () {
                              googleMapProvider.showSelectedLocationAddressCard(
                                context: context,
                                latitude: nearByAddress.lat ?? 0,
                                longitude: nearByAddress.lng ?? 0,
                              );
                              log('${nearByAddress.lat}');
                              log('${nearByAddress.lng}');
                            },
                            child: SavedLocationCard(
                              isNearBy: true,
                              nearByAddress: nearByAddress,
                              provider: provider,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
