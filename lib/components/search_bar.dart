import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/screens/search_screen.dart';

class SearchBar extends StatelessWidget {
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 28.h),
      child: CupertinoSearchTextField(
        style: TextStyle(
          fontFamily: 'SF Pro',
          letterSpacing: 0.5,
        ),
        controller: search,
        borderRadius: BorderRadius.circular(30.0),
        backgroundColor: kSearchFieldColor,
        itemSize: 22,
        itemColor: kIconButtonColor,
        prefixInsets: EdgeInsets.only(left: 35.w),
        padding:
            EdgeInsets.only(right: 35.w, top: 21.h, bottom: 21.h, left: 16.w),
        onSubmitted: (value) {
          Navigator.pushNamed(context, SearchScreen.routName, arguments: value);
        },
      ),
    );
  }
}
