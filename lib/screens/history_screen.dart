import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/screens/order_infos_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:food_delivery/components/appBar.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/providers/orders_provider.dart';

class HistoryScreen extends StatelessWidget {
  static String routeName = 'history-screen';

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    // final orders = ordersData.orders;
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Order history',
        actions: Container(),
        leading: Container(),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: kOrangeColor));
          } else {
            if (dataSnapshot.hasError) {
              // error Handling stuff
            } else {
              return Consumer<Orders>(
                builder: (context, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  padding: EdgeInsets.only(right: 40.w, left: 40.w),
                  itemBuilder: (context, i) =>
                      OrderHistoryCard(order: ordersData.orders[i]),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final OrderItem order;
  OrderHistoryCard({required this.order});
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context, listen: false);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.h),
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.w),
          width: double.infinity,
          height: 250.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  'Order N° ${order.id}',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: kOrangeColor),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                    ),
                    Text(
                      '${order.amount} \$',
                      style: kHistoryCardTextStyle,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.5),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Items'),
                    Text(
                      '${ordersData.countItems(order)}',
                      style: kHistoryCardTextStyle,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.5),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order date'),
                    Text(
                      '${DateFormat('dd-MM-yyyy  hh:mm').format(order.date)}',
                      style: kHistoryCardTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OrderInfosScreen.routeName,
                      arguments: order.id);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: kOrangeColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
