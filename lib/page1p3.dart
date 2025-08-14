import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart'; // AutoSizeTextをインポー
import 'string_info.dart';
import 'package:url_launcher/url_launcher.dart';

class Page1P3 extends StatelessWidget {
  final int? count;
  const Page1P3({super.key, this.count});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // 画面の横幅を取得
    double screenWidth = MediaQuery.of(context).size.width;

    // countに基づいてデータを取得
    final Map<String, String> data = pageTexts[count ?? 6] ?? {
      "title": "データが見つかりません",
      "content": "指定されたデータが存在しません。",
    };

    final String title = data["title"]!;
    final String content = data["content"]!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: AutoSizeText(
            title,
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
                // ホーム画面に戻る
                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter, // 画面上部に配置
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, // 画面幅の4%を左右の余白にする
            vertical: 16.0,
          ),
          child: SizedBox(
            width: screenWidth * 0.9, // 画面幅の90%を確保
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // ここで中央寄せ
              children: [
                const SizedBox(height: 20),
                SelectableText.rich(
                  TextSpan(
                    children: _parseContent(content),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _parseContent(String content) {
    final List<TextSpan> spans = [];
    final RegExp urlRegExp =
    RegExp(r"(https?:\/\/[^\s]+)"); // URLを検出する正規表現
    final matches = urlRegExp.allMatches(content);

    int start = 0;

    for (final match in matches) {
      // URLの前の通常のテキストを追加
      if (match.start > start) {
        spans.add(TextSpan(text: content.substring(start, match.start)));
      }

      // URLリンクを追加
      final String url = content.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
        ),
      );

      start = match.end;
    }

    // URLの後のテキストを追加
    if (start < content.length) {
      spans.add(TextSpan(text: content.substring(start)));
    }

    return spans;
  }
}
