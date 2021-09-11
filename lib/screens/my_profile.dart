import 'package:flutter/material.dart';
import 'package:food_delivery/components/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Profile profileInfos = Provider.of<ProfileInfos>(context).profileInfos;
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'My profile',
        actions: Container(),
        leading: Container(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations',
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 17.w),
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15.w),
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('images/place2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  'Abderaouf Tiouche',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            profileInfos.email,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 0.7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'No 15 uti street off ovie palace road effurun delta state',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
