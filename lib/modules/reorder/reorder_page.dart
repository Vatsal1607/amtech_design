import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/reorder/reorder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_colors.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';

class ReorderPage extends StatelessWidget {
  const ReorderPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<ReorderProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppbar(
            accountType: accountType,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Select order Date:'.toUpperCase(),
                        style: GoogleFonts.publicSans(
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text('Select order Date:')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
