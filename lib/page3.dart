import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    // タイムテーブル画像のピクセルサイズ
    double imageWidth = 1054;
    double imageHeight = 1618;

    // 時間軸の縦ピクセル範囲（画像座標）
    double timeStartPixel = 99;   // 9:30 の位置
    double timeEndPixel = 1585;   // 17:00 の位置
    double timePixelRange = timeEndPixel - timeStartPixel; // 1486px - 99px

    // 時間情報
    int startTimeMinutes = 9 * 60 + 30;  // 570分（9:30）
    int endTimeMinutes = 17 * 60;        // 1020分（17:00）
    int totalTimeMinutes = endTimeMinutes - startTimeMinutes; // 450分

    // 現在時刻
    var now = DateTime.now();
    int currentMinutes = now.hour * 60 + now.minute;
    int elapsedMinutes = currentMinutes - startTimeMinutes;

    // 赤線を表示するかどうか
    bool isInTimeRange = elapsedMinutes >= 0 && elapsedMinutes <= totalTimeMinutes;

    double appbarHeight = 50;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appbarHeight),
        child: AppBar(
          title: const Text('タイムテーブル'),
          centerTitle: true,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 表示可能領域のサイズ
          double displayWidth = constraints.maxWidth;
          double displayHeight = constraints.maxHeight;

          // 画像のアスペクト比
          double imageAspect = imageWidth / imageHeight;
          double displayAspect = displayWidth / displayHeight;

          // 実際に表示される画像サイズ（BoxFit.contain と同じ計算）
          double scaledWidth, scaledHeight;
          if (displayAspect > imageAspect) {
            // 横長 → 高さ基準
            scaledHeight = displayHeight;
            scaledWidth = imageAspect * scaledHeight;
          } else {
            // 縦長 → 幅基準
            scaledWidth = displayWidth;
            scaledHeight = scaledWidth / imageAspect;
          }

          // 上下左右余白
          double verticalPadding = (displayHeight - scaledHeight) / 2;
          double horizontalPadding = (displayWidth - scaledWidth) / 2;

          // 赤線の縦位置（スケーリング後座標）
          double posVertical = verticalPadding +
              (timeStartPixel / imageHeight * scaledHeight) +
              (elapsedMinutes / totalTimeMinutes) *
                  (timePixelRange / imageHeight * scaledHeight);

          // 赤線の横方向
          double leftPadding = horizontalPadding + 20 / imageWidth * scaledWidth;
          double barSize = scaledWidth - 40 / imageWidth * scaledWidth;

          return Stack(
            children: [
              // タイムテーブル画像
              Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    'assets/images/timetable.jpg',
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
              ),
              // 現在時刻が 9:30〜17:00 の範囲内なら赤線を表示
              if (isInTimeRange)
                Positioned(
                  top: posVertical - 2,
                  left: leftPadding,
                  child: Container(
                    width: barSize,
                    height: 4,
                    color: Colors.red.withValues(alpha:0.3),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
