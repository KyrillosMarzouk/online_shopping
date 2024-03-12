import 'package:flutter/material.dart';
import 'package:fresh_store_ui/components/app_bar.dart';
import 'package:fresh_store_ui/components/product_card.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/popular.dart';
import 'package:fresh_store_ui/screens/home/most_popular.dart';

import '../../model/Product.dart';
import 'package:easy_localization/easy_localization.dart';

import '../detail/detail_screen.dart';
class MostPopularScreen extends StatefulWidget {
  const MostPopularScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<MostPopularScreen> createState() => _MostPopularScreenState();
}

class _MostPopularScreenState extends State<MostPopularScreen> {
  final categories = ConstantsModel.categories;
  final datas = ConstantsModel.products;
  int selectedIndex = 0;
  List<Product> newList = [];

  @override
  Widget build(BuildContext context) {
    newList = ConstantsModel.products;
    print("selected index : " + selectedIndex.toString());
    if(selectedIndex == 0){
      newList = datas;
    }
    else{
      newList = [];
      for(int i = 0; i < datas.length; i++){
        if(datas[i].catId == selectedIndex){
          newList.add(datas[i]);
          print("added : " + i.toString());
        }
      }
    }
    const padding = EdgeInsets.fromLTRB(24, 24, 24, 0);
    return Scaffold(
      appBar: FRAppBar.defaultAppBar(
        context,
        title: "Products".tr(),
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
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              ((context, index) {
                return Column(
                  children: [
                    _buildBody(),
                  ],
                );
              }),
              childCount: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: padding,
          sliver: _buildPopulars(),
        ),
        // const SliverAppBar(flexibleSpace: SizedBox(height: 24))
      ]),
    );
  }

  Widget _buildPopulars() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 185,
        mainAxisSpacing: 24,
        crossAxisSpacing: 16,
        mainAxisExtent: 285,
      ),
      delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: newList.length),
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = newList[index % newList.length];
    return ProductCard(
      data: data,
      ontap: (data) {
        ConstantsModel.singleProduct = data;
        Navigator.pushNamed(context, ShopDetailScreen.route());
      }
    );
  }


  Widget _buildBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.separated(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildItem,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: MediaQuery.of(context).size.width * 0.02);
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final data = categories[index];
    final isActive = selectedIndex == index;
    var radius = BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.1));
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.2,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: const Color(0xFF101010), width: MediaQuery.of(context).size.width * 0.002),
            color: isActive ? Colors.green.withOpacity(0.5) : const Color(0xFFFFFFFF),
          ),
          alignment: Alignment.center,
          child: InkWell(
            borderRadius: radius,
            onTap: () => _onTapItem(index),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Image.asset(categories[index].icon),
            ),
          ),
        ),
        Text(
          data.title,
          style: TextStyle(
            color: const Color(0xFF101010),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // user interact the item of special offers.
  void _onTapItem(int index) {
    setState(() {
      selectedIndex = categories[index].id;
    });
  }
}

