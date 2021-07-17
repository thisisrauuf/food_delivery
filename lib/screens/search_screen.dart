// import 'package:flutter/material.dart';
// import 'package:food_delivery/components/appBar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../constants.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar2(
//         context,
//         title: 'Search',
//         actions: [],
//         leading: Transform.translate(
//           offset: Offset(30.w, 0),
//           child: IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.chevron_left,
//               color: Colors.black,
//               size: 31.w,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 37.h),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Color(0xffF9F9F9),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.topCenter,
//               padding: EdgeInsets.only(top: 35.h, left: 34.w, right: 34.w),
//               child: Text(
//                 'Found 8 results',
//                 style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
//               ),
//             ),
//             SizedBox(height: 45.h),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: StaggeredGridView.countBuilder(
//                   padding: EdgeInsets.symmetric(horizontal: 30.w),
//                   crossAxisCount: 2,
//                   itemCount: foods.length,
//                   crossAxisSpacing: 20.w,
//                   mainAxisSpacing: 17.h,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) => Container(
//                     height: 250.h,
//                     child: Stack(
//                       alignment: Alignment.topCenter,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 15.w, vertical: 20.h),
//                           width: double.infinity,
//                           margin: EdgeInsets.only(top: 40.h),
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(Radius.circular(30)),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(
//                                 foods[index].name,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 22.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               SizedBox(height: 16.h),
//                               Text(
//                                 '${foods[index].price} £',
//                                 style: TextStyle(
//                                   color: kOrangeColor,
//                                   fontSize: 17.sp,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Image.asset(
//                             foods[index].image,
//                             height: 110.h,
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   staggeredTileBuilder: (index) => StaggeredTile.fit(1),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
