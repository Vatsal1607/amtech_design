import 'dart:developer';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/map/address/saved_address/saved_address_provider.dart';
import 'package:amtech_design/modules/map/address/saved_address/widgets/add_location_card_widget.dart';
import 'package:amtech_design/modules/map/google_map_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/recharge/widgets/center_title_with_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants/keys.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../../custom_widgets/textfield/custom_search_container.dart';
import '../../../../services/local/shared_preferences_service.dart';
import '../../../provider/socket_provider.dart';
import '../../widgets/show_search_address_bottomsheet.dart';
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
      if (!socketProvider.isConnected) {
        socketProvider.connectToSocket();
      }
      // Remove existing listener if any
      // socketProvider.offEvent(SocketEvents.searchSavedLocationListen);
      // Emit and listen again
      provider.emitAndListenSavedAddress(socketProvider);

      // final socketProvider =
      //     Provider.of<SocketProvider>(context, listen: false);
      // final provider =
      //     Provider.of<SavedAddressProvider>(context, listen: false);
      // if (!socketProvider.isConnected) {
      //   socketProvider.connectToSocket();
      // }
      // provider.emitAndListenSavedAddress(socketProvider);
      //
      // final googleMapProvider =
      //     Provider.of<GoogleMapProvider>(context, listen: false);
      // Future.delayed(const Duration(milliseconds: 200), () {
      // provider.emitAndListenSavedAddress(socketProvider);
      // provider.emitAndListenNearBy( //* Emit nearby
      //   socketProvider: socketProvider,
      //   lat: googleMapProvider.currentLocation?.latitude,
      //   long: googleMapProvider.currentLocation?.longitude,
      // );
      // });
      // checkLocationPermissionAndEmitEvent();
    });
    super.initState();
  }

  //* check location permission & emit event:
  Future<void> checkLocationPermissionAndEmitEvent() async {
    if (await Permission.location.isGranted) {
      final googleMapProvider =
          Provider.of<GoogleMapProvider>(context, listen: false);
      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);
      //* Socket get location
      googleMapProvider.emitAndListenGetLocation(
        socketProvider: socketProvider,
      );
    } else {
      PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        checkLocationPermissionAndEmitEvent(); // Retry after permission is granted
      } else {
        debugPrint("Location permission denied saved address page.");
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return CustomConfirmDialog(
        //       title: 'Location Required',
        //       subTitle:
        //           'Location services are disabled. Please enable them in settings.',
        //       accountType: 'business', //Todo set dynamic accountType
        //       yesBtnText: 'Open Settings',
        //       onTapYes: () async {
        //         Navigator.pop(context);
        //         await Geolocator.openLocationSettings();
        //       },
        //     );
        //   },
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // log('is socket Connected: ${socketProvider.isConnected}');
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    // final provider = Provider.of<SavedAddressProvider>(context, listen: false);
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    final gMapProvider = Provider.of<GoogleMapProvider>(context, listen: false);
    log('current Address ${gMapProvider.address}');
    debugPrint('currentLocation lat ${gMapProvider.currentLocation?.latitude}',
        wrapWidth: 1024);
    debugPrint(
        'currentLocation long ${gMapProvider.currentLocation?.longitude}',
        wrapWidth: 1024);
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Change Location',
        accountType: accountType,
        //! TEMP action icon
        // isAction: true,
        // actionIcon: IconStrings.info,
        // onTapAction: () {
        //   showCustomInfoDialog(
        //     context: context,
        //     accountType: accountType,
        //     message:
        //         "Sorry, We Are Currently Not Available To Your Selected Location.",
        //   );
        // },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 32.w,
          right: 32.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              //* SearchField
              // GestureDetector(
              //   onTap: () => showSearchBottomSheet(context),
              //   child: Container(
              //     color: Colors.transparent,
              //     child: CustomSearchContainer(
              //       height: 55.h,
              //       borderWidth: 2.w,
              //       accountType: accountType,
              //       controller: searchController,
              //       hint: 'Search for aera, street, etc.',
              //       iconColor: getColorAccountType(
              //         accountType: accountType,
              //         businessColor: AppColors.primaryColor,
              //         personalColor: AppColors.darkGreenGrey,
              //       ),
              //       borderColor: getColorAccountType(
              //         accountType: accountType,
              //         businessColor: AppColors.primaryColor,
              //         personalColor: AppColors.darkGreenGrey,
              //       ),
              //       fillColor: getColorAccountType(
              //         accountType: accountType,
              //         businessColor: AppColors.seaShell,
              //         personalColor: AppColors.seaMist,
              //       ),
              //     ),
              //   ),
              // ),

              // SizedBox(height: 20.h),

              //* Add new location card:
              AddLocationCard(
                accountType: accountType,
              ),

              SizedBox(height: 20.h),
              CenterTitleWithDivider(
                accountType: accountType,
                title: 'SAVED LOCATIONS',
                fontSize: 15.sp,
              ),
              SizedBox(height: 20.h),

              //* Saved address card
              Consumer<SavedAddressProvider>(
                builder: (context, provider, child) {
                  final list = provider.savedAddressList;

                  return provider.isLoadingSavedAddress
                      ? CustomLoader(
                          backgroundColor: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        )
                      : (list.isEmpty)
                          ? Center(
                              child: Text(
                                'No Saved Address'.toUpperCase(),
                                style: GoogleFonts.publicSans(
                                  fontSize: 18.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: list.length,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) {
                                final savedAddress = list[index];
                                return GestureDetector(
                                  onTap: () async {
                                    await provider
                                        .chooseLocation(
                                      context: context,
                                      address:
                                          '${savedAddress.propertyNumber} ${savedAddress.residentialAddress} ${savedAddress.nearLandmark} ${savedAddress.suggestAddress ?? ''}',
                                    )
                                        .then((isSuccess) async {
                                      if (isSuccess == true) {
                                        menuProvider.updateHomeAddress(
                                            HomeAddressType.remote);
                                        await context
                                            .read<MenuProvider>()
                                            .homeMenuApi();
                                      }
                                    });
                                  },
                                  child: SavedLocationCard(
                                    savedAddress: savedAddress,
                                    provider: provider,
                                  ),
                                );
                              },
                            );
                },
              ),

              // SizedBox(height: 20.h),
              // CenterTitleWithDivider(
              //   accountType: accountType,
              //   title: 'NEARBY LOCATIONS',
              //   fontSize: 15.sp,
              // ),
              // SizedBox(height: 20.h),
              //* NearBy address card
              // Consumer<SavedAddressProvider>(builder: (context, _, child) {
              //   log('nearByAddressList length: ${provider.nearByAddressList?.length}');
              //   return provider.isLoadingNearBy
              //       ? CustomLoader(
              //           backgroundColor: getColorAccountType(
              //             accountType: accountType,
              //             businessColor: AppColors.primaryColor,
              //             personalColor: AppColors.darkGreenGrey,
              //           ),
              //         )
              //       : (provider.nearByAddressList == null ||
              //               provider.nearByAddressList!.isEmpty)
              //           ? const Text('No nearby addresses found.')
              //           : ListView.separated(
              //               itemCount: provider.nearByAddressList?.length ?? 0,
              //               shrinkWrap: true,
              //               physics: const NeverScrollableScrollPhysics(),
              //               padding: EdgeInsets.zero,
              //               itemBuilder: (context, index) {
              //                 final nearByAddress =
              //                     provider.nearByAddressList?[index];
              //                 return GestureDetector(
              //                   onTap: () async {
              //                     // Choose location
              //                     // provider
              //                     //     .chooseLocation(.
              //                     //   context: context,
              //                     //   address:
              //                     //       '${nearByAddress?.propertyNumber} ${nearByAddress?.residentialAddress} ${nearByAddress?.nearLandmark} ${nearByAddress?.suggestAddress ?? ''}',
              //                     // )
              //                     //     .then((isSuccess) {
              //                     //   if (isSuccess == true) {
              //                     //     //* Update home address type
              //                     //     menuProvider.updateHomeAddress(
              //                     //         HomeAddressType.remote);
              //                     //   }
              //                     // });
              //                     //
              //                     gMapProvider.showSelectedLocationAddressCard(
              //                       context: context,
              //                       isNavigateHome: true,
              //                       latitude: nearByAddress?.lat ?? 0,
              //                       longitude: nearByAddress?.lng ?? 0,
              //                     );
              //                     //* store address locally
              //                     await sharedPrefsService.setString(
              //                       SharedPrefsKeys.selectedAddress,
              //                       nearByAddress?.address ?? '',
              //                     );
              //                     //* Update home address type
              //                     menuProvider.updateHomeAddress(
              //                       HomeAddressType.local,
              //                     );
              //                     log('nearby  pressed-----');
              //                   },
              //                   child: SavedLocationCard(
              //                     isNearBy: true,
              //                     nearByAddress: nearByAddress,
              //                     provider: provider,
              //                   ),
              //                 );
              //               },
              //               separatorBuilder: (context, index) =>
              //                   SizedBox(height: 10.h),
              //             );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
