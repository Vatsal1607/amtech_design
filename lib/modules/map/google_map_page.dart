import 'dart:developer';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/map/address/saved_address/saved_address_provider.dart';
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
import '../../core/utils/constants/keys.dart';
import '../../core/utils/strings.dart';
import '../../custom_widgets/svg_icon.dart';
import '../../services/local/shared_preferences_service.dart';
import '../provider/socket_provider.dart';
import 'google_map_provider.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  dynamic args;
  double? editAddressLat;
  double? editAddressLong;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies called (map page)');
    if (args != null && args.isEmpty) {
      args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
              {};
      editAddressLat = args['editAddressLat'] != null
          ? double.tryParse(args['editAddressLat'].toString())
          : null;
      editAddressLong = args['editAddressLong'] != null
          ? double.tryParse(args['editAddressLong'].toString())
          : null;

      final googleMapProvider =
          Provider.of<GoogleMapProvider>(context, listen: false);
      // log('fromSubsCart (args): ${args?['fromSubscart']}');
      // googleMapProvider.fromSubscart = args?['fromSubscart'];

      // Delay slightly to ensure proper disposal of previous map view
      Future.delayed(const Duration(milliseconds: 200), () {
        checkLocationPermissionAndEmitEvent(googleMapProvider);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
              {};
      if (args.isNotEmpty) {
        log('fromSubsCart (args): ${args?['fromSubscart']}');
        final mapProvider =
            Provider.of<GoogleMapProvider>(context, listen: false);
        mapProvider.fromSubscart = args?['fromSubscart'];
      }
      final googleMapProvider =
          Provider.of<GoogleMapProvider>(context, listen: false);
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          checkLocationPermissionAndEmitEvent(googleMapProvider);
        },
      );
    });
  }

  //* check location permission & emit event:
  Future<void> checkLocationPermissionAndEmitEvent(
    GoogleMapProvider googleMapProvider,
  ) async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      log("Edit Address Latitude: $editAddressLat, Longitude: $editAddressLong");
      googleMapProvider.emitAndListenGetLocation(
        socketProvider: context.read<SocketProvider>(),
        editLat: editAddressLat,
        editLong: editAddressLong,
      );
    } else if (status.isDenied) {
      // Request permission
      final newStatus = await Permission.location.request();
      if (newStatus.isGranted) {
        log("Edit Address Latitude: $editAddressLat, Longitude: $editAddressLong");
        googleMapProvider.emitAndListenGetLocation(
          socketProvider: context.read<SocketProvider>(),
          editLat: editAddressLat,
          editLong: editAddressLong,
        );
      } else {
        debugPrint("Location permission denied after request");
        // googleMapProvider.emitAndListenGetLocation(
        //   socketProvider: context.read<SocketProvider>(),
        //   editLat: editAddressLat,
        //   editLong: editAddressLong,
        // );
      }
    } else if (status.isPermanentlyDenied) {
      debugPrint("Location permission permanently denied. Opening settings...");
      await openAppSettings();
    } else {
      debugPrint("Unhandled permission status: $status");
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GoogleMapProvider>().checkLocationOnResume(context);
      });
    }
  }

  TextEditingController searchController = TextEditingController();
  bool isFirstEmit = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleMapProvider>(context, listen: false);
    final savedAddressProvider =
        Provider.of<SavedAddressProvider>(context, listen: false);
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    log('Distance (km): ${provider.distance}');
    log('Confirm Distance (km): ${provider.confirmDistance}');

    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Change Location',
        accountType: accountType,
      ),
      body: Consumer<GoogleMapProvider>(
        builder: (context, _, child) => provider.currentLocation == null
            ? Center(
                child: CustomLoader(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ))
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      //* Always reassign mapController in onMapCreated
                      provider.mapController = controller;
                      if (!provider.mapControllerCompleter.isCompleted) {
                        provider.mapControllerCompleter.complete(controller);
                      }
                      // if (provider.mapController == null) {
                      // provider.mapController = controller;\
                      provider.getCurrentLocation(
                        context: context,
                        socketProvider: socketProvider,
                        editAddressLatLng:
                            editAddressLat != null && editAddressLong != null
                                ? LatLng(
                                    editAddressLat!,
                                    editAddressLong!,
                                  )
                                : null,
                      );
                      // }
                    },
                    initialCameraPosition: CameraPosition(
                      target: editAddressLat != null && editAddressLong != null
                          ? LatLng(editAddressLat!, editAddressLong!)
                          : provider.selectedLocation ??
                              provider.currentLocation!,
                      zoom: 14,
                    ),
                    onCameraMove: provider.onCameraMove,
                    onCameraIdle: () {
                      //* Camera stops moving, use the new center position
                      if (mounted) {
                        // Remove redundant call
                        if (isFirstEmit) {
                          provider.emitAndListenGetLocation(
                            socketProvider: socketProvider,
                            editLat: editAddressLat ??
                                provider.selectedLocation?.latitude,
                            editLong: editAddressLong ??
                                provider.selectedLocation?.longitude,
                          );
                          isFirstEmit = false;
                        } else {
                          provider.emitAndListenGetLocation(
                            socketProvider: socketProvider,
                          );
                        }
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
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  ),
                  //* Custom Location Button FAB
                  Positioned(
                    bottom: 280.h,
                    right: 20.w,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      onPressed: () {
                        provider.getCurrentLocation(
                          context: context,
                          socketProvider: socketProvider,
                        );
                      },
                      child: Icon(
                        Icons.my_location,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.seaShell,
                          personalColor: AppColors.seaMist,
                        ),
                      ),
                    ),
                  ),
                  //* SearchField
                  // Positioned(
                  //   top: 38.w,
                  //   left: 32.w,
                  //   right: 32.w,
                  //   child: GestureDetector(
                  //     onTap: () => showSearchBottomSheet(context),
                  //     child: Container(
                  //       color: Colors.transparent,
                  //       child: CustomSearchContainer(
                  //         hint: 'Search for a place or address',
                  //         accountType: accountType,
                  //         controller: searchController,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //* Address bottom widget
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.seaShell,
                          personalColor: AppColors.seaMist,
                        ),
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
                                      icon: IconStrings.locationMarker,
                                      color: getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.primaryColor,
                                        personalColor: AppColors.darkGreenGrey,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'Deliver To,',
                                      style: GoogleFonts.publicSans(
                                        fontSize: 15.sp,
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
                                // SmallEditButton(
                                //   onTap: () {},
                                //   accountType: accountType,
                                // ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Consumer<GoogleMapProvider>(
                              builder: (context, _, child) => provider.isLoading
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 16,
                                            width: 260,
                                            color: Colors.white,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4),
                                          ),
                                          Container(
                                            height: 16.h,
                                            width: double.infinity,
                                            color: Colors.white,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4),
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
                                        'Selected location is ${savedAddressProvider.formatDistance(savedAddressProvider.parseDouble(provider.distance))} Far From Current Location',
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
                                  socketProvider: socketProvider,
                                  savedAddressProvider: savedAddressProvider,
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
