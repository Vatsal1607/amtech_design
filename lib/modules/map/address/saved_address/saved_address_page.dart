import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/custom_widgets/textfield/custom_searchfield.dart';
import 'package:amtech_design/modules/map/address/saved_address/saved_address_provider.dart';
import 'package:amtech_design/modules/map/address/saved_address/widgets/add_location_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import '../../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../../routes.dart';

class SavedAddressPage extends StatefulWidget {
  const SavedAddressPage({super.key});

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const String accountType = 'business';
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
            AddLocationCard(),
          ],
        ),
      ),
    );
  }
}
