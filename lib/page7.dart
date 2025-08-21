import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'string.dart';

String naiyo = vote;

Color col1 = Colors.black; //色を変数化
Color? col2 = Colors.blue[100];

final Uri _url = Uri.parse('https://script.google.com/macros/s/AKfycbwomK7fEZhws3Z5fhSrvfYxMfRuPnXKitQv9_CA0am9-01rdrTsgtujb--AKfS1tK3r1g/exec');

class Page7 extends StatelessWidget {
  const Page7({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; //画面サイズ取得
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    //double areaHei = screenHeight -(screenWidth/960*440);
    //960*440はcover1のサイズ
    double high = screenHeight/9-35;
    double wid = screenWidth - 50;
    //double high = 50;
    Size buttonSize = Size(wid, high);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), //アプリバーのサイズ
          child: AppBar(
            title: const Text('優秀演題投票'),
            centerTitle: true,backgroundColor: const Color(0xFFD19DEF),
          )),
     // backgroundColor: Colors.pink[50], //背景色
      body: Column(
        children: <Widget>[

       Row(
      //スクロールすると上に上がるのを防ぐため
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
          ),
        ],
      ),
          Expanded(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(15.0), //Appバーとの間隔
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 35,
                    alignment: Alignment.center,
                    child: const Text(
                      "投票はWebからのみ行います",
                      style: TextStyle(
                        fontFamily: 'NotoSansJP',
                        height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.01,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0), // 左右にパディングを追加
                    child: Text(
                      naiyo,
                      style: const TextStyle(
                        fontFamily: 'NotoSansJP',
                        height: 1.4, // heightプロパティを追加。 任意の値を設定して調整する
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.01,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
     // body: SingleChildScrollView(
       // padding: const EdgeInsets.only(top: 20), //Appバーとの間隔
       // child: Column(
       //   crossAxisAlignment: CrossAxisAlignment.center,
        //  children: <Widget>[
            //ボタン1
        Row(
          //スクロールすると上に上がるのを防ぐため　単なるスペーサー
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
            ),

          ],
        ),
            //ボタン2
          //  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                //↑これRowを入れないとcenter揃わない
                style: ElevatedButton.styleFrom(
                  foregroundColor: col1, backgroundColor: col2, minimumSize: buttonSize,
                  elevation: 16, //影
                  textStyle: const TextStyle(
                    fontSize: 22.0,
                    //fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _launchUrl,
                child: const Text('投票フォーム'),
              ),
          Row(
            //スクロールすると上に上がるのを防ぐため　単なるスペーサー
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 70.0),
              ),
            ],
          ),
        ],),
      );
    }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
