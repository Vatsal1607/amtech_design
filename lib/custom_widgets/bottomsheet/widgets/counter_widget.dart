import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';

class CustomCounterWidget extends StatefulWidget {
  final VoidCallback? onTapDecrease;
  final VoidCallback? onTapIncrease;
  final String? quantity;
  const CustomCounterWidget({
    super.key,
    this.onTapDecrease,
    this.onTapIncrease,
    this.quantity,
  });

  @override
  CustomCounterWidgetState createState() => CustomCounterWidgetState();
}

class CustomCounterWidgetState extends State<CustomCounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.seaShell,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.onTapDecrease,
              child: Container(
                height: 20.h,
                color: Colors.transparent,
                child: const SvgIcon(
                  icon: IconStrings.minus,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '${widget.quantity}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: widget.onTapIncrease,
              child: Container(
                height: 20.h,
                color: Colors.transparent,
                child: const SvgIcon(
                  icon: IconStrings.plus,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
