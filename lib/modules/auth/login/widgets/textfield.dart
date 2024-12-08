// import 'package:amtech_design/modules/auth/login/login_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/utils/app_colors.dart';

// class Textfield extends StatelessWidget {
//   const Textfield({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Country Code Widget
//         Container(
//           height: 48.h,
//           width: 48.w,
//           decoration: const BoxDecoration(
//             color: AppColors.white,
//             shape: BoxShape.circle,
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Center(
//             child: Text(
//               '+91',
//               style: GoogleFonts.publicSans(
//                 fontSize: 15.sp,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 11.w),
//         // Mobile Number Text Field
//         Expanded(
//           child: Consumer<LoginProvider>(
//             builder: (context, provider, child) => TextFormField(
//               controller: provider.phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: AppColors.white,
//                 hintText: 'Enter mobile number',
//                 hintStyle: GoogleFonts.publicSans(
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor.withOpacity(0.5),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(100.r),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
