import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  VoidCallback onTap;
  AddToCartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 79.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: AppColors.disabledColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'PRICE ',
                style: GoogleFonts.publicSans(
                  fontSize: 14.0,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                '₹ 11',
                style: GoogleFonts.publicSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 55.0,
              width: 180.0,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Center(
                child: Text(
                  'ADD TO CART',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
