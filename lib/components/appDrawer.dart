import 'package:flutter/material.dart';
import 'package:food_delivery/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    return SafeArea(
      child: Drawer(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          color: Color(0xffF2F2F2),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.h),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/place1.jpg'),
                  radius: 45,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Abderaouf Tiouche',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  authData.logout();
                },
                child: ListTile(
                  leading: Icon(Icons.exit_to_app_outlined),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
