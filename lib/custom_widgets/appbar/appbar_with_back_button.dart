import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;

  const AppBarWithBackButton({
    super.key,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back, // Replace with your SvgIcon widget
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      titleSpacing: 0, // Removes extra space
      title: GestureDetector(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: Text(
          'back'.toUpperCase(),
          style: GoogleFonts.publicSans(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
