import 'package:flutter/material.dart';
import 'page2p1.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // アプリバーのサイズ
        child: AppBar(
          title: const Text('会場・周辺地図'),
          centerTitle: true,
        ),
      ),
      body: InteractiveViewer(
        boundaryMargin:const EdgeInsets.all(20),
        constrained: false,
        minScale: 1.0,
        maxScale: 2.0, // 最大スケールを増加
        child: Image.asset(
          'assets/images/map.jpg',
          width: MediaQuery.of(context).size.width, // 画面幅にフィット
          fit: BoxFit.fitWidth, // 横幅いっぱいに調整
        ),
        ),
    bottomNavigationBar: bottomButton(context),
    );
  }

  Widget bottomButton(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: TextButton.icon(
        icon: Image.asset('assets/images/iMap.png'),
        label: const Text(
          "地図アプリを開く",
          style: TextStyle(
            height: 2.0,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          alignment: Alignment.center,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Page2P1(),
            ),
          );
        },
      ),
    );
  }
}
