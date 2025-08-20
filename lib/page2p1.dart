//import 'dart:async';
//import 'dart:io';
//import 'dart:math';
//import 'dart:typed_data';

import 'package:flutter/material.dart';
//import 'packages:lib/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'page2p2.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';


//戻るボタンを変更
//import 'package:marquee/marquee.dart';
//import 'package:gap/gap.dart';
//import 'package:location/location.dart';
double la = 0;
double lo = 0;

//https://pub.dev/packages/geolocator
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    await Geolocator.openAppSettings();
    await Geolocator.openLocationSettings();
    return Future.error('位置情報サービスが無効です.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return Future.error('位置情報取得が拒否されました');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error('位置情報取得が拒否されており、許可を要求できない');
  }
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

void pos() async {
  final position = await determinePosition();
  lo = position.longitude;
  la = position.latitude;
  //print(position);
}

class Page2P1 extends StatelessWidget {
  const Page2P1({super.key});
  @override
  Widget build(BuildContext context) {
    //double wid = MediaQuery.of(context).size.width;
    //double high = MediaQuery.of(context).size.height;
    //print(la);
    // print(lo);
    pos();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), //アプリバーのサイズ
          child: AppBar(
              title: const Text('地図'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home), //ホーム画面に戻る
                  onPressed: () {
                    Navigator.popUntil(
                        context, (Route<dynamic> route) => route.isFirst);
                  },
                ),
              ])),
      backgroundColor: const Color(0xFF50F547), //背景色

      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.my_location,
          color: Colors.blue,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => Page2P2(nowla: la, nowlo: lo)),
          );
        },
      ),

      body: FlutterMap(
        // マップ表示設定
        options: const MapOptions(
          initialCenter: LatLng(34.66976559704894, 135.46097436441),//(34.6696, 135.4610),
          initialZoom: 16.0,
        ),
        children: [
          //背景地図読み込み (Maptiler)
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/"
                "{z}/{x}/{y}?access_token=pk.eyJ1IjoiZnV0dGFrdW4iLCJhIjoiY2t6d2Y0ZHQwNnVvZTMwbzFhcTlnamhjdyJ9.VOTrWkqlhdVodw7LMrcijg",
          ),
          //urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          //subdomains: ['a', 'b', 'c']),
          // サークルマーカー設定
          CircleLayer(
            circles: [
              // サークルマーカー1設定
              CircleMarker(
                color: const Color.fromARGB(255, 243, 4, 4).withValues(alpha: 0.9),
                radius: 5,
                //borderColor:
                //    const Color.fromARGB(255, 23, 6, 253).withOpacity(0.9),
                // borderStrokeWidth: 2,
                point: const LatLng(34.6697, 135.4609),
              ),
              CircleMarker(
                color: const Color.fromARGB(255, 3, 19, 248).withValues(alpha: 0.9),
                radius: 4,
                borderColor:
                    const Color.fromARGB(255, 255, 0, 0).withValues(alpha: 0.9),
                borderStrokeWidth: 1,
                point: LatLng(la, lo),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
