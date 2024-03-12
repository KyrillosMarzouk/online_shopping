import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/model/popular.dart';

import '../model/Product.dart';
import 'package:easy_localization/easy_localization.dart';

typedef ProductCardOnTaped = void Function(Product data);

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.data, this.ontap});

  final Product data;
  final ProductCardOnTaped? ontap;

  @override
  Widget build(BuildContext context) {
    // final data = datas[index % datas.length];
    var borderRadius = BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.05));
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => ontap?.call(data),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.white,
            ),
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
              ),
              elevation: MediaQuery.of(context).size.width * 0.01,
              child: Stack(
                children: [
                  Image.asset("assets/images/" + data.image, width: MediaQuery.of(context).size.width * 0.5, height: MediaQuery.of(context).size.height * 0.2, fit: BoxFit.fill,),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.02,
                    child: Image.asset('assets/icons/not_collected@2x.png', width: MediaQuery.of(context).size.width * 0.09, height: MediaQuery.of(context).size.height * 0.035),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Wrap(
              children: [
                FittedBox(
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildSoldPoint(4.5, data.uom, context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${data.price.toStringAsFixed(2)}' + " EGP".tr(),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
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

        ],
      ),
    );
  }

  Widget _buildSoldPoint(double star, String sold, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset('assets/icons/start@2x.png', width: 20, height: 20),
        // const SizedBox(width: 8),
        // Text(
        //   '$star',
        //   style: const TextStyle(
        //     color: Color(0xFF616161),
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // const SizedBox(width: 8),
        // const Text(
        //   '|',
        //   style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF616161), fontSize: 14),
        // ),
        // const SizedBox(width: 8),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: const Color(0xFF101010).withOpacity(0.08),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$sold',
                style: const TextStyle(
                  color: Color(0xFF35383F),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
