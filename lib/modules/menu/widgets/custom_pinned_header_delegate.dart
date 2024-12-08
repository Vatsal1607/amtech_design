// import 'package:amtech_design/modules/menu/widgets/pinned_header.dart';
// import 'package:flutter/material.dart';

// class CustomPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     // Restrict the pinned content's movement when shrinkOffset > 100
//     double effectiveOffset = shrinkOffset > 100 ? 100 : shrinkOffset;

//     return PinnedHeaderDelegate(
//       child: Container(),
//       minExtent: 60,
//       maxExtent: 60,
//     );
//     // return Transform.translate(
//     //   offset: Offset(0, -effectiveOffset),
//     //   child: Container(
//     //     color: Colors.blue,
//     //     height: maxExtent,
//     //     alignment: Alignment.center,
//     //     child: Text(
//     //       'Pinned Content',
//     //       style: TextStyle(
//     //         color: Colors.white,
//     //         fontSize: 20.0,
//     //         fontWeight: FontWeight.bold,
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }

//   @override
//   double get maxExtent => 60.0; // Height of the pinned header

//   @override
//   double get minExtent => 60.0; // Height when pinned

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
