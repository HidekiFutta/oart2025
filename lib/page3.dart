import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    // タイムテーブル画像のピクセルサイズ
    double imageWidth = 1054;
    double imageHeight = 1618;

    // 時間軸の縦ピクセル範囲（画像座標）
    double timeStartPixel = 99;   // 9:30
    double timeEndPixel = 1585;   // 17:00
    double timePixelRange = timeEndPixel - timeStartPixel;

    // 時間情報
    int startTimeMinutes = 9 * 60 + 30; // 570
    int endTimeMinutes = 17 * 60;       // 1020
    int totalTimeMinutes = endTimeMinutes - startTimeMinutes; // 450

    // 現在時刻
    var now = DateTime.now();
    int currentMinutes = now.hour * 60 + now.minute;
    int elapsedMinutes = currentMinutes - startTimeMinutes;

    // 赤線を表示するかどうか
    bool isInTimeRange =
        elapsedMinutes >= 0 && elapsedMinutes <= totalTimeMinutes;

    double appbarHeight = 50;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appbarHeight),
        child: AppBar(
          title: const Text('タイムテーブル'),
          centerTitle: true,
        ),
      ),
      body: InteractiveViewer(
        minScale: 1.0,
        maxScale: 3.0,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double displayWidth = constraints.maxWidth;
              double displayHeight = constraints.maxHeight;

              double imageAspect = imageWidth / imageHeight;
              double displayAspect = displayWidth / displayHeight;

              double scaledWidth, scaledHeight;
              if (displayAspect > imageAspect) {
                scaledHeight = displayHeight;
                scaledWidth = imageAspect * scaledHeight;
              } else {
                scaledWidth = displayWidth;
                scaledHeight = scaledWidth / imageAspect;
              }

              double verticalPadding = (displayHeight - scaledHeight) / 2;
              double horizontalPadding = (displayWidth - scaledWidth) / 2;

              // 赤線の縦位置
              double posVertical = verticalPadding +
                  (timeStartPixel / imageHeight * scaledHeight) +
                  (elapsedMinutes / totalTimeMinutes) *
                      (timePixelRange / imageHeight * scaledHeight);

              // 赤線の横位置
              double leftPadding =
                  horizontalPadding + 21 / imageWidth * scaledWidth;
              double barSize = scaledWidth - 42 / imageWidth * scaledWidth;

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
                  // 赤線（範囲内のみ表示）
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
        ),
      ),
    );
  }
}
