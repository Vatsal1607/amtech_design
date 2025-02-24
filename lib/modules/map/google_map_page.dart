import 'dart:developer';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/map/widgets/edit_address_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:shimmer/shimmer.dart';
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GoogleMapProvider>(context, listen: false)
            .getCurrentLocation(context: context);
        final socketProvider =
            Provider.of<SocketProvider>(context, listen: false);
        Future.delayed(
          const Duration(seconds: 1),
          () {
            checkLocationPermissionAndEmitEvent();
          },
        );
      });
    });
  }

  //* check location permission & emit event:
  Future<void> checkLocationPermissionAndEmitEvent() async {
    if (await Permission.location.isGranted) {
      context
          .read<GoogleMapProvider>()
          .emitAndListenGetLocation(context.read<SocketProvider>());
    } else {
      PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        checkLocationPermissionAndEmitEvent(); // Retry after permission is granted
      } else {
        debugPrint("Location permission denied.");
      }
    }
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
      body: Consumer<GoogleMapProvider>(
        builder: (context, _, child) => provider.currentLocation == null
            ? const Center(
                child: CustomLoader(
                color: AppColors.primaryColor,
              ))
            : Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      if (provider.mapController == null) {
                        provider.mapController = controller;
                        provider.getCurrentLocation(context: context);
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: provider.currentLocation!,
                      zoom: 14,
                    ),
                    onCameraMove: provider.onCameraMove,
                    onCameraIdle: () {
                      //* Camera stops moving, use the new center position
                      if (mounted) {
                        provider.emitAndListenGetLocation(socketProvider);
                      }
                      log("Updated Location: ${provider.selectedLocation?.latitude}, ${provider.selectedLocation?.longitude},");
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                  ),
                  //* Location marker
                  Center(
                    child: SvgIcon(
                      height: 50.h,
                      // width: 40.w,
                      fit: BoxFit.cover,
                      icon: IconStrings.locationMarker,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  //* Custom Location Button FAB
                  Positioned(
                    bottom: 280.h,
                    right: 20.w,
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
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: AppColors.seaShell,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 40.h),
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
                              builder: (context, _, child) => provider.isLoading
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 20.h,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            width: double.infinity / 2,
                                            height: 20.h,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(
                                      provider.address != null &&
                                              provider.address != ''
                                          ? '${provider.address}'
                                          : '',
                                      style: GoogleFonts.publicSans(
                                          fontWeight: FontWeight.bold,
                                          color: getColorAccountType(
                                            accountType: accountType,
                                            businessColor:
                                                AppColors.primaryColor,
                                            personalColor:
                                                AppColors.darkGreenGrey,
                                          )),
                                    ),
                            ),
                            SizedBox(height: 5.h),
                            Consumer<GoogleMapProvider>(
                              builder: (context, _, child) => provider
                                              .distance ==
                                          null ||
                                      provider.distance == '1.0' ||
                                      provider.distance == '0.0' ||
                                      provider.isLoading
                                  ? const SizedBox()
                                  : Container(
                                      padding: EdgeInsets.all(3.w),
                                      decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(.2),
                                          border: Border.all(
                                            width: 1.5.w,
                                            color: AppColors.red,
                                          )),
                                      child: Text(
                                        'Selected location is ${provider.distance} km Far From Current Location',
                                        style: GoogleFonts.publicSans(
                                            color: getColorAccountType(
                                          accountType: accountType,
                                          businessColor: AppColors.primaryColor,
                                          personalColor:
                                              AppColors.darkGreenGrey,
                                        )),
                                      ),
                                    ),
                            ),
                            SizedBox(height: 10.h),
                            CustomButton(
                              height: 50.h,
                              onTap: () {
                                editAddressBottomSheeet(
                                  context: context,
                                  accountType: accountType,
                                  provider: provider,
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
