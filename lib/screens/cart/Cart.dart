import 'package:flutter/material.dart';
import 'package:fresh_store_ui/components/app_bar.dart';
import 'package:fresh_store_ui/components/product_card.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/popular.dart';
import 'package:fresh_store_ui/screens/home/most_popular.dart';

import '../../model/Order.dart';
import '../../model/Product.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../model/order_item.dart';
import '../../size_config.dart';
import '../detail/detail_screen.dart';
import '../mostpopular/most_popular_screen.dart';
import 'ProductOrderCard.dart';
class CartScreen extends StatefulWidget {
  double subTotal = 0;
  double delivery = 25.0;
  double totalAmount = 0;
  CartScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  Widget build(BuildContext context) {
    if(widget.subTotal == 0){
      for(var item in ConstantsModel.cart!){
        widget.subTotal += item.qty! * item.product!.price!;
      }
    }
    widget.totalAmount = widget.subTotal + widget.delivery;
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
              ProductOrderWidget(item),



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
                              trailing: Text(widget.subTotal.toString() + " EGP",),
                            ),
                            ListTile(
                              leading: Text("Delivery fee".tr(), ),
                              trailing: Text(widget.delivery.toString() + " EGP", ),
                            ),
                            ListTile(
                              leading: Text("Total amount".tr(), ),
                              trailing: Text(widget.totalAmount.toString() + " EGP", ),
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


                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.45,
                  //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.002,),
                  //   child: ElevatedButton(
                  //     onPressed: (){
                  //       // Navigator.of(context).pop();
                  //       Navigator.pushNamed(context, MostPopularScreen.route());
                  //     },
                  //     // style: newButtonSecondaryStyle(MediaQuery.of(context).size.width * 0.18, MediaQuery.of(context).size.height * 0.015),
                  //     child: Text(
                  //       "Order more",
                  //       // style: textInButtonBlack(),
                  //       textAlign: TextAlign.center,
                  //     ).tr(),
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.002,),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(29)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 8),
                          blurRadius: 15,
                          color: const Color(0xFF101010).withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(29)),
                        // splashColor: const Color(0xFFEEEEEE),
                        onTap: () {
                          Navigator.pushNamed(context, MostPopularScreen.route());
                          // showSuccessOrderDialog(context);
                          // ConstantsModel.cart.add(OrderItem(ConstantsModel.singleProduct!, _quantity));
                          // showSuccessDialog(context);
                          // Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Order more".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.002,),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(29)),
                      color: const Color(0xFF101010),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 8),
                          blurRadius: 20,
                          color: const Color(0xFF101010).withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(29)),
                        // splashColor: const Color(0xFFEEEEEE),
                        onTap: () {
                          showSuccessOrderDialog(context);
                          // ConstantsModel.cart.add(OrderItem(ConstantsModel.singleProduct!, _quantity));
                          // showSuccessDialog(context);
                          // Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Confirm order".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )

                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.45,
                  //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.002,),
                  //   child: ElevatedButton(
                  //     onPressed: () async {
                  //
                  //         showSuccessOrderDialog(context);
                  //     },
                  //     // style: newButtonStyle(MediaQuery.of(context).size.width * 0.18, MediaQuery.of(context).size.height * 0.015),
                  //     child: Text(
                  //       "Confirm order",
                  //       // style: textInButton(),
                  //       textAlign: TextAlign.center,
                  //     ).tr(),
                  //   ),
                  // ),
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
                  ConstantsModel.orders.add(
                      Order(
                        (ConstantsModel.orders.length + 1).toString(),
                        "قيد التنفيذ",
                        ConstantsModel.cart
                      )
                  );
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

  Widget ProductOrderWidget(OrderItem item){
    return Container(
      // margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.00005),
      child: Card(
        elevation: MediaQuery.of(context).size.width * 0.005,
        surfaceTintColor: Colors.white,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Wrap(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.all( MediaQuery.of(context).size.width * 0.02),
                                  child: Text(
                                      item!.product.title!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: Image.asset('assets/icons/detail/minus@2x.png', scale: 2),
                                    onTap: () {
                                      if (item.qty == 1){
                                        for(var i in ConstantsModel.cart){
                                          if(i == item){
                                            setState(() {
                                              ConstantsModel.cart.remove(i);
                                              widget.subTotal = 0;
                                              for(var item in ConstantsModel.cart!){
                                                widget.subTotal += item.qty! * item.product!.price!;
                                              }
                                              widget.totalAmount = widget.subTotal + widget.delivery;

                                            });

                                          }
                                        }
                                      }
                                      else{
                                        for(var i in ConstantsModel.cart){
                                          if(i == item){
                                            setState(() {
                                              i.qty -= 1;
                                              widget.subTotal = 0;
                                              for(var item in ConstantsModel.cart!){
                                                widget.subTotal += item.qty! * item.product!.price!;
                                              }
                                              widget.totalAmount = widget.subTotal + widget.delivery;

                                            });

                                          }
                                        }
                                      }

                                    },
                                  ),
                                  const SizedBox(width: 20),

                                  Text(item.qty.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                                  const SizedBox(width: 20),
                                  InkWell(
                                      child: Image.asset('assets/icons/detail/plus@2x.png', scale: 2),
                                      onTap: () {
                                        for(var i in ConstantsModel.cart){
                                          if(i == item){
                                            setState(() {
                                              i.qty += 1;
                                              widget.subTotal = 0;
                                                for(var item in ConstantsModel.cart!){
                                                  widget.subTotal += item.qty! * item.product!.price!;
                                                }
                                              widget.totalAmount = widget.subTotal + widget.delivery;

                                            });

                                          }
                                        }


                                      }
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Spacer(),
                    item.product!.image == null ?
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/no_image.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.03)),
                      ),
                    ) :
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/'+item.product!.image!),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.03)),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}

