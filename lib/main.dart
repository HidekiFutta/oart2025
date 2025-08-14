import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'page5.dart';
import 'page7.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final now = DateTime.now().toLocal();

final kaisaiDay = DateTime(2025, 11, 16); //開始日
final todayDay = DateTime(now.year, now.month, now.day);
final diffDay = kaisaiDay.difference(todayDay).inDays;

final kaisaiTime = DateTime(2025, 11, 16, 10, 00); //開始日時
final kaisaiMin = kaisaiTime.hour * 60 + kaisaiTime.minute;
final todayMin = now.hour * 60 + now.minute;
final diffMin = kaisaiMin - todayMin;
const underArea = 70;

String hyouJi() {
  if (diffDay > 0) {
    return '開催まであと$diffDay日';
  } else if (diffDay < -1) {
    return 'ご参加いただきありがとうございました';
  } else if (diffMin > 60) {
    return '本日開催です';
  } else if (diffMin > 0) {
    return 'まもなく始まります';
  } else if (diffMin > -600) {
    //終了時間を計算して入れる
    return '';
  } else {
    return 'ご参加いただきありがとうございました';
  }
}
final String hyouji = hyouJi();
//final Duration difference = DateTime.now().toLocal().difference(kaisaiDay);

//if (0 >diffMin > -600) {
 // underArea = 35;
//}

void main() {
  // エッジツーエッジ表示を有効にする
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // ステータスバーの背景を透明にする
    systemNavigationBarColor: Colors.transparent, // ナビゲーションバーの背景を透明にする
    systemNavigationBarContrastEnforced: false, // コントラストを無効化（必要に応じて設定）
    statusBarIconBrightness: Brightness.dark, // ステータスバーアイコンの色（Dark:黒）
    systemNavigationBarIconBrightness: Brightness.dark, // ナビゲーションバーアイコンの色
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "35th Oart Conf.",
      theme: ThemeData(
        fontFamily: 'NotoSansJP', // フォントファミリーを指定
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    //_checkForVersionUpdate(); // アプリ起動時にバージョンチェックを実行
    VersionCheck.checkVersion(context);//チェックをアプリ起動時に呼び出す
    //initState メソッドで実行する:
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; //画面サイズ取得
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    double areaHei = screenHeight -(screenWidth/945*605);
    //945*605はcover0のサイズ
    double imgHei = areaHei/3-underArea;
    double imgWid = screenWidth/2-70;
    double high = 30;  // 説明文の高さ
    var logger = Logger();
    logger.d(screenSize);
    logger.d(areaHei);
    //logger.d(areaHei);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // 影を削除
        title: Text(widget.title),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFC3F9FF), //背景色
      extendBodyBehindAppBar: true,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/cover0.jpg'),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //ボタン1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(    //ご案内
                        height: imgHei,
                        width: imgWid,
                        margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: Image.asset('assets/images/cover1.png'),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン2で遷移するページ
                                  builder: (context) => const Page1()),
                            );
                          },
                        ),
                      ),
                      Container(    //会場案内
                        height: imgHei,
                        width: imgWid,
                        margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: Image.asset('assets/images/cover2.png'),

                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン2で遷移するページ
                                  builder: (context) => const Page2()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: high,
                        width: imgWid,
                        alignment: Alignment.topCenter,
                        //margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: const AutoSizeText(
                              //ボタン1の下
                              'ご案内',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xFF000000),
                                height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.01,
                              ),
                              //textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン2で遷移するページ
                                  builder: (context) => const Page1()),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: high,
                        width: imgWid,
                        alignment: Alignment.topCenter,
                        //margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: const AutoSizeText(
                              //ボタン2の下
                              '会場案内',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xFF000000),
                                height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.01,
                              ),
                              //textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン2で遷移するページ
                                  builder: (context) => const Page2()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    //単に間をあける　padding等効かない
                    height: 0,
                  ),
                  //ボタン3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(   //タイムテーブル
                        height: imgHei,
                        width: imgWid,
                        margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 00),
                            child: Image.asset('assets/images/cover3.png'),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン3で遷移するページ
                                  builder: (context) => const Page3()),
                            );
                          },
                        ),
                      ),
                      Container(    //プログラム・抄録
                        height: imgHei,
                        width: imgWid,
                        margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 00),
                            child: Image.asset('assets/images/cover4.png'),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン4で遷移するページ
                                  builder: (context) => const Page4()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: high,
                        width: imgWid,
                        alignment: Alignment.topCenter,
                        //margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: const AutoSizeText(
                              //ボタン3の下
                              'タイムテーブル',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xFF000000),
                                height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.01,
                              ),
                              //textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン2で遷移するページ
                                  builder: (context) => const Page3()),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: high,
                        width: imgWid,
                        alignment: Alignment.topCenter,
                        //margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: const AutoSizeText(
                              //ボタン4の下
                              'プログラム・抄録',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xFF000000),
                                height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.01,
                              ),
                              maxLines: 1, // 最大1行まで
                              minFontSize: 10, // 最小フォントサイズを指定
                              overflow: TextOverflow.ellipsis, // テキストが長い場合は省略
                              textAlign: TextAlign.center, // 中央揃え
                              //textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン4で遷移するページ
                                  builder: (context) => const Page4()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    //単に間をあける　padding等効かない
                    height: 0,
                  ),
                  //ボタン4
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: imgHei,
                        width: imgWid,
                        margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: Image.asset('assets/images/cover5.png'),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン5で遷移するページ
                                  builder: (context) => const Page5()),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: imgHei,
                        width: imgWid,
                        margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: Image.asset('assets/images/cover6.png'),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン6で遷移するページ
                                  builder: (context) => const Page7()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: high,
                        width: imgWid,
                        alignment: Alignment.topCenter,
                        //margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: const AutoSizeText(
                              //ボタン5の下
                              '演者・座長',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xFF000000),
                                height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.01,
                              ),
                              //textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン4で遷移するページ
                                  builder: (context) => const Page5()),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: high,
                        width: imgWid,
                        alignment: Alignment.topCenter,
                        //margin: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: const AutoSizeText(
                              //ボタン6の下
                              '優秀演題投票',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xFF000000),
                                height: 1.6, // heightプロパティを追加。 任意の値を設定して調整する
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.01,
                              ),
                              //textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            //指定した画面に遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ボタン4で遷移するページ
                                  builder: (context) => const Page7()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    //単に間をあける　padding等効かない
                    height: 20,
                  ),
                  //ボタン6
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        //color: Colors.red,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9, // 画面幅に応じて調整
                        //padding: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          hyouji, // ← テキストを自動調整
                          style: const TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Color(0xFFE21515),
                            height: 1.6,
                            fontSize: 20, // 最大フォントサイズ
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.01,
                          ),
                          maxLines: 1, // 最大1行まで
                          minFontSize: 10, // 最小フォントサイズ
                          overflow: TextOverflow.ellipsis, // 省略記号を表示
                          textAlign: TextAlign.center, // テキスト中央揃え
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    //単に間をあける　padding等効かない
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
        ),),
    );
  }
}

class VersionCheck {
  static const String versionCheckUrl = "https://oart2025-5a199.web.app/latest-version.json";

  static Future<void> checkVersion(BuildContext context) async {
    try {
      // 現在のアプリバージョンを取得
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      // リモートサーバーから最新バージョンを取得
      final response = await http.get(Uri.parse(versionCheckUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latestVersion = data['latest_version'];

        // バージョンを比較
        if (_isVersionOutdated(currentVersion, latestVersion)) {
          _showUpdateDialog(context, latestVersion);
        }
      }
    } catch (e) {
      print("バージョンチェック中にエラーが発生しました: $e");
    }
  }

  static bool _isVersionOutdated(String currentVersion, String latestVersion) {
    final current = currentVersion.split('.').map(int.parse).toList();
    final latest = latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < latest.length; i++) {
      if (current.length <= i || current[i] < latest[i]) {
        return true;
      } else if (current[i] > latest[i]) {
        return false;
      }
    }
    return false;
  }

  static void _showUpdateDialog(BuildContext context, String latestVersion) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('アップデートのお知らせ'),
          content: Text('新しいバージョン ($latestVersion) が利用可能です。oart2025を検索して更新してください。'),
        );
      },
    );
  }
}
