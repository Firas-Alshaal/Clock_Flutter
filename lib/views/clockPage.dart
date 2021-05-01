import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'clockView.dart';
import 'package:clock/constraint/colorMe.dart';

class ClockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return _ClockPage();
  }
}

class _ClockPage extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build

    var now = DateTime.now();
    var formattedTime = DateFormat('HH.mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (timeZoneString.startsWith('-')) {
      offsetSign = '+';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              'Clock',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'avenir',
                  color: CustomColors.primaryTextColor,
                  fontSize: 24),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DigitalClockWidget(),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w300,
                    color: CustomColors.primaryTextColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.center,
              child: ClockView(
                size: MediaQuery.of(context).size.height / 4,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TimeZone',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w500,
                      color: CustomColors.primaryTextColor,
                      fontSize: 24),
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      color: CustomColors.primaryTextColor,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'UTC ' + offsetSign + timeZoneString,
                      style: TextStyle(
                          fontFamily: 'avenir',
                          color: CustomColors.primaryTextColor,
                          fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  Timer timer;

  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var perviousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute)
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('=====>digital clock updated');
    return Text(
      formattedTime,
      style: TextStyle(
          fontFamily: 'avenir',
          color: CustomColors.primaryTextColor,
          fontSize: 64),
    );
  }
}
