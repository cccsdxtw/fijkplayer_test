import 'dart:developer';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'fijkplayer_skin/custom_fijkPanel.dart';
// import 'custom_ui.dart';

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({required this.url});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoScreenState();

  @override
  void initState() {
    super.initState();
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    startPlay();
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player.setDataSource(widget.url, autoPlay: true).catchError((e) {
      print("setDataSource error: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FijkAppBar.defaultSetting(title: "Video"),
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                  TextButton(
                    child: Text(
                      "開始播放",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      log("click", name: "INFO");
                      player.start();
                    },
                    onLongPress: () {
                      log("long click", name: "INFO");
                    },
                  ),
                  TextButton(
                    child: Text(
                      "暫停",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      log("click", name: "INFO");
                      player.pause();
                    },
                    onLongPress: () {
                      log("long click", name: "INFO");
                    },
                  ),
                  TextButton(
                    child: Text(
                      "停止",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      log("click", name: "INFO");
                      player.seekTo(0);
                    },
                    onLongPress: () {
                      log("long click", name: "INFO");
                    },
                  ),
                      TextButton(
                        child: Text(
                          "往前１０秒",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          log("click", name: "INFO");
                          player.seekTo(player.value.duration.inMilliseconds.toInt()-10);
                        },
                        onLongPress: () {
                          log("long click", name: "INFO");
                        },
                      ),
                      TextButton(
                        child: Text(
                          "往後１０秒",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          log("click", name: "INFO");
                          player.seekTo(player.value.duration.inMilliseconds.toInt()+10);
                        },
                        onLongPress: () {
                          log("long click", name: "INFO");
                        },
                      ),
                ])),
            Expanded(
                flex: 1,
                child: FijkView(
                  player: player,
                  panelBuilder:  (FijkPlayer player, FijkData data, BuildContext context, Size viewSize, Rect texturePos) {
                    /// 使用自定义的布局
                    return CustomFijkWidgetBottom(
                      player: player,
                      buildContext: context,
                      viewSize: viewSize,
                      texturePos: texturePos,
                    );
                  },
                  fsFit: FijkFit.fill,
                  // panelBuilder: simplestUI,
                  // panelBuilder: (FijkPlayer player, BuildContext context,
                  //     Size viewSize, Rect texturePos) {
                  //   return CustomFijkPanel(
                  //       player: player,
                  //       buildContext: context,
                  //       viewSize: viewSize,
                  //       texturePos: texturePos);
                  // },
                )),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
