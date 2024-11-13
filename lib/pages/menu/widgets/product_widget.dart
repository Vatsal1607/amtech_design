import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

class ProductWidget extends StatelessWidget {
  final String image;
  final String name;
  const ProductWidget({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 118,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.primaryColor, // Border color
              width: 2.0, // Border width
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor.withOpacity(.15),
                AppColors.disabledColor.withOpacity(.15),
                AppColors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image),
              Text(
                name.toUpperCase(),
                style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ADD',
                    style: GoogleFonts.publicSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgIcon(icon: IconStrings.add),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
