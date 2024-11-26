import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/utils/app_colors.dart';

class OtpFields extends StatefulWidget {
  const OtpFields({super.key});

  @override
  State<OtpFields> createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  final TextEditingController otpController = TextEditingController();

  // @override
  // void dispose() {
  //   otpController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: otpController,
      appContext: context,
      length: 6,
      textStyle: GoogleFonts.publicSans(
        fontSize: 15.sp,
        color: AppColors.primaryColor,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15.r),
        activeFillColor: AppColors.white,
        inactiveColor: AppColors.white, // border color
        disabledColor: AppColors.white,
        activeColor: AppColors.white,
        inactiveFillColor: AppColors.white,
        selectedFillColor: AppColors.white,
      ),
      enableActiveFill: true,
    );
  }
}
