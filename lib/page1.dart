import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
//import 'page3.dart';
import 'page1p1.dart';
import 'page1p2.dart';
import 'page1p3.dart';

Color col1 = Colors.black; //////色を変数化
Color? col2 = Colors.pink[50];

class Page1 extends StatelessWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; //画面サイズ取得
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    //double areaHei = screenHeight -(screenWidth/960*440);
    //960*440はcover1のサイズ
    double high = screenHeight/9-40;
    double wid = screenWidth - 50;
    //double high = 50;
    Size buttonSize = Size(wid, high);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), //アプリバーのサイズ
          child: AppBar(
            title: const Text('Information'),
            centerTitle: true,backgroundColor: const Color(0xFF4792F5),
          )),
      //backgroundColor: Colors.pink[50], //背景色

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20), //Appバーとの間隔
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //ボタン1
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 18, //影
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //指定した画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ボタン1で遷移するページ
                      builder: (context) => const Page1P1()),
                );
              },
              child: const Text('開催概要'),
            ),
            const SizedBox(
              //単に間をあける　padding等効かない
              height: 20,
            ),
            //ボタン2
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                //↑これRowを入れないとcenter揃わない
                style: ElevatedButton.styleFrom(
                  foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                  elevation: 16, //影
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    //fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  //指定した画面に遷移
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        // ボタン2で遷移するページ
                        builder: (context) => const Page1P2(
                              count: 0,
                            )),
                  );
                },
                child: const Text('大会長挨拶'),
              ),
            ]),
            const SizedBox(
              //単に間をあける　padding等効かない
              height: 20,
            ),
            //ボタン3
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 16, //影
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //指定した画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ボタン3で遷移するページ
                      builder: (context) => const Page1P2(
                            count: 1,
                          )),
                );
              },
              child: const Text('実行委員長挨拶'),
            ),
            const SizedBox(
              //単に間をあける　padding等効かない
              height: 20,
            ),
            //ボタン4
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 16, //影
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //指定した画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ボタン4で遷移するページ
                      builder: (context) => const Page1P3(
                        count: 3,
                      )),
                );
              },
              child: const Text('参加者の皆様へ'),
            ),
            const SizedBox(
              //単に間をあける　padding等効かない
              height: 20,
            ),
            //ボタン5
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 16, //影
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //指定した画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ボタン5で遷移するページ
                      builder: (context) => const Page1P3(
                        count: 4,
                      )),
                );
              },
              child: const Text('演者・座長の皆様へ'),
            ),
            const SizedBox(
              //単に間をあける　padding等効かない
              height: 20,
            ),
            //ボタン6
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 16, //影
                //textStyle: const TextStyle(
                 // fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                //),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //指定した画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ボタン6で遷移するページ
                      builder: (context) => const Page1P3(
                        count: 5,)),
                );
              },
              child: const AutoSizeText(
                'ランチョンセミナーのご案内',
                style: TextStyle(
                  fontSize: 18, //テキストサイズ
                ),
                maxLines: 1, // 最大1行まで
                minFontSize: 12, // 最小フォントサイズを指定
                overflow: TextOverflow.ellipsis, // テキストが長い場合は省略
                textAlign: TextAlign.center, // 中央揃え
              ),

            ),
            const SizedBox(
              //単に間をあける　padding等効かない
              height: 20,
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 16, //影
                //textStyle: const TextStyle(
                // fontSize: 18.0,
                //fontWeight: FontWeight.bold,
                //),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
      onPressed: () {
        //指定した画面に遷移
        Navigator.push(
          context,
          MaterialPageRoute(
            // ボタン6で遷移するページ
              builder: (context) => const Page1P3(
                count: 6,)),
        );
      },
      child: const AutoSizeText(
        'ワクチン接種実技講習会のご案内',
        style: TextStyle(
          fontSize: 18, //テキストサイズ
        ),
        maxLines: 1, // 最大1行まで
        minFontSize: 12, // 最小フォントサイズを指定
        overflow: TextOverflow.ellipsis, // テキストが長い場合は省略
        textAlign: TextAlign.center, // 中央揃え
      ),

    ),
    const SizedBox(
    //単に間をあける　padding等効かない
    height: 20,
    ),
            //ボタン7
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 16, //影
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //指定した画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ボタン7で遷移するページ
                      builder: (context) => const Page1P3(
                        count: 7,)),
                );
              },
              child: const Text('大会役員'),
            ),
            const SizedBox(
              //単に間をあける　padding等効かない
              height: 20,
            ),
            //ボタン8
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: col1, backgroundColor: col2, fixedSize: buttonSize,
                elevation: 16, //影
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //指定した画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ボタン8で遷移するページ
                      builder: (context) => const Page1P3(
                        count: 8,)),
                );
              },
              child: const Text('予稿集掲載会社'),
            ),
          ],
        ),
      ),
    );
  }
}
