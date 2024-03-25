import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home:앱을 실행할 때 첫 화면에 무엇을 표시할지 정함
      home: MainPage(), // MainPage 클래스를 위젯의 첫화면으로 실행
    );
  }
}

//StatefulWidget: 위젯 클래스
//StatefulWidget을 상속받은 MainPage 클래스
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  
  /*
  createState함수 재정의
  반환값 : State를 상속받은 클래스
  State : StatefulWidget의 상태값을 유지하고 화면을 구성하는 클래스
  */
  @override
  State<MainPage> createState() => _MainPageState();
}

//State를 상속받은 클래스
//State클래스에서 상태 관리 가능
class _MainPageState extends State<MainPage> {
  // 상태(변수) : State에 선언한 변수를 의미, 화면전환의 기준
  int bottomIndex = 0;
  //PageController 객체에 PageView의 맨 처음 보일 페이지 설정 가능
  PageController pageController = PageController();

  //함수 내에 변수 또는 함수 선언은 신중히 해야함
  //=> 화면과 관련없는 속성값(상태변수) 떄문에 화면을 다시 빌드하면 비효율적이기 때문
  //build함수에서 반환하는 위젯이 화면을 구성
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('스터디카페'),
        actions: [
          IconButton(onPressed: () {} , icon: Icon(Icons.add_card))
        ],
      ),
      body: PageView(
        controller: this.pageController,
        physics: NeverScrollableScrollPhysics(), //스크롤되지 않도록 함
        //BottomNavigationBar와 상태를 동기화
        onPageChanged: (int index){
            this.setState(() {
              bottomIndex = index;
            });
        },
        children: [
          Container(margin:EdgeInsets.all(2.0), color: Colors.grey,),
          Container(margin:EdgeInsets.all(2.0), color: Colors.blue,),
          Container(margin:EdgeInsets.all(2.0), color: Colors.red,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room) , label: "스터디룸"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month) , label: "예약현황"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "매뉴")
        ],
        type: BottomNavigationBarType.fixed, // item이 3개이상일떄 디폴트로 적용되는 색상, 애니메이션 적용 안함
        selectedItemColor: Colors.black,
        currentIndex: bottomIndex,
        onTap: (int index) { // 아이콘이 선택되었을 때 동작

          // 위젯 상태 변경 및 화면을 다시 갱신(빌드)하는 순간
          this.setState(() {
            //setState()안의 bottomIndex 선언의 의미
            //'bottomIndex' 변수의 값이 변경됨 & 변경된 상태에 따라 빌드 함수 다시 호출
            bottomIndex = index;
          });
          // TODO : setSate 안에 안넣는 이유
          // PageView를 해당 탭에 맞는 페이지로 이동
          this.pageController..jumpToPage(index);
        },
      ),// 화면 전환 버튼 설정하는 속성
    );
  }
}
