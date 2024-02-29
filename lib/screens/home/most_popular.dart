import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/model/category.dart';
import 'package:fresh_store_ui/model/popular.dart';
import 'package:easy_localization/easy_localization.dart';

class MostPupularCategory extends StatefulWidget {
  const MostPupularCategory({super.key});

  @override
  State<MostPupularCategory> createState() => _MostPupularCategoryState();
}

class _MostPupularCategoryState extends State<MostPupularCategory> {
  final List<Category> datas = ConstantsModel.categories;

  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListView.separated(
        itemCount: datas.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildItem,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: MediaQuery.of(context).size.width * 0.02);
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final data = datas[index];
    final isActive = _selectIndex == index;
    var radius = BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.05));
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: const Color(0xFF101010), width: MediaQuery.of(context).size.width * 0.002),
        color: isActive ? const Color(0xFF101010) : const Color(0xFFFFFFFF),
      ),
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: radius,
        onTap: () => _onTapItem(index),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            data.title,
            style: TextStyle(
              color: isActive ? const Color(0xFFFFFFFF) : const Color(0xFF101010),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // user interact the item of special offers.
  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}

class MostPopularTitle extends StatelessWidget {
  const MostPopularTitle({
    Key? key,
    required this.onTapseeAll,
  }) : super(key: key);

  final Function onTapseeAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        children: [
          Text("Most Popular", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF212121))).tr(),
          Spacer(),
          TextButton(
            onPressed: () => onTapseeAll(),
            child: Text(
              "See All",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF212121),
              ),
            ).tr(),
          ),
        ],
      ),
    );
  }
}
