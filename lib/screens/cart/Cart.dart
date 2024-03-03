import 'package:flutter/material.dart';
import 'package:fresh_store_ui/components/app_bar.dart';
import 'package:fresh_store_ui/components/product_card.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/popular.dart';
import 'package:fresh_store_ui/screens/home/most_popular.dart';

import '../../model/Product.dart';
import 'package:easy_localization/easy_localization.dart';

import '../detail/detail_screen.dart';
import '../mostpopular/most_popular_screen.dart';
import 'ProductOrderCard.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double subTotal = 0;
  double delivery = 25.0;
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    if(subTotal == 0){
      for(var item in ConstantsModel.cart!){
        subTotal += item.qty! * item.product!.price!;
      }
    }
    totalAmount = subTotal + delivery;
    return Scaffold(
      appBar: FRAppBar.defaultAppBarWithoutBack(
        context,
        title: "Cart".tr(),
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
      body: ConstantsModel.cart.isEmpty?
      Center(
        child: Text(
          "There are no items in the cart".tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      )
          :
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            for(var item in ConstantsModel.cart!)
              ProductOrderCard(item: item, ),



            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.width * 0.02, left: MediaQuery.of(context).size.width * 0.02),
              width: MediaQuery.of(context).size.width,
              child: Card(
                surfaceTintColor: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Text(
                        "Payment summary",
                        // style: singleTripTitle(),
                      ).tr(),
                    ),

                    Container(
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.005),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: Text("Subtotal".tr(),),
                              trailing: Text(subTotal.toString() + " EGP",),
                            ),
                            ListTile(
                              leading: Text("Delivery fee".tr(), ),
                              trailing: Text(delivery.toString() + " EGP", ),
                            ),
                            ListTile(
                              leading: Text("Total amount".tr(), ),
                              trailing: Text(totalAmount.toString() + " EGP", ),
                            ),

                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),


            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(
                children: [


                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.002,),
                    child: ElevatedButton(
                      onPressed: (){
                        // Navigator.of(context).pop();
                        Navigator.pushNamed(context, MostPopularScreen.route());
                      },
                      // style: newButtonSecondaryStyle(MediaQuery.of(context).size.width * 0.18, MediaQuery.of(context).size.height * 0.015),
                      child: Text(
                        "Order more",
                        // style: textInButtonBlack(),
                        textAlign: TextAlign.center,
                      ).tr(),
                    ),
                  ),

                  Spacer(),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.002,),
                    child: ElevatedButton(
                      onPressed: () async {

                          showSuccessOrderDialog(context);
                      },
                      // style: newButtonStyle(MediaQuery.of(context).size.width * 0.18, MediaQuery.of(context).size.height * 0.015),
                      child: Text(
                        "Confirm order",
                        // style: textInButton(),
                        textAlign: TextAlign.center,
                      ).tr(),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      )
      ,
        // const SliverAppBar(flexibleSpace: SizedBox(height: 24))
    );

  }



  Future<void> showSuccessOrderDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text("Success".tr()),
            content: SizedBox(
              // width: MediaQuery.of(context).size.width * 0.2,
              // height: MediaQuery.of(context).size.height * 0.3,
              child: Text("Order confirmed successfully").tr(),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(""
                    "Ok").tr(),
                onPressed: () {

                  Navigator.of(context).pop();
                  setState(() {
                    ConstantsModel.cart = [];
                  });
                  // Navigator.pushNamed(context, MostPopularScreen.route());

                },
              ),
            ]
        );
      },
    );
  }
}

