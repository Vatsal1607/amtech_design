import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';

class CustomSlidableButton extends StatelessWidget {
  const CustomSlidableButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, child) => GestureDetector(
        onHorizontalDragUpdate: provider.onHorizontalDragUpdate,
        onHorizontalDragEnd: provider.onHorizontalDragEnd,
        child: Stack(
          children: [
            // Background Container
            Container(
              height: 79.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                color: AppColors.disabledColor,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),

            // "Slide to Place Order" Text
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: (MediaQuery.of(context).size.width / 2) -
                  (provider.dragPosition / 2) -
                  100.w, // Moves to the right
              top: 79.h / 2 - 15.h, // Center vertically
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: provider.dragPosition < provider.maxDrag * 0.8
                    ? 1.0
                    : 0.0, // Fade out when dragging reaches 80%
                child: Text(
                  'Slide to Place Order'.toUpperCase(),
                  style: GoogleFonts.publicSans(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),

            // "Release to Confirm" Text
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: provider.dragPosition -
                  (MediaQuery.of(context).size.width / 2) +
                  100.w, // Comes from the left
              top: 79.h / 2 - 15.h, // Center vertically
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: provider.dragPosition >= provider.maxDrag * 0.2
                    ? 1.0
                    : 0.0, // Fade in when dragging reaches 20%
                child: Text(
                  'Release to Confirm'.toUpperCase(),
                  style: GoogleFonts.publicSans(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),

            // Slidable Button
            Positioned(
              left: provider.dragPosition,
              top: 79.h / 2 - 30.5.h, // Center vertically
              child: Container(
                width: 61.h,
                height: 61.h,
                margin: EdgeInsets.symmetric(horizontal: 32.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.seaShell,
                ),
              ),
            ),
          ],
        ),
      ),

      // * OLD slidable button (Keep)
      // GestureDetector(
      //   onHorizontalDragUpdate: provider.onHorizontalDragUpdate,
      //   onHorizontalDragEnd: provider.onHorizontalDragEnd,
      //   child: Stack(
      //     children: [
      //       // Background with dynamic text
      //       Container(
      //         height: 79.h,
      //         width: double.infinity,
      //         // width: provider.maxDrag,
      //         margin: EdgeInsets.symmetric(horizontal: 32.w),
      //         decoration: BoxDecoration(
      //           color: AppColors.disabledColor,
      //           borderRadius: BorderRadius.circular(100.r),
      //         ),
      //         alignment: Alignment.center,
      //         child: Text(
      //           provider.dragPosition >= provider.maxDrag * 1.0
      //               ? 'Release to Confirm'.toUpperCase() // At the end
      //               : 'Slide to Place Order'.toUpperCase(), // Initial text
      //           style: GoogleFonts.publicSans(
      //             color: AppColors.primaryColor,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 15.sp,
      //           ),
      //         ),
      //       ),
      //       // Slidable Button
      //       Positioned(
      //         left: provider.dragPosition,
      //         top: 79.h / 2 - 30.5.h, // Center vertically
      //         child: Container(
      //           width: 61.h,
      //           height: 61.h,
      //           margin: EdgeInsets.symmetric(horizontal: 32.w),
      //           decoration: BoxDecoration(
      //             color: AppColors.primaryColor,
      //             borderRadius: BorderRadius.circular(30.r),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.black.withOpacity(0.2),
      //                 blurRadius: 5.0,
      //               ),
      //             ],
      //           ),
      //           child: const Icon(
      //             Icons.arrow_forward_ios,
      //             color: AppColors.seaShell,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
