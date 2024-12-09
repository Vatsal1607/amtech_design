import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/business_selection/business_selection_provider.dart';
import 'package:amtech_design/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import '../../../core/utils/constant.dart';

class BusinessDropdown extends StatelessWidget {
  const BusinessDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<BusinessSelectionProvider>(context, listen: false);
    Widget searchChild(x, {bool isSelected = false}) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(x,
              style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.green : Colors.black)),
        );
    //* New dropdown (searchable)
    return SearchField(
      suggestionDirection: SuggestionDirection.flex,
      onSearchTextChanged: (query) {
        final filter = provider.suggestions
            .where((element) =>
                element.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return filter
            .map((e) => SearchFieldListItem<String>(e, child: searchChild(e)))
            .toList();
      },
      selectedValue: provider.selectedValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || !provider.suggestions.contains(value.trim())) {
          return 'Enter a valid country name';
        }
        return null;
      },
      onSubmit: (x) {},
      autofocus: false,
      key: const Key('searchfield'),
      hint: 'Select Your Company',
      itemHeight: 50,
      scrollbarDecoration: ScrollbarDecoration(
        thickness: 12,
        radius: Radius.circular(6),
        trackColor: AppColors.seaShell,
        trackBorderColor: AppColors.seaShell,
        // thumbColor: Colors.orange,
      ),
      suggestionStyle: GoogleFonts.publicSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      suggestionItemDecoration: BoxDecoration(
        color: AppColors.seaShell,
        // borderRadius: BorderRadius.circular(10),
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: AppColors.seaShell,
          ),
        ),
      ),
      searchInputDecoration: SearchInputDecoration(
        hintStyle: GoogleFonts.publicSans(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        prefixIcon: SvgIcon(icon: IconStrings.selectBusiness),

        ///* Suffix icon
        // suffixIcon: IconButton(
        //   icon: const Icon(
        //     Icons.clear, // Trailing icon
        //     color: Colors.red,
        //   ),
        //   onPressed: () {
        //     // Add clear action logic
        //   },
        // ),
        enabledBorder: kSearchDropDownBorder,
        focusedBorder: kSearchDropDownBorder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.seaShell,
            style: BorderStyle.solid,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
      ),
      suggestionsDecoration: SuggestionDecoration(
          // border: Border.all(color: Colors.orange),
          elevation: 8.0,
          selectionColor: Colors.grey.shade100,
          hoverColor: Colors.purple.shade100,
          // gradient: LinearGradient(
          //   colors: [Color(0xfffc466b), Color.fromARGB(255, 103, 128, 255)],
          //   stops: [0.25, 0.75],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      suggestions: provider.suggestions
          .map((e) => SearchFieldListItem<String>(e, child: searchChild(e)))
          .toList(),
      suggestionState: Suggestion.expand,
      onSuggestionTap: (SearchFieldListItem<String> x) {
        // setState(() {
        provider.selectedValue = x;
        // });
      },
    );

    //! Old dropdown: keep it for ref.
    // return Center(
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 17.w),
    //     decoration: BoxDecoration(
    //       color: Colors.transparent, // Background color for the dropdown
    //       borderRadius: BorderRadius.circular(100.r), // Circular border
    //       border: Border.all(
    //         color: AppColors.seaShell, // Border color
    //         width: 2, // Border width
    //       ),
    //     ),
    //     child: Row(
    //       children: [
    //         SvgIcon(icon: IconStrings.location), // Prefix icon
    //         const SizedBox(width: 8), // Spacing between icon and dropdown
    //         Expanded(
    //           child: Consumer<BusinessSelectionProvider>(
    //             builder: (context, provider, child) =>
    //                 DropdownButtonHideUnderline(
    //               child: DropdownButton2<String>(
    //                 dropdownStyleData: DropdownStyleData(
    //                   decoration: BoxDecoration(
    //                     color: AppColors.seaShell,
    //                     borderRadius:
    //                         BorderRadius.circular(10), // Rounded corners
    //                     border: Border.all(
    //                       color: Colors.grey, // Border color
    //                       width: 1, // Border width
    //                     ),
    //                   ),
    //                 ),
    //                 value: provider.dropdownValue,
    //                 isExpanded: true,
    //                 style: TextStyle(
    //                   fontSize: 15.sp,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.white,
    //                 ),
    //                 hint: RichText(
    //                   text: const TextSpan(
    //                     text: 'Select Your ',
    //                     style: TextStyle(
    //                       fontSize: 14,
    //                       color: Colors.white,
    //                     ),
    //                     children: <TextSpan>[
    //                       TextSpan(
    //                         text: 'Complex',
    //                         style: TextStyle(
    //                           fontSize: 14,
    //                           fontWeight: FontWeight.bold,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 items: [
    //                   ...provider.dropdownItems
    //                       .map<DropdownMenuItem<String>>((String value) {
    //                     return DropdownMenuItem<String>(
    //                       value: value,
    //                       child: Text(
    //                         value,
    //                         style: TextStyle(
    //                           fontSize: 14.sp,
    //                           fontWeight: FontWeight.bold,
    //                           color: AppColors.primaryColor,
    //                         ),
    //                       ),
    //                     );
    //                   }).toList(),
    //                   DropdownMenuItem<String>(
    //                     enabled: false, // non-selectadble
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         // Navigate to business register page
    //                         Navigator.pushNamed(
    //                           context,
    //                           Routes.register,
    //                         );
    //                       },
    //                       child: Container(
    //                         padding: EdgeInsets.all(10.w),
    //                         decoration: BoxDecoration(
    //                           color: AppColors.primaryColor,
    //                           borderRadius: BorderRadius.circular(25.r),
    //                         ),
    //                         child: Row(
    //                           mainAxisSize: MainAxisSize.min,
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'Can\'t find your business? '.toUpperCase(),
    //                               style: GoogleFonts.publicSans(
    //                                 fontSize: 12.sp,
    //                                 color: AppColors.seaShell,
    //                               ),
    //                             ),
    //                             Text(
    //                               'Register Now'.toUpperCase(),
    //                               style: GoogleFonts.publicSans(
    //                                 fontSize: 12.sp,
    //                                 color: AppColors.disabledColor,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //                 underline: const SizedBox.shrink(),
    //                 onChanged: provider.onChangeDropdown,
    //                 selectedItemBuilder: (BuildContext context) {
    //                   return provider.dropdownItems.map<Widget>((String value) {
    //                     return Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: Text(
    //                         value,
    //                         style: const TextStyle(
    //                           fontSize: 14,
    //                           color:
    //                               Colors.white, // Style for the selected item
    //                         ),
    //                       ),
    //                     );
    //                   }).toList();
    //                 },
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
