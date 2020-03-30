import 'package:flutter/material.dart';

import '../constants.dart' show Constants, AppColors, AppStyles;

import '../i18n/strings.dart' show Strings;

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : item = BottomNavigationBarItem(
          icon: Icon(icon, color: Color(AppColors.TabIconNormal)),
          activeIcon: Icon(activeIcon,color: Color(AppColors.TabIconActive)),
          title: Text(title, style: TextStyle(
            fontSize: 14.0,
            color: Color(AppColors.TabIconNormal)
          )),
          backgroundColor: Colors.white,
        );
}

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title: Strings.TitleWechat,
        icon: IconData(
          0xe608,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe603,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
          title: Strings.TitleContact,
          icon: IconData(
            0xe601,
            fontFamily: Constants.IconFontFamily,
          ),
          activeIcon: IconData(
            0xe656,
            fontFamily: Constants.IconFontFamily,
          )),
      NavigationIconView(
          title: Strings.TitleDiscovery,
          icon: IconData(
            0xe600,
            fontFamily: Constants.IconFontFamily,
          ),
          activeIcon: IconData(
            0xe671,
            fontFamily: Constants.IconFontFamily,
          )),
      NavigationIconView(
          title: Strings.TitleMe,
          icon: IconData(
            0xe6c0,
            fontFamily: Constants.IconFontFamily,
          ),
          activeIcon: IconData(
            0xe626,
            fontFamily: Constants.IconFontFamily,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews.map<BottomNavigationBarItem>((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        print('点击的是第$index个Tab');
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('微信'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print('点击了搜索按钮'),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => print('显示下拉列表'),
            )
          ],
        ),
        body: Container(color: Colors.red),
        bottomNavigationBar: botNavBar,
        );
  }
}
