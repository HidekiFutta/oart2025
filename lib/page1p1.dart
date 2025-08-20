import 'package:flutter/material.dart';
import 'string.dart';

class Page1P1 extends StatelessWidget {
  const Page1P1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // アプリバーのサイズ
        child: AppBar(
          title: const Text('開催概要'),
          centerTitle: true,
          backgroundColor: const Color(0xFF47F5E1),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // ホーム画面に戻る
                Navigator.popUntil(
                    context, (Route<dynamic> route) => route.isFirst);
              },
            ),
          ],
        ),
      ),

      body: Center( // スマホでもタブレットでも中央寄せ
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: 0, vertical: 10.0), // 横の余白を動的に設定
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // すべて中央揃え
            children: <Widget>[
              const Text(
                '「技術革新と共に歩む」',
                style: TextStyle(
                  fontFamily: 'NotoSansJP',
                  height: 1.0, // heightプロパティを追加。 任意の値を設定して調整する
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.0075,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                '～診療放射線技師としての成長と挑戦～',
                style: TextStyle(
                  fontFamily: 'NotoSansJP',
                  height: 1.2, // heightプロパティを追加。 任意の値を設定して調整する
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.0075,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              const Text(
                '''日 時：令和7年11月16日（日）
              10:00～17:00
               9:30　会場受付開始''',
                style: TextStyle(
                  fontFamily: 'NotoSansJP',
                  height: 1.2, // heightプロパティを追加。 任意の値を設定して調整する
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.0075,
                ),
                textAlign: TextAlign.left, // 左揃えのまま
              ),
              const SizedBox(height: 10),

              const Text(
                '会 場：アートホテル大阪ベイタワー\n　　　 4階ボールルーム',
                style: TextStyle(
                  fontFamily: 'NotoSansJP',
                  height: 1.2, // heightプロパティを追加。 任意の値を設定して調整する
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.0075,
                ),
                textAlign: TextAlign.left, // 左揃えのまま
              ),
              const SizedBox(height: 10),

              // 枠付きの概要部分
              Container(
                width: screenWidth * 0.9, // 画面幅の90%を使う
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  gaiyo,
                  style: TextStyle(
                    fontFamily: 'NotoSansJP',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.0075,
                  ),
                  textAlign: TextAlign.left, // 左揃えのまま
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
