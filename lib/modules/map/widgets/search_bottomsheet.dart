import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/textfield/custom_search_container.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/loader/custom_loader.dart';
import '../address/saved_address/saved_address_provider.dart';
import '../address/saved_address/widgets/saved_location_card.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final List<String> searchItems = [
      "New York",
    ];

    TextEditingController searchController = TextEditingController();

    return Container(
      color: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      padding: EdgeInsets.all(16.w),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          CustomSearchContainer(
            accountType: accountType,
            controller: searchController,
            fillColor: AppColors.primaryColor,
          ),
          SizedBox(height: 10.h),
          Consumer<SavedAddressProvider>(
            builder: (context, provider, child) =>
                // provider.isLoadingNearBy
                false
                    ? const CustomLoader(
                        backgroundColor: AppColors.primaryColor,
                      )
                    : ListView.separated(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          // final nearByAddress =
                          //     provider.nearByAddressList?[index];
                          return SavedLocationCard(
                            isNearBy: true,
                            // nearByAddress: nearByAddress,
                            provider: provider,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                      ),
          ),
        ],
      ),
    );
  }
}
