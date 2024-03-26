import 'package:flutter/material.dart';

class MainPageView1 extends StatefulWidget {
  const MainPageView1({super.key});

  @override
  State<MainPageView1> createState() => _MainPageView1State();
}

class _MainPageView1State extends State<MainPageView1> {

  PageController pageController = PageController();

  @override
  void dispose(){
    this.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // 배너, 이용권 화면
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container( //
                color: Colors.grey,
              )
            ],
          ),
        ),
        Container(
          color: Colors.red,
        )


      ],
    );
  }
}

class BannerMenuModel {
  final String idx; // 배너 index
  //const 생성자
  const BannerMenuModel({required this.idx});
}

class BannerItemModel {
  final String img;
  const BannerItemModel({required this.img});
}

class BannerModel {
  final List<BannerMenuModel> menus;
  final List<BannerItemModel> items;
  const BannerModel({required this.menus, required this.items});
}

