import 'package:flutter/material.dart';
import 'package:wechat/home/contacts_page.dart';

import '../constants.dart' show Constants, AppColors, AppStyles;

import '../i18n/strings.dart' show Strings;

import './conversation_page.dart';

enum ActionItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP }

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : item = BottomNavigationBarItem(
          icon: Icon(icon),
          activeIcon: Icon(activeIcon),
          title: Text(title),
          backgroundColor: Colors.white,
        );
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationIconView> _navigationViews;
  PageController _pageController;
  List<Widget> _pages;
  int _currentIndex = 0;

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

    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      ConversationPage(),
      ContactPage(),
      Container(color: Colors.blue),
      Container(color: Colors.brown),
    ];
  }

  _buildPopupMenuItem(int iconName, String title, { bool isLast = false }) {
    return Row(
      children: <Widget>[
        Icon(
            IconData(
              iconName,
              fontFamily: Constants.IconFontFamily,
            ),
            size: 22.0,
            color: const Color(AppColors.AppBarPopupMenuColor)),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: isLast ? null : BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color(AppColors.DividerColor),
                    width: Constants.DividerWidth)),
          ),
          child: Text(
            title,
            style:
                TextStyle(color: const Color(AppColors.AppBarPopupMenuColor)),
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      items: _navigationViews
          .map<BottomNavigationBarItem>((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });

        _pageController.animateToPage(_currentIndex,
            duration: Duration(microseconds: 200), curve: Curves.easeInOut);
        print('点击的是第$index个Tab');
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('微信',
            style: TextStyle(
              color: Color(AppColors.ActionIconColor),
            )),
        elevation: 0.0, // 阴影
        brightness: Brightness.light,
        backgroundColor: const Color(AppColors.BackgroundColor),
        actions: [
          IconButton(
            icon: Icon(IconData(0xe65e, fontFamily: Constants.IconFontFamily),
                color: Color(AppColors.ActionIconColor), size: 22.0),
            onPressed: () => print('点击了搜索按钮'),
          ),
          SizedBox(
            width: 16.0,
          ),
          Theme(
            data: ThemeData(cardColor: Color(AppColors.ActionMenuBgColor)),
            child: PopupMenuButton(

              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<ActionItems>>[
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe69e, '发起群聊'),
                    value: ActionItems.GROUP_CHAT,
                  ),
                  PopupMenuItem(
                      child: _buildPopupMenuItem(0xe638, '添加朋友'),
                      value: ActionItems.ADD_FRIEND),
                  PopupMenuItem(
                      child: _buildPopupMenuItem(0xe61b, '扫一扫'),
                      value: ActionItems.QR_SCAN),
                  PopupMenuItem(
                      child: _buildPopupMenuItem(0xe62a, '收付款'),
                      value: ActionItems.PAYMENT),
                  PopupMenuItem(
                      child: _buildPopupMenuItem(0xe63d, '帮助与反馈', isLast: true),
                      value: ActionItems.HELP)
                ];
              },
              onSelected: (ActionItems selected) => print('点击的是$selected'),
              icon: Icon(IconData(0xe616, fontFamily: Constants.IconFontFamily),
                  color: Color(AppColors.ActionIconColor), size: 22.0),
            ),
          ),
          SizedBox(
            width: 16.0,
          )
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
          print('当前显示的是第$index页');
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
