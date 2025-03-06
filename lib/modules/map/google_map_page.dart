import 'dart:developer';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/textfield/custom_search_container.dart';
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
import '../../core/utils/strings.dart';
import '../../custom_widgets/buttons/small_edit_button.dart';
import '../../custom_widgets/svg_icon.dart';
import '../provider/socket_provider.dart';
import 'google_map_provider.dart';
import 'widgets/show_search_address_bottomsheet.dart';

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
  void initState() {
    super.initState();
    log('initstate called from map page');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
              {};
      if (args.isNotEmpty) {
        editAddressLat = args['editAddressLat'] != null
            ? double.tryParse(args['editAddressLat'])
            : null;
        editAddressLong = args['editAddressLong'] != null
            ? double.tryParse(args['editAddressLong'])
            : null;
      }
      log('editAddressLat: $editAddressLat, editAddressLong: $editAddressLong');

      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);
      final googleMapProvider =
          Provider.of<GoogleMapProvider>(context, listen: false);
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          // if (editAddressLat != null && editAddressLong != null) {
          // Todo verify for edit location & move camera according
          // googleMapProvider
          //     .moveCamera(LatLng(editAddressLat!, editAddressLong!));
          // checkLocationPermissionAndEmitEvent(googleMapProvider);
          // } else {
          checkLocationPermissionAndEmitEvent(googleMapProvider);
          // }
        },
      );
    });
  }

  //* check location permission & emit event:
  Future<void> checkLocationPermissionAndEmitEvent(
    GoogleMapProvider googleMapProvider,
  ) async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      log("Edit Address Latitude: $editAddressLat, Longitude: $editAddressLong");
      googleMapProvider.emitAndListenGetLocation(
        socketProvider: context.read<SocketProvider>(),
        editLat: editAddressLat,
        editLong: editAddressLong,
      );
    } else {
      debugPrint("Location permission denied on map page.");
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   log('didChangeDependencies call map page');
  //   final googleMapProvider = context.read<GoogleMapProvider>();
  //   final socketProvider = context.read<SocketProvider>();

  //   if (editAddressLat != null && editAddressLong != null) {
  //     log("Skipping emitAndListenGetLocation in didChangeDependencies because it's an edit");
  //     return;
  //   }
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     googleMapProvider.emitAndListenGetLocation(
  //       socketProvider: socketProvider,
  //       editLat: editAddressLat,
  //       editLong: editAddressLong,
  //     );
  //   });
  // }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<GoogleMapProvider>().checkLocationOnResume(context);
    }
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleMapProvider>(context, listen: false);
    final savedAddressProvider =
        Provider.of<SavedAddressProvider>(context, listen: false);
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
                clipBehavior: Clip.none,
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      if (provider.mapController == null) {
                        provider.mapController = controller;
                        // * Call `getCurrentLocation()` only if no edit address is provided
                        if (editAddressLat != null || editAddressLong != null) {
                          provider.getCurrentLocation(
                            context: context,
                            socketProvider: socketProvider, //!
                          );
                        } else {
                          provider.selectedLocation =
                              LatLng(editAddressLat!, editAddressLong!);
                          provider.updateMarker(provider.selectedLocation!);
                          provider.moveCamera(provider.selectedLocation!);
                        }

                        // provider.getCurrentLocation(
                        //   context: context,
                        //   socketProvider:
                        //       socketProvider, //! previously not provuded in params
                        //   editAddressLatLng:
                        //       editAddressLat != null && editAddressLong != null
                        //           ? LatLng(
                        //               editAddressLat!,
                        //               editAddressLong!,
                        //             )
                        //           : null,
                        // );
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: editAddressLat != null && editAddressLong != null
                          ? LatLng(editAddressLat!, editAddressLong!)
                          : provider.currentLocation!,
                      zoom: 14,
                    ),
                    onCameraMove: provider.onCameraMove,
                    onCameraIdle: () {
                      //* Camera stops moving, use the new center position
                      if (mounted) {
                        provider.emitAndListenGetLocation(
                          socketProvider: socketProvider,
                          // editLat: null,
                          // editLong: null,
                        );
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
                          editAddressLatLng: null,
                        );
                      },
                      child: const Icon(
                        Icons.my_location,
                        color: AppColors.seaShell,
                      ),
                    ),
                  ),
                  //* SearchField
                  Positioned(
                    top: 38.w,
                    left: 32.w,
                    right: 32.w,
                    child: GestureDetector(
                      onTap: () => showSearchBottomSheet(context),
                      child: Container(
                        color: Colors.transparent,
                        child: CustomSearchContainer(
                          accountType: accountType,
                          controller: searchController,
                        ),
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
                                        // 'Selected location is ${provider.distance} Far From Current Location',
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
