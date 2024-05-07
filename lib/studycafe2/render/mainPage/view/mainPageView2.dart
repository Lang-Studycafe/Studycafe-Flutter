import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPageView2 extends StatefulWidget {
  const MainPageView2({super.key});

  @override
  State<MainPageView2> createState() => _MainPageView2State();
}

class _MainPageView2State extends State<MainPageView2> {

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      //UI package 쓸때 조심해야할 점 오류나면 크키 제한 있는지 확인
      child: Column(
        children:[
          // IconButton(
          //     onPressed: (){
          //       setState(() {
          //         this.focusedDay = DateTime.now();
          //         this.selectedDay = DateTime.now();
          //       });
          //     },
          //   icon: Icon(Icons.refresh),
          // ),
          Container(
          child: TableCalendar(
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false
            ),
            calendarStyle: CalendarStyle(
              selectedTextStyle: TextStyle(color: Colors.black54),
              selectedDecoration: BoxDecoration(color: Colors.amberAccent)
            ) ,
            selectedDayPredicate: (DateTime date) => isSameDay(this.selectedDay,date),
            onDaySelected: (DateTime date,DateTime date2){
              print(date);
              print(date2);
              setState(() => this.focusedDay = date);
              setState(() => this.selectedDay = date);
            },
            focusedDay: this.focusedDay, //위에도 들어가야되니깐 상태로 잡는다
            firstDay: DateTime(2024,4,1),
            lastDay: DateTime(2025,1,1),
          ),
        ),
      ],
    ),
    );
  }
}

/// eventloader -> 예약 시간 표기
/// http
/// 전역변수의 문제? 크키 문제도 있지만 모든 역할을 다 가지고있어야하는 문제
/// 상태값 전달은 머터리얼 앱(최상위앱) 의 상태 참조
/// provider - 상위 위젯(레이어)에 상태값 넣고 하위에 보여져야할 화면위젯을 넣는다
