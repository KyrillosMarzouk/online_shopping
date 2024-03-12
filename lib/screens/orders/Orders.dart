import 'package:flutter/material.dart';
import 'package:fresh_store_ui/components/app_bar.dart';
import 'package:fresh_store_ui/components/product_card.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/popular.dart';
import 'package:fresh_store_ui/screens/home/most_popular.dart';
import 'package:fresh_store_ui/screens/orders/ReOrder.dart';

import '../../model/Order.dart';
import '../../model/Product.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../model/order_item.dart';
import '../../size_config.dart';
import '../detail/detail_screen.dart';
import '../mostpopular/most_popular_screen.dart';
class OrdersScreen extends StatefulWidget {

  OrdersScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: FRAppBar.defaultAppBarWithoutBack(
        context,
        title: "Orders".tr(),
        actions: [
          // IconButton(
          //   icon: Image.asset('assets/icons/search@2x.png', scale: 2.0),
          //   onPressed: () {},
          // ),
          Image.asset(
            'assets/images/logo.png',
            scale: 2.0,
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            for(var item in ConstantsModel.orders!)
              OrderCardWidget(item),


          ],
        ),
      )
      ,
      // const SliverAppBar(flexibleSpace: SizedBox(height: 24))
    );

  }

  Widget OrderCardWidget(Order order){
    return InkWell(
      onTap: (){
        ConstantsModel.singleOrder = order;
        Navigator.pushNamed(context, ReOrderScreen.route());
      },
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.00005),
        child: Card(
          elevation: MediaQuery.of(context).size.width * 0.01,
          surfaceTintColor: Colors.white,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/logo.png", width: MediaQuery.of(context).size.width * 0.15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                          child: Text("متجر حبوبه", textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                          ),)
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.width * 0.7,
                            child: Wrap(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                                        // margin: EdgeInsets.all( MediaQuery.of(context).size.width * 0.02),
                                        child: Text("Order Status : ".tr() + order!.status!, textAlign: TextAlign.center,)
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                                        // margin: EdgeInsets.all( MediaQuery.of(context).size.width * 0.02),
                                        child: Text("Order Id : ".tr() + order!.id!, textAlign: TextAlign.center,)
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                                      // margin: EdgeInsets.all( MediaQuery.of(context).size.width * 0.02),
                                        child: Text("Order Date : ".tr() + "04-03-2024", textAlign: TextAlign.center,)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),


                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}

