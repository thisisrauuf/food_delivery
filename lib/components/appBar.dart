import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  required Widget actions,
  required Widget leading,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(alignment: Alignment.centerLeft, child: leading),
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'SF Pro'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(alignment: Alignment.centerRight, child: actions),
          ),
        ],
      ),
    ),
    centerTitle: true,
  );
}

AppBar buildAppBar2(
  BuildContext context, {
  required String title,
  required Widget actions,
  required Widget leading,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(alignment: Alignment.centerLeft, child: leading),
          ),
          Expanded(
            flex: 4,
            child: Container(
                alignment: Alignment.center,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: title),
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(alignment: Alignment.centerRight, child: actions),
          ),
        ],
      ),
    ),
    // title: Container(
    //   width: double.infinity,
    //   child: Row(
    //     children: [
    //       Container(
    //         padding: EdgeInsets.only(left: 35.w),
    //         alignment: Alignment.center,
    //         child: TextField(
    //           decoration:
    //               InputDecoration(border: InputBorder.none, hintText: title),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // centerTitle: true,
    // leading: leading,
    // actions: actions,
  );
}
