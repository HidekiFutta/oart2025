import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'string_abstract.dart';

class Page4P1 extends StatefulWidget {
  final String speaker;
  final String title;
  final String theme;
  final String abstract;
  final String memoKey;

  const Page4P1(
      {super. key,
        required this.speaker,//1, this.speaker2,
        required this.title,
        required this.theme,
        required this.abstract,
        required this.memoKey,
      }
      );

  @override
  // ignore: library_private_types_in_public_api
  _Page4P1State createState() => _Page4P1State();
}

class _Page4P1State extends State<Page4P1> {
  final TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMemo();
  }

  // メモを読み込む関数
  Future<void> _loadMemo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _memoController.text = prefs.getString(widget.memoKey) ?? '';
    });
  }

  // メモを保存する関数
  Future<void> _saveMemo(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.memoKey, value);
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), //アプリバーのサイズ
          child: AppBar(
              title: const Text('抄録'),//Text('$appTitle 抄録'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    //ホーム画面に戻る
                    Navigator.popUntil(
                        context, (Route<dynamic> route) => route.isFirst);
                  },
                ),
              ])),
      backgroundColor: const Color(0xFFFFFFFF), //背景色

     body: SingleChildScrollView(
     child: Padding(
     padding: const EdgeInsets.all(16.0),
     child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
               widget.speaker,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.theme,
              style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.abstract,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              "メモ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _memoController,
              onChanged: (value) {
                _saveMemo(value); // 入力時に自動保存
              },
              maxLines: null, // 自由に改行可能
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "メモを入力してください",
              ),
            ),
          ],
        ),
       ),
      ),
    );
   }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }
}
