import 'package:amtech_design/modules/authorized_emp/authorized_emp_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/custom_confirm_dialog.dart';
import '../../../custom_widgets/custom_textfield.dart';

class AuthorizedEmpWidget extends StatefulWidget {
  final String name;
  final String position;
  final String contact;
  final String authorizedId;
  const AuthorizedEmpWidget({
    super.key,
    required this.name,
    required this.position,
    required this.contact,
    required this.authorizedId,
  });

  @override
  State<AuthorizedEmpWidget> createState() => _AuthorizedEmpWidgetState();
}

class _AuthorizedEmpWidgetState extends State<AuthorizedEmpWidget> {
  late TextEditingController nameController;
  late TextEditingController positionController;
  late TextEditingController mobileController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with values from the widget's constructor
    nameController = TextEditingController(text: widget.name);
    positionController = TextEditingController(text: widget.position);
    mobileController = TextEditingController(text: widget.contact);
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    nameController.dispose();
    positionController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthorizedEmpProvider>(context, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1st Employee\'s Details',
              style: GoogleFonts.publicSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomConfirmDialog(
                      accountType: 'business', // ! static
                      onTapCancel: () => Navigator.pop(context),
                      onTapYes: () {
                        provider.deleteAccess(
                          context: context,
                          empId: widget.authorizedId,
                        );
                      },
                      title: "ARE YOU SURE?",
                      subTitle:
                          "You Really Want To Remove\nThe Authorized Employee?",
                    );
                  },
                );
              },
              child: Container(
                width: 60.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: Text(
                    'REMOVE',
                    style: GoogleFonts.publicSans(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.seaShell,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        CustomTextField(
          enabled: false,
          cursorColor: AppColors.primaryColor,
          hint: 'Full Name',
          prefixIcon: IconStrings.fullname,
          controller: nameController,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.primaryColor,
          textColor: AppColors.primaryColor,
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          enabled: false,
          cursorColor: AppColors.primaryColor,
          hint: 'Position',
          prefixIcon: IconStrings.position,
          controller: positionController,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.primaryColor,
          textColor: AppColors.primaryColor,
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          enabled: false,
          cursorColor: AppColors.primaryColor,
          keyboardType: TextInputType.number,
          hint: 'Mobile Number',
          // prefixText: '+91 ',
          prefixIcon: IconStrings.phone,
          controller: mobileController,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.primaryColor,
          textColor: AppColors.primaryColor,
        ),
        SizedBox(height: 13.h),
      ],
    );
  }
}
