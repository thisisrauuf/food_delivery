import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195.h,
      margin: EdgeInsets.only(top: 40.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Address details',
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                'change',
                style: TextStyle(color: kOrangeColor),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Abderaouf Tiouche',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Divider(color: Colors.black45, height: 10.h),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Km 5 refinery road oppsite republic road, effurun, delta state'),
                    ),
                  ),
                  Divider(color: Colors.black45, height: 10.h),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('+213 770716156'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
