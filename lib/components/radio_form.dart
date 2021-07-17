import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/constants.dart';

class RadioInputForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 42.h),
      height: 196.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery method',
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 30.h),
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: 1,
                            onChanged: (value) {},
                            activeColor: kOrangeColor,
                          ),
                          Container(child: Text('Door delivery')),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      width: 200.w,
                      child: Divider(color: Colors.black54, height: 10.h)),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: 1,
                            onChanged: (value) {},
                            activeColor: kOrangeColor,
                          ),
                          Container(child: Text('Local pickup')),
                        ],
                      ),
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
