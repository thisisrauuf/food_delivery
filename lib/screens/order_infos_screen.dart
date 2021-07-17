import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/components/orderInfo_card.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/components/appBar.dart';
import 'package:food_delivery/providers/orders_provider.dart';

class OrderInfosScreen extends StatelessWidget {
  static String routeName = 'Order-Info-Screen';
  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedOrder =
        Provider.of<Orders>(context, listen: false).findOrderById(orderId);
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Order details',
        actions: Container(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 31.w,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: EdgeInsets.only(right: 40.w, left: 40.w, top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order status',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            Container(
              width: double.infinity,
              height: 150.h,
              margin: EdgeInsets.symmetric(vertical: 30.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Center(child: Text('data')),
            ),
            Text(
              'Products ordered',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: selectedOrder.products.length,
              itemBuilder: (context, i) =>
                  OrderInfoCard(product: selectedOrder.products[i]),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.h, bottom: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${selectedOrder.amount} \$',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
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
