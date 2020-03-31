import 'package:flutter/material.dart';

import '../constants.dart' show Constants, AppColors, AppStyles;

import '../i18n/strings.dart' show Strings;

enum ActionItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP }

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
  _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(IconData(
                      iconName,
                      fontFamily: Constants.IconFontFamily,
                    ),
                    size: 22.0,
                      color: Color(AppColors.ActionIconColor)
                    ),
        Container(width: 12.0,),
        Text(title,
          style: TextStyle(color: const Color(AppColors.ActionIconColor)),)
      ],
    );
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
          elevation: 0.0,
          brightness: Brightness.light,
          backgroundColor: const Color(AppColors.BackgroundColor),
          actions: [
            IconButton(
              icon: Icon(IconData(
                0xe65e,
                fontFamily: Constants.IconFontFamily
              ),
                  color: Color(AppColors.ActionIconColor),
              size: 22.0),
              onPressed: () => print('点击了搜索按钮'),
            ),
            Container(width: 16.0,),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<ActionItems>>[
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe69e,'发起群聊'),
                    value: ActionItems.GROUP_CHAT
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe638,'添加朋友'),
                    value: ActionItems.ADD_FRIEND
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe61b,'扫一扫'),
                    value: ActionItems.QR_SCAN
                  ),PopupMenuItem(
                    child: _buildPopupMenuItem(0xe62a,'收付款'),
                    value: ActionItems.PAYMENT
                  ),PopupMenuItem(
                    child: _buildPopupMenuItem(0xe63d,'帮助与反馈'),
                    value: ActionItems.HELP
                  )
                ];
              },
              onSelected: (ActionItems selected) => print('点击的是$selected'),
              icon: Icon(IconData(
                  0xe616,
                  fontFamily: Constants.IconFontFamily),
                  color: Color(AppColors.ActionIconColor),
                  size: 22.0),
                 
            ),
            Container(width: 16.0,)

            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: IconButton(
            //     icon: Icon(IconData(
            //       0xe616,
            //       fontFamily: Constants.IconFontFamily),
            //       size: 22.0),
            //       onPressed: () => print('显示下拉列表'),
            //     )
            //   ),
          ],
        ),
        body: Container(color: Colors.red),
        bottomNavigationBar: botNavBar,
        );
  }
}
