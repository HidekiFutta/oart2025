//import 'dart:async';
//import 'dart:io';
//import 'dart:math';
//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'page2p1.dart';

//import 'package:marquee/marquee.dart';
//import 'package:gap/gap.dart';
//import 'package:location/location.dart';

class Page2P2 extends StatelessWidget {
  final double nowla;
  final double nowlo;
  const Page2P2({super.key, required this.nowla, required this.nowlo});

  @override
  Widget build(BuildContext context) {
    //double wid = MediaQuery.of(context).size.width;
    //double heigh = MediaQuery.of(context).size.height;
    //getpos();
    //print(nowla);
    //print(nowlo);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0), //アプリバーのサイズ
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
          Icons.location_on,
          color: Colors.yellow,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Page2P1()),
          );
        },
      ),

      body: FlutterMap(
        // マップ表示設定
        options: MapOptions(
          initialCenter: LatLng(nowla, nowlo),
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
                point: const LatLng(34.6696, 135.4610),
              ),
              CircleMarker(
                color: const Color.fromARGB(255, 3, 19, 248).withValues(alpha: 0.9),
                radius: 4,
                borderColor:
                    const Color.fromARGB(255, 255, 0, 0).withValues(alpha: 0.9),
                borderStrokeWidth: 1,
                point: LatLng(nowla, nowlo),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
