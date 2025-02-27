import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/textfield/custom_search_container.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.all(16.w),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          CustomSearchContainer(
            accountType: accountType,
            controller: searchController,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.separated(
              itemCount: searchItems.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchItems[index]),
                  onTap: () {
                    Navigator.pop(context, searchItems[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
