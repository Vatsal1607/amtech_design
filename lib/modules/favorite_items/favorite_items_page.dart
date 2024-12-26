import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/modules/menu/widgets/product_widget.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';

class FavoriteItemsPage extends StatelessWidget {
  const FavoriteItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Favorite Items',
        accountType: accountType,
        isAction: true,
        actionIcon: IconStrings.more,
        actionIconColor: AppColors.primaryColor,
      ),
      body: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ProductWidget(
            image: ImageStrings.masalaTea2,
            name: 'Masala Tea',
            index: index,
            accountType: accountType,
          );
        },
      ),
    );
  }
}
