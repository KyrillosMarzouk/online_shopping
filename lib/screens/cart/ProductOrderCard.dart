import 'package:flutter/material.dart';


import 'package:easy_localization/easy_localization.dart';
import 'package:fresh_store_ui/model/order_item.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class ProductOrderCard extends StatefulWidget {
  OrderItem item;
  ProductOrderCard({super.key, required this.item});

  @override
  State<ProductOrderCard> createState() => _StampOrderCardState();
}

class _StampOrderCardState extends State<ProductOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.002),
      child: Card(
        elevation: MediaQuery.of(context).size.width * 0.02,
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
                                  child: Text(widget.item!.product.title!, textAlign: TextAlign.center,)
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                                  child: Row(
                                    children: [
                                      Text("Ordered qty : ".tr() + widget.item.qty!.toString(),  overflow: TextOverflow.ellipsis,maxLines: 2,),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Spacer(),
                    widget.item.product!.image == null ?
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
                          image: AssetImage('assets/images/'+widget.item.product!.image!),
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
