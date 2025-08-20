// abstract_page.dart
import 'package:flutter/material.dart';
import 'string_abstract.dart';
import 'page4p1.dart';
import 'utils.dart'; // generateMemoKey関数をインポート

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("プログラム・抄録"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionWidget(
                title: "教育講演",
                lectures: educationalLectures,
              ),
              SectionWidget(
                title: "特別講演",
                //theme: "",
                lectures: specialLectures,
              ),
              SectionWidget(
                title: "府民公開講座",
                //theme: "",
                lectures: publicLectures,
              ),
              SectionWidget(
                title: "ランチョンセミナー1",
                //theme: "",
                lectures: lunchLectures1,
              ),
              SectionWidget(
                title: "ランチョンセミナー2",
                //theme: "",
                lectures: lunchLectures2,
              ),
              SectionWidget(
                title: "学生セッション",
                //theme: "",
                lectures: generalResearchPresentations1,
              ),
              SectionWidget(
                title: "会員セッション",
                // theme: "",
                lectures: generalResearchPresentations2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// セクションウィジェットを作成
class SectionWidget extends StatelessWidget {
  //final String theme;
  final String title;
  final List<Map<String, dynamic>> lectures;

  const SectionWidget({super.key, required this.title,required this.lectures});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.black12,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...lectures.map((lecture) => LectureSection(lecture: lecture)),
        const SizedBox(height: 20),
      ],
    );
  }
}

class LectureSection extends StatelessWidget {
  final Map<String, dynamic> lecture;
  const LectureSection({super.key, required this.lecture});

  @override
  Widget build(BuildContext context) {
    // セッションタイプを取得
    String sessionType = lecture["sessionType"] ?? "座長"; // デフォルトは「座長」
    // 背景色を交互に設定
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 座長はセクションごとに1回だけ表示する
        if (lecture.containsKey("moderator"))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "$sessionType\n${_formatModeratorWithAlignment(lecture["moderator"])}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        Column(
          children: (lecture["presentations"] as List<Map<String, dynamic>>)
              .asMap()
              .entries
              .map((entry) {
            int index = entry.key; // 演題ごとのインデックス
            Map<String, dynamic> presentation = entry.value;

            // 背景色を交互に設定
            Color backgroundColor =
            index % 2 == 0 ? Colors.blue[50]! : Colors.green[50]!;

            return Container(
              color: backgroundColor, // 背景色を設定
              child: ListTile(
                title: Text("演者\n${_joinSpeakerName(presentation["speaker"])}"),
                subtitle: Text(" ${presentation["theme"]}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page4P1(
                        speaker: _joinSpeakerName(presentation["speaker"]),
                        title: presentation["theme"] ?? "",
                        theme: presentation["theme"] ?? "",
                        abstract: presentation["abstract"] ?? "",
                        memoKey: generateMemoKey(
                          _joinSpeakerName(presentation["speaker"]),
                          presentation["theme"] ?? "",
                        ), // 統一的にキーを生成
                      ),
                    ),
                  );
                },
              ),
            );
          })
              .toList(),
        ),
        const Divider(), // セクション間の区切り
      ],
    );
  }

  // 複数の演者名を結合
  String _joinSpeakerName(List<dynamic> speaker) {
    return speaker
        .map((speaker) => speaker["name"] ?? "")
        .join(", "); // カンマで結合
  }

  // 司会者リストを整形して改行と施設名揃えを行う関数
  String _formatModeratorWithAlignment(dynamic moderator) {
    if (moderator is List<String>) {
      // 施設名と名前を分離し、施設名の最大長を取得
      List<List<String>> splitModerator = moderator.map((moderator) {
        final parts = moderator.split(" "); // 施設名と名前を分離
        return [
          parts.sublist(0, parts.length - 1).join(" "), // 施設名
          parts.last // 名前
        ];
      }).toList();

      // 施設名の最大長を取得
      int maxInstitutionLength = splitModerator
          .map((mod) => mod[0].length)
          .reduce((a, b) => a > b ? a : b);

      // 整形された文字列を生成
      return splitModerator
          .map((mod) =>
      "${mod[0].padRight(maxInstitutionLength)} ${mod[1]}") // 施設名を右揃えに調整
          .join("\n"); // 改行で区切る
    } else if (moderator is String) {
      // 単一の文字列の場合、そのまま返す
      return moderator;
    } else {
      // 不明な形式の場合、空文字列を返す
      return "";
    }
  }
}
