import 'package:flutter/material.dart';
import 'package:fresh_store_ui/components/product_card.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/popular.dart';
import 'package:fresh_store_ui/screens/detail/detail_screen.dart';
import 'package:fresh_store_ui/screens/home/hearder.dart';
import 'package:fresh_store_ui/screens/home/most_popular.dart';
import 'package:fresh_store_ui/screens/home/search_field.dart';
import 'package:fresh_store_ui/screens/home/special_offer.dart';
import 'package:fresh_store_ui/screens/mostpopular/most_popular_screen.dart';
import 'package:fresh_store_ui/screens/special_offers/special_offers_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final datas = ConstantsModel.mostPopular;

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale("ar"));
    var padding = EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.width * 0.05, 0);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
            sliver: SliverAppBar(
              pinned: true,
              flexibleSpace: HomeAppBar(),
            ),
          ),
          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) => _buildBody(context)),
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: padding,
            sliver: _buildPopulars(),
          ),
          SliverAppBar(flexibleSpace: SizedBox(height: MediaQuery.of(context).size.width * 0.05))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SearchField(),
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        MostPopularTitle(onTapseeAll: () => _onTapMostPopularSeeAll(context)),
        // SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        // const MostPupularCategory(),
      ],
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
      delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: 8),
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = datas[index % datas.length];
    return ProductCard(
      data: data,
      ontap: (data) {
        {
          ConstantsModel.singleProduct = data;
          Navigator.pushNamed(context, ShopDetailScreen.route());
        }
      }
    );
  }

  void _onTapMostPopularSeeAll(BuildContext context) {
    Navigator.pushNamed(context, MostPopularScreen.route());
  }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.pushNamed(context, SpecialOfferScreen.route());
  }
}
