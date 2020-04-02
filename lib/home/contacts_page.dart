import 'package:flutter/material.dart';

import '../model/contacts.dart' show Contact, ContactsPageData;
import '../constants.dart' show Constants, AppColors, AppStyles;

class _ContactItem extends StatelessWidget {
  _ContactItem(
      {@required this.avatar,
      @required this.title,
      this.groupTitle,
      this.onPressed});

  final String avatar;
  final String title;
  final String groupTitle;
  final VoidCallback onPressed;

  static const double MARGIN_VERTICAL = 8.0;
  static const double MARGIN_HORIZONTAL = 16.0;
  static const double GROUP_TITLE_HEIGHT = 20.0;
  bool get _isAvatarFromNet {
    return this.avatar.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    // 左边的图标
    Widget _avatarIcon = _isAvatarFromNet
        ? Image.network(avatar,
            width: Constants.ContactAvatarSize,
            height: Constants.ContactAvatarSize)
        : Image.asset(avatar,
            width: Constants.ContactAvatarSize,
            height: Constants.ContactAvatarSize);

    // 列表项主体部分
    Widget _button = Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: Constants.DividerWidth,
                  color: const Color(AppColors.DividerColor)))),
      child: Row(
        children: <Widget>[_avatarIcon, SizedBox(width: 10.0), Text(title)],
      ),
    );
    // 分组标签
    Widget _itemBody;
    if (this.groupTitle != null) {
      _itemBody = Column(
        children: <Widget>[
          Container(
            height: GROUP_TITLE_HEIGHT,
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            color: const Color(AppColors.ContactGroupTitleBg),
            alignment: Alignment.centerLeft,
            child: Text(
              this.groupTitle,
              style: AppStyles.GroupTitleItemTextStyle,
            ),
          ),
          _button
        ],
      );
    } else {
      _itemBody = _button;
    }
    return _itemBody;
  }
}

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ContactsPageData data = ContactsPageData.mock();
  final List<Contact> _contacts = [];
  final List<_ContactItem> _functionButton = [
    _ContactItem(
        avatar: 'assets/images/ic_new_friend.png',
        title: '新的朋友',
        onPressed: () {
          print('添加新朋友。');
        }),
    _ContactItem(
        avatar: 'assets/images/ic_group_chat.png',
        title: '群聊',
        onPressed: () {
          print('点击了群聊。');
        }),
    _ContactItem(
        avatar: 'assets/images/ic_tag.png',
        title: '标签',
        onPressed: () {
          print('标签。');
        }),
    _ContactItem(
        avatar: 'assets/images/ic_public_account.png',
        title: '公众号',
        onPressed: () {
          print('添加公众号。');
        }),
  ];

  @override
  void initState() {
    super.initState();

    _contacts
      ..addAll(data.contacts)
      ..addAll(data.contacts)
      ..addAll(data.contacts);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index < _functionButton.length) {
          return _functionButton[index];
        }

        int _contactIndex = index - _functionButton.length;
        Contact _contact = _contacts[_contactIndex];
        return _ContactItem(
          avatar: _contact.avatar,
          title: _contact.name,
          groupTitle: _contact.nameIndex,
        );
      },
      itemCount: _contacts.length + _functionButton.length,
    );
  }
}
