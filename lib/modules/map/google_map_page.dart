import 'dart:developer';

import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/map/widgets/edit_address_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/strings.dart';
import '../../custom_widgets/buttons/small_edit_button.dart';
import '../../custom_widgets/svg_icon.dart';
import '../provider/socket_provider.dart';
import 'google_map_provider.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<GoogleMapProvider>(context, listen: false)
          .getCurrentLocation(context: context);
      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);
      Future.delayed(
        const Duration(seconds: 1),
        () {
          context
              .read<GoogleMapProvider>()
              .emitAndListenGetLocation(socketProvider);
        },
      );
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<GoogleMapProvider>().checkLocationOnResume(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleMapProvider>(context, listen: false);
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    const String accountType = 'business';

    return Scaffold(
      appBar: const CustomAppbarWithCenterTitle(
        title: 'Change Location',
        accountType: accountType,
      ),
      body: provider.currentLocation == null
          ? const Center(
              child: CustomLoader(
              color: AppColors.primaryColor,
            ))
          : Consumer<GoogleMapProvider>(
              builder: (context, _, child) => Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      provider.mapController = controller;
                      provider.getCurrentLocation(
                        context: context,
                      ); // Ensure location updates
                    },
                    initialCameraPosition: CameraPosition(
                      target: provider.currentLocation!,
                      zoom: 14,
                    ),
                    onCameraMove: provider.onCameraMove,
                    onCameraIdle: () {
                      //* Camera stops moving, use the new center position
                      // provider.getCurrentLocation(
                      //   context: context,
                      //   socketProvider: socketProvider,
                      // );
                      // Todo Resolve the issue map is not visible after added 'emitAndListenGetLocation'
                      provider.emitAndListenGetLocation(
                          socketProvider); //! Issue is here map invisible
                      log("Updated Location: ${provider.selectedLocation?.latitude}, ${provider.selectedLocation?.longitude},");
                    },
                    // markers: provider.markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                  ),
                  //* Location marker
                  const Center(
                    child: Icon(
                      Icons.location_pin,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                  ),
                  //* Custom Location Button
                  //! Note: Rouond  bgcolor: primary, icon: seashell,
                  Positioned(
                    bottom: 200, //* Adjust as needed
                    right: 20, //* Adjust as needed
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        provider.getCurrentLocation(
                          context: context,
                          socketProvider: socketProvider,
                        );
                      },
                      child: const Icon(
                        Icons.my_location,
                        color: AppColors.seaShell,
                      ),
                    ),
                  ),
                  //* Address bottom widget
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 166.h,
                        color: AppColors.seaShell,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgIcon(
                                      icon: IconStrings.address,
                                      color: getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.primaryColor,
                                        personalColor: AppColors.darkGreenGrey,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'DELIVER TO,',
                                      style: GoogleFonts.publicSans(
                                        fontSize: 12.sp,
                                        color: getColorAccountType(
                                          accountType: accountType,
                                          businessColor: AppColors.primaryColor
                                              .withOpacity(0.8),
                                          personalColor: AppColors.darkGreenGrey
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SmallEditButton(
                                  onTap: () {},
                                  accountType: accountType,
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Consumer<GoogleMapProvider>(
                              builder: (context, _, child) => Text(
                                // 'AMTech Design, E-1102, 11th Floor, Titanium City Center, Satellite, ahmedabad',
                                provider.address != null &&
                                        provider.address != ''
                                    ? '${provider.address}'
                                    : '',
                                style: GoogleFonts.publicSans(
                                    fontWeight: FontWeight.bold,
                                    color: getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.primaryColor,
                                      personalColor: AppColors.darkGreenGrey,
                                    )),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            CustomButton(
                              height: 50.h,
                              onTap: () {
                                editAddressBottomSheeet(
                                  context: context,
                                  accountType: accountType,
                                );
                              },
                              text: 'ADD MORE DETAILS',
                              bgColor: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                              textColor: AppColors.seaShell,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
