import 'package:amtech_design/custom_widgets/custom_appbar.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/product_page/widgets/add_to_cart_button.dart';
import 'package:amtech_design/modules/product_page/widgets/size_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';

class ProductPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ProductPage(),
      );
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Ensures content goes behind the AppBar
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: 'Details',
        titleStyle: GoogleFonts.publicSans(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        onTapLeading: () {
          Navigator.pop(context);
        },
        leading: Container(
          height: 48,
          width: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          child: ClipOval(
            child: SvgIcon(
              icon: IconStrings.arrowBack,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        actions: [
          Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(right: 15.0),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: SvgIcon(
              icon: IconStrings.heart,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(ImageStrings.productPageBg),
              Positioned(
                bottom: 20.0,
                left: 0,
                right: 0,
                child: Image.asset(
                  height: 228.0,
                  width: 240.0,
                  ImageStrings.bestSeller1,
                ),
              ),
            ],
          ),
          Container(
            // height: 400,
            height: MediaQuery.of(context).size.height / 2 + 30,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            decoration: const BoxDecoration(
              color: AppColors.seaShell,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            // scrollable bottomsheet
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    width: 36,
                    child: Divider(
                      thickness: 5,
                      // color: ,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Everyday Tea',
                        style: GoogleFonts.publicSans(
                            color: AppColors.primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: AppColors.lightGreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Text(
                              '4.5 ',
                              style: GoogleFonts.publicSans(
                                color: AppColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SvgIcon(icon: IconStrings.ratings),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgIcon(
                            icon: IconStrings.time,
                            color: AppColors.disabledColor,
                          ),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: 'Avg. ',
                              style: GoogleFonts.publicSans(
                                fontSize: 14.0,
                                color: AppColors.primaryColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '15 Minutes',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgIcon(
                            icon: IconStrings.ratingsPerson,
                            color: AppColors.disabledColor,
                          ),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: '1.5K ',
                              style: GoogleFonts.publicSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Ratings',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14.0,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 17.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description'.toUpperCase(),
                      style: GoogleFonts.publicSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.0),
                    child: Stack(
                      children: [
                        const ReadMoreText(
                          'Everyday Tea draws from tea’s rich history, dating back to 2737 BCE in ancient China. Sourced from Assam and Darjeeling, India’s finest tea regions, this blend offers a perfect balance of bold and aromatic flavors. Enjoy a cup steeped in centuries of tradition, bringing',
                          trimLines:
                              5, // Number of lines to display before truncating
                          colorClickableText: AppColors.primaryColor,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Read More',
                          trimExpandedText: 'Read Less',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.0,
                          ),
                          moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          lessStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        // Overlay gradient effect
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 30,
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white
                                        .withOpacity(0.0), // Transparent
                                    Colors.white.withOpacity(
                                        0.4), // Fade to white or background color
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SIZE',
                      style: GoogleFonts.publicSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Size Widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizeWidget(
                        text: 'S',
                      ),
                      const SizeWidget(
                        text: 'M',
                        bgColor: AppColors.disabledColor,
                      ),
                      SizeWidget(
                        text: 'L',
                        bgColor: AppColors.disabledColor.withOpacity(.4),
                        borderColor: AppColors.primaryColor.withOpacity(.4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 23.0),

                  // Add to cart
                  AddToCartButton(
                    onTap: () {
                      debugPrint('Add to cart pressed');
                    },
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
