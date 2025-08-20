import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    // タイムテーブル画像のピクセルサイズ
    double imageWidth = 1054; // 横幅
    double imageHeight = 1618; // 縦幅

    // 時間軸の縦ピクセル範囲
    double timeStartPixel = 99; // 9:30 の縦位置
    double timeEndPixel = 1585; // 17:00 の縦位置
    double timePixelRange = timeEndPixel - timeStartPixel; // 有効時間軸のピクセル範囲

    // 時間情報
    int startTimeMinutes = 9 * 60 + 30; // 9:30 → 分単位（570分）
    int endTimeMinutes = 17 * 60; // 17:00 → 分単位（1020分）
    int totalTimeMinutes = endTimeMinutes - startTimeMinutes; // 総時間（480分）

    // 現在時刻
    var now = DateTime.now();
    int currentMinutes = now.hour * 60 + now.minute; // 現在の分単位の時間
    int elapsedMinutes = currentMinutes - startTimeMinutes; // 開始時間からの経過時間

    // 画面サイズ取得
    Size screenSize = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double appbarHeight = 50; // アプリバーの高さ

    // 実際に表示可能な高さ
    double displayHeight = screenSize.height - statusBarHeight - bottomPadding - appbarHeight;
    double screenWidth = screenSize.width;

    // スケール計算（画面幅を基準）
    double scale = screenWidth / imageWidth;
    double scaledImageHeight = imageHeight * scale; // 画像の高さをスケール
    double verticalPadding = (displayHeight - scaledImageHeight) / 2; // 上下余白

    // 赤線の位置計算（スケールを考慮）
    double posVertical = verticalPadding +
        ((elapsedMinutes / totalTimeMinutes) * timePixelRange * scale) +
        (timeStartPixel * scale);

    // 赤線の横方向の位置
    double leftPadding = 20 * scale; // 左側余白のピクセル数（スケール考慮）
    double posLeft = leftPadding;
    double barSize = (imageWidth - 40) * scale; // 外枠を考慮した幅

    // 9時から17時の間のみ赤線を表示
    bool isInTimeRange = elapsedMinutes >= 0 && elapsedMinutes <= totalTimeMinutes;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appbarHeight),
        child: AppBar(
          title: const Text('タイムテーブル'),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 1.0,
          maxScale: 3.0,
          child: Stack(
            children: [
              // タイムテーブル画像
              Center(
                child: SizedBox(
                  width: screenWidth,
                  height: displayHeight, // ここを displayHeight に変更
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset('assets/images/timetable.jpg'),
                  ),
                ),
              ),
              // 現在の時間を示す赤い線
              if (isInTimeRange) // 9:30〜17:00 の間のみ赤線を表示
               Positioned(
                 top: posVertical - 2, // タブレットでのズレ補正
                 left: posLeft,
                 child: Container(
                   width: barSize,
                   height: 4,
                   color: Colors.red.withValues(alpha:0.3),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
