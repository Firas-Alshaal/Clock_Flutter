import 'dart:async';
import 'package:clock/constraint/colorMe.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPage createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage> with TickerProviderStateMixin {
  int start = 0;
  int _hour = 0;
  int _min = 0;
  int _sec = 0;
  bool started = true;
  bool stopped = true;
  bool checkTimer = true;
  int timeForTimer = 0;
  String timeToDisplay = "";

  void startFunc() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = (_hour * 60 * 60) + (_min * 60) + _sec;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          checkTimer = true;
          timeToDisplay = "";
          started = true;
          stopped = true;
          /*Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TimerPage()));*/
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        }
      });
    });
  }

  void stoppedFunc() {
    setState(() {
      started = true;
      stopped = true;
      checkTimer = false;
    });
  }

  Widget timer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Timer',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 30),
                        child: Text(
                          "HH",
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              color: CustomColors.primaryTextColor,
                              fontSize: 24),
                        ),
                      ),
                      NumberPicker(
                          value: _hour,
                          //initialValue: _hour,
                          minValue: 0,
                          maxValue: 23,
                          itemWidth: 60.0,
                          //listViewWidth: 60.0,
                          onChanged: (val) {
                            setState(() {
                              _hour = val;
                            });
                          })
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 30),
                        child: Text(
                          "MM",
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              color: CustomColors.primaryTextColor,
                              fontSize: 24),
                        ),
                      ),
                      NumberPicker(
                          //initialValue: _min,
                          value: _min,
                          minValue: 0,
                          maxValue: 23,
                          itemWidth: 60.0,
                          //listViewWidth: 60.0,
                          onChanged: (val) {
                            setState(() {
                              _min = val;
                            });
                          })
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 30),
                        child: Text(
                          "SS",
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              color: CustomColors.primaryTextColor,
                              fontSize: 24),
                        ),
                      ),
                      NumberPicker(
                          value: _sec,
                          //initialValue: _sec,
                          minValue: 0,
                          maxValue: 23,
                          itemWidth: 60.0,
                          //listViewWidth: 60.0,
                          onChanged: (val) {
                            setState(() {
                              _sec = val;
                            });
                          })
                    ],
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  timeToDisplay,
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w700,
                      color: CustomColors.primaryTextColor,
                      fontSize: 24),
                ),
              )),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: started ? startFunc : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 5,
                  ),
                  color: Colors.green,
                  child: Text(
                    "Start",
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w700,
                        color: CustomColors.primaryTextColor,
                        fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                RaisedButton(
                  onPressed: stopped ? null : stoppedFunc,
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 5,
                  ),
                  color: Colors.red,
                  child: Text(
                    "Stop",
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w700,
                        color: CustomColors.primaryTextColor,
                        fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: timer(),
      ),
    );
  }
}
