import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/Product.dart';
import 'package:fresh_store_ui/model/order_item.dart';
import 'package:fresh_store_ui/size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class ShopDetailScreen extends StatefulWidget {
  const ShopDetailScreen({super.key});

  static String route() => '/shop_detail';

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  int _quantity = 1;
  bool _iscollected = false;
  double totalPrice = 0;
  Product? product = ConstantsModel.singleProduct;
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    totalPrice = _quantity * product!.price;
    quantityController.text = _quantity.toString();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: getProportionateScreenHeight(428),
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.05)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: const Color(0xFFeeeeee),
                      child: Image.asset(
                        'assets/images/' + product!.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildTitle(),
                        const SizedBox(height: 16),
                        _buildLine(),
                        const SizedBox(height: 16),
                        ..._buildDescription(),
                        const SizedBox(height: 24),
                        _buildQuantity(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buldFloatBar()
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTitle() {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: FittedBox(
              child: Text(
                product!.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _iscollected = !_iscollected),
            icon: Image.asset('assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png'),
            iconSize: 28,
          ),
        ],
      ),
      // const SizedBox(height: 12),
      // Row(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      //       decoration: const BoxDecoration(
      //         borderRadius: BorderRadius.all(Radius.circular(6)),
      //         color: Color(0xFFeeeeee),
      //       ),
      //       child: const Text(
      //         '9,742 sold',
      //         style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      //       ),
      //     ),
      //     const SizedBox(width: 16),
      //     Image.asset('assets/icons/start@2x.png', height: 20, width: 20),
      //     const SizedBox(width: 8),
      //     const Text(
      //       '4.8 (6,573 reviews)',
      //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      //     ),
      //   ],
      // ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  List<Widget> _buildDescription() {
    return [
      Text("UOM".tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ExpandableText(
        product!.uom,
        expandText: 'view more',
        collapseText: 'view less',
        linkStyle: TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
      Text("UOM price".tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ExpandableText(
        product!.price.toString() + " EGP".tr(),
        expandText: 'view more',
        collapseText: 'view less',
        linkStyle: TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        Text("Quantity".tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color(0xFFF3F3F3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: Image.asset('assets/icons/detail/minus@2x.png', scale: 2),
                  onTap: () {
                    if (_quantity <= 1) return;
                    setState(() => _quantity -= 1);
                  },
                ),
                const SizedBox(width: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  // height: MediaQuery.of(context).size.height * 0.08,
                  child: TextField(
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,),
                    keyboardType: TextInputType.number,
                    controller: quantityController,
                    maxLength: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                    onChanged: (value){
                        if(value == "0" || value == ""){
                          setState(() {
                            _quantity = 1;
                          });
                        }
                        else{
                          setState(() {
                            _quantity = int.parse(value);
                          });
                        }
                    },
                  ),
                ),
                // Text('$_quantity',
                //     style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //     )),
                const SizedBox(width: 20),
                InkWell(
                  child: Image.asset('assets/icons/detail/plus@2x.png', scale: 2),
                  onTap: () => setState(() => _quantity += 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: getProportionateScreenWidth(258),
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
                ConstantsModel.cart.add(OrderItem(ConstantsModel.singleProduct!, _quantity));
                // showSuccessDialog(context);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                  const SizedBox(width: 16),
                  Text(
                    "Add to Cart".tr(),
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
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total price".tr(), style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
                    SizedBox(height: 6),
                    Text(totalPrice.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    Text(" EGP".tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
                buildAddCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Future<void> showSuccessDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success").tr(),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Item added to cart successfully").tr(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text("Ok").tr(),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// class ExpandableText extends StatefulWidget {
//   ExpandableText({this.text = ""});
//   //text is the total text of our expandable widget
//   final String text;
//   @override
//   _ExpandableTextState createState() => _ExpandableTextState();
// }

// class _ExpandableTextState extends State<ExpandableText> {
//   static const viewMore = ' view more...';
//   static const fixedLength = 50;
//   late String textToDisplay;
//   @override
//   void initState() {
//     //if the text has more than a certain number of characters, the text we display will consist of that number of characters;
//     //if it's not longer we display all the text
//     print(widget.text.length);

//     //we arbitrarily chose 25 as the length
//     textToDisplay = widget.text.length > 25 ? widget.text.substring(0, 25) + viewMore : widget.text;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Text(textToDisplay),
//       onTap: () {
//         //if the text is not expanded we show it all
//         if (widget.text.length > 25 && textToDisplay.length <= (25 + viewMore.length)) {
//           setState(() {
//             textToDisplay = widget.text;
//           });
//         }
//         //else if the text is already expanded we contract it back
//         else if (widget.text.length > 25) {
//           setState(() {
//             textToDisplay = widget.text.substring(0, 25) + viewMore;
//           });
//         }
//       },
//     );
//   }
// }


