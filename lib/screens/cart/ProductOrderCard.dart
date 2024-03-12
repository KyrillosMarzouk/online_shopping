import 'package:flutter/material.dart';


import 'package:easy_localization/easy_localization.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/order_item.dart';
import 'package:fresh_store_ui/screens/cart/Cart.dart';
import 'package:fresh_store_ui/screens/home/hearder.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class ProductOrderCard extends StatefulWidget {
  OrderItem item;
  final VoidCallback callback;
  ProductOrderCard({super.key, required this.item, required this.callback});

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
                              Row(
                                children: [
                                  InkWell(
                                    child: Image.asset('assets/icons/detail/minus@2x.png', scale: 2),
                                    onTap: () {
                                      if (widget.item.qty <= 1) return;
                                      setState(() => widget.item.qty -= 1);
                                    },
                                  ),
                                  const SizedBox(width: 20),

                                  Text(widget.item.qty.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    child: Image.asset('assets/icons/detail/plus@2x.png', scale: 2),
                                    onTap: () {
                                      for(var i in ConstantsModel.cart){
                                        if(i == widget.item){
                                          setState(() {
                                            i.qty += 1;
                                            widget.callback;
                                          });


                                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeAppBar()));
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
