import 'dart:async';

import 'package:clock/constraint/colorMe.dart';
import 'package:flutter/material.dart';

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPage createState() => _StopWatchPage();
}

class _StopWatchPage extends State<StopWatchPage> {
  bool pressStop = true;
  bool pressStart = true;
  bool pressReset = true;
  String stopTimer = "00:00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(
    milliseconds: 1,
  );

  void startTime() {
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTime();
    }
    setState(() {
      stopTimer = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMilliseconds % 60).toString().padLeft(2, "0");
    });
  }

  void stopStopWatch() {
    setState(() {
      pressStop = true;
      pressReset = false;
      pressStart = true;
    });
    swatch.stop();
  }

  void startStopWatch() {
    setState(() {
      pressStop = false;
      pressStart = false;
    });
    swatch.start();
    startTime();
  }

  void resetStopWatch() {
    setState(() {
      pressStart = true;
      pressReset = true;
    });
    swatch.reset();
    stopTimer = "00:00:00:00";
  }

  Widget stopWatch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Stop Watch',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stopTimer,
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    color: CustomColors.primaryTextColor,
                    fontSize: 35
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: pressStop ? null : stopStopWatch,
                        color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Text(
                          "Stop",
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              color: CustomColors.primaryTextColor,
                              fontSize: 20
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: pressReset ? null : resetStopWatch,
                        color: Colors.teal,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              color: CustomColors.primaryTextColor,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: pressStart ? startStopWatch : null,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
                    child: Text(
                      "Start",
                      style: TextStyle(
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.w700,
                          color: CustomColors.primaryTextColor,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: stopWatch(),
      ),
    );
  }
}
