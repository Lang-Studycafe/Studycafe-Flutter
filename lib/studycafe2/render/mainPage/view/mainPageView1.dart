import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studycafe/studycafe2/render/detailPage/detailPage.dart';
import 'package:studycafe/studycafe2/render/ticketPage/ticketPage.dart';

class MainPageView1 extends StatefulWidget {
  const MainPageView1({super.key});

  @override
  State<MainPageView1> createState() => _MainPageView1State();
}

class _MainPageView1State extends State<MainPageView1> {

  PageController pageController = PageController();
  BannerModel bannerModel = BannerModel(
    menus: [
      BannerMenuModel(txt: "1"),
      BannerMenuModel(txt: "2"),
      BannerMenuModel(txt: "3")
    ],
    items: [
      BannerItemModel(img: "https://modo-phinf.pstatic.net/20240108_272/17046944077993rOdO_PNG/mosaJzU4J9.png?type=w556"),
      BannerItemModel(img: "https://modo-phinf.pstatic.net/20240119_154/1705659481981Ll3FG_PNG/mosa1Nydaj.png?type=w556"),
      BannerItemModel(img: "https://modo-phinf.pstatic.net/20240202_226/1706858283629cw3X3_PNG/mosa6Lv5x5.png?type=w720")
    ]
  );

  int pageIndex = 0;

  @override
  void initState(){
    print("INIT");
    run();
    super.initState();
  }

  void run() {
    Timer.periodic(Duration(seconds: 3), (Timer timer)
    {
      this.pageController.nextPage(
          duration: Duration(seconds: 1),
          curve: Curves.linear
      );
    });
  }

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
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => TicketPage()),
                );
              },
              child: PageView(
                children:[
                  Container(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black12,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child:
                            Container(
                              color: Colors.transparent,
                              margin:EdgeInsets.only(top: 100.0),
                              width: MediaQuery.of(context).size.width,
                              child:
                              Icon(
                                Icons.add_card,
                                color: Colors.black26,
                                size:150.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children:[
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  child:
                                    Text("스티디룸 예약",
                                    textAlign: TextAlign.center,
                                    style:
                                      TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child:
                                    Text("이용권 구매는 화면을 누르시면 가능합니다",
                                    style:
                                      TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w200
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget banner(BannerModel model) {
    return Container(
      child: Column(
        children: [

          Container(
            //width: 380.0,
            height: 90.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            color: Colors.blue,
            child: PageView.builder(
              onPageChanged: (int index){
                this.pageIndex = index % bannerModel.items.length;
              },
              controller: pageController,
              //itemCount: model.items.length,
              itemBuilder: (BuildContext context, int index) {
                final pageIndex = index % bannerModel.items.length;
                final BannerItemModel item = model.items[pageIndex];
                final BannerItemModel(:img) = item;
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                         builder: (BuildContext context) => DetailPage(index: pageIndex),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.img),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                );
              },
            ),
          ),
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
  const BannerItemModel({required this.img});
}

class BannerModel {
  final List<BannerMenuModel> menus;
  final List<BannerItemModel> items;
  final void Function(int)? onTap;

  const BannerModel({
    required this.menus,
    required this.items,
    this.onTap,
  });
}

