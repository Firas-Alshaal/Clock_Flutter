import 'package:clock/data.dart';
import 'package:clock/views/alarmPage.dart';
import 'package:clock/views/clockPage.dart';
import 'package:clock/views/stopWatchPage.dart';
import 'package:clock/views/timerPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clock/models/menu_info.dart';
import 'package:clock/constraint/colorMe.dart';
import '../enums.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build

    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItem
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList()),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else if (value.menuType == MenuType.timer)
                  return TimerPage();
                else
                  return StopWatchPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
          color: currentMenuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 1.5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                  fontFamily: 'avenir',
                  color: CustomColors.primaryTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
