import 'package:flutter/material.dart';

class MainPageView1 extends StatefulWidget {
  const MainPageView1({super.key});

  @override
  State<MainPageView1> createState() => _MainPageView1State();
}

class _MainPageView1State extends State<MainPageView1> {

  PageController pageController = PageController();
  BannerModel bannerModel = BannerModel(
    menus: [
      BannerMenuModel(txt: "idx")],
    items: [
      BannerItemModel(img: "img", des: "des")]
  );

  @override
  void dispose(){
    this.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // 배너, 이용권 화면
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container( //
                  child : banner(bannerModel),
                )
              ],
            ),
          ),
          Container(
            color: Colors.red,
          )

        ],
      ),
    );
  }

  Widget banner(BannerModel model) {
    return Container(
      child: Column(
        children: [
          Row(
            children:
              model.menus.map<Widget>((BannerMenuModel menuModel) => TextButton(
                onPressed: (){
                  int index = model.menus.indexOf(menuModel);
                  this.pageController.jumpToPage(index);
                },
                child: Text(menuModel.txt),
                )).toList(),
          ),
          Container(
            width: 300.0,
            height: 300.0,
            color: Colors.red,
            child: PageView.builder(
              controller: pageController,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) => Container(
                child: Center(
                  child: Text(model.items[index].des),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BannerMenuModel {
  final String txt; // 배너 index
  //const 생성자
  const BannerMenuModel({required this.txt});
}

class BannerItemModel {
  final String img;
  final String des;
  const BannerItemModel({required this.img, required this.des});
}

class BannerModel {
  final List<BannerMenuModel> menus;
  final List<BannerItemModel> items;
  const BannerModel({required this.menus, required this.items});
}

