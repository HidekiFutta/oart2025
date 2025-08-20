import 'package:flutter/material.dart';
import 'string.dart';
import 'package:auto_size_text/auto_size_text.dart';

String title1 = "";
String title2 = "";
String photo = "";
String naiyo = "";

class Page1P2 extends StatelessWidget {
  final int? count;
  const Page1P2({super.key, this.count});

  @override
  Widget build(BuildContext context) {
    //double wid = MediaQuery.of(context).size.width - 50; //画面サイズ取得
    //double high = 50;
    if (count == 0) {
      title1 = "大会長挨拶";
      title2 = "学術大会開催にあたって\n大会長　藤田秀樹";
      photo = "assets/images/taikai.jpg";
      naiyo = kaicho;
    } else if(count == 1){
      title1 = "実行委員長挨拶";
      title2 = "学術大会開催にあたり\n実行委員長　奥中雄策";
      photo = "assets/images/jikkou.jpg";
      naiyo = okunaka;
    } else{
    title1 = "次年度開催のご挨拶";
    title2 = "令和8年度 近畿地域診療放射線技師会\n学術大会に向けて\n兵庫県診療放射線技師会\n会長 半蔀　英敏";
    photo = "assets/images/taikai.jpg";
    naiyo = kaicho;
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), //アプリバーのサイズ
          child:AppBar(
             title: AutoSizeText(
                    title1,
                    style: const TextStyle(fontSize: 20), // 基本フォントサイズ
                    maxLines: 1, // 最大1行まで表示
                    minFontSize: 12, // 最小フォントサイズ
                    overflow: TextOverflow.ellipsis, // 長すぎる場合は「...」で省略
                  ),
                  centerTitle: true,
                  backgroundColor: const Color(0xFFCCF192),
                  actions: <Widget>[
                    IconButton(
                       icon: const Icon(Icons.home),
              onPressed: () {
                //ホーム画面に戻る
                Navigator.popUntil(
                    context, (Route<dynamic> route) => route.isFirst);
              },
            ),
          ],
              ),
      ),
     // backgroundColor: const Color(0xFFF6FCF6), //背景色

      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
        Flexible( // 画像コンテナを調整
        flex: 1, // 優先度を設定（1: 小さめ）
        child: Container(
                //padding: const EdgeInsets.only(top: 5.0),
                margin: const EdgeInsets.only(top: 10),
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(photo), // 背景画像
                    //scale: 0.5,
                    //fit: BoxFit.contain,
                  ),
                ),
              ),
        ),
          Flexible( // テキストコンテナを調整
            flex: 3, // 優先度を
            child: Container(
                //color: Colors.red,
                height: 100,
                //padding: const EdgeInsets.only(bottom: 16),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8.0), // 横のパディング調整
                child: AutoSizeText(
                  title2,
                  style: const TextStyle(
                    fontFamily: 'NotoSansJP',
                    //color: Color(0xffffffff),
                    height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.01,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 4, // 最大3行まで表示
                  overflow: TextOverflow.ellipsis, // はみ出る部分は「...」で省略
                ),
                ),
              ),
            ],
          ),
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
              //padding: const EdgeInsets.all(15.0), //Appバーとの間隔
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration:  const BoxDecoration(
                    border: Border(
                    top: BorderSide(
                    color: Colors.black,
                    width: 2,
                      ),),
                      //color: Colors.white,
                    ),
                    //color: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      naiyo,
                      style: const TextStyle(
                        fontFamily: 'NotoSansJP',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.0075,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible, //ここ！！
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            //スクロールすると上に上がるのを防ぐため　単なるスペーサー
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
