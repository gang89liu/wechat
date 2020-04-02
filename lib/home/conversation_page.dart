import 'package:flutter/material.dart';

import '../constants.dart' show AppColors, AppStyles, Constants;
import '../model/conversation.dart' show Conversation, Device, ConversationPageData;

class _ConversationItem extends StatelessWidget {
  static const UN_READ_MSG_CIRCLE_SIZE = 20.0;
  static const UN_READ_MSG_DOT_SIZE = 12.0;

  const _ConversationItem(this.conversation, {Key key})
      : assert(conversation != null),
        super(key: key);
  final Conversation conversation;
  @override
  Widget build(BuildContext context) {
    Widget avatar;
    avatar = conversation.isAvatarFromNet()
        ? Image.network(
            conversation.avatar,
            width: Constants.ConversationAvatarSize,
            height: Constants.ConversationAvatarSize,
          )
        : Image.asset(
            conversation.avatar,
            width: Constants.ConversationAvatarSize,
            height: Constants.ConversationAvatarSize,
          );

    // 未读消息角标
    Widget avatarContainer;
    if (conversation.unreadMsgCount > 0) {
      Widget unreadMsgCountText;
      if (conversation.displayDot) {
        unreadMsgCountText = Container(
          width: UN_READ_MSG_DOT_SIZE,
          height: UN_READ_MSG_DOT_SIZE,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UN_READ_MSG_DOT_SIZE / 2.0),
            color: Color(AppColors.NotifyDotBg),
          ),
        );
      } else {
        unreadMsgCountText = Container(
          width: UN_READ_MSG_CIRCLE_SIZE,
          height: UN_READ_MSG_CIRCLE_SIZE,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(UN_READ_MSG_CIRCLE_SIZE / 2.0),
              color: Color(AppColors.NotifyDotBg)),
          child: Text(
            conversation.unreadMsgCount.toString(),
            style: AppStyles.UnreadMsgCountDotStyle,
          ),
        );
      }

      avatarContainer = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(right: -6.0, top: -6.0, child: unreadMsgCountText),
        ],
      );
    } else {
      avatarContainer = avatar;
    }

    // 勿扰模式图标
    var _rightArea = <Widget>[
      Text(conversation.updateAt, style: AppStyles.DesStyle,),
      SizedBox(height: 10.0,),
      Icon(IconData(0xe755,
            fontFamily: Constants.IconFontFamily,),
            color: conversation.isMute ? Color(AppColors.ConversationMuteIcon) : Colors.transparent,
            size: Constants.ConversationMuteIconSize)
    ];

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(AppColors.ConversationItemBg),
        border: Border(
            bottom: BorderSide(
                color: Color(AppColors.DividerColor),
                width: Constants.DividerWidth)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatarContainer,
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  conversation.title,
                  style: AppStyles.TitleStyle,
                ),
                Text(
                  conversation.des,
                  style: AppStyles.DesStyle,
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            children: _rightArea
          )
        ],
      ),
    );
  }
}

class _DeviceInfoItem extends StatelessWidget {
  const _DeviceInfoItem({this.device: Device.WIN}) :
    assert(device != null);

  final Device device;

int get iconName {
 return device == Device.WIN ? 0xe6b3 : 0xe61c;
}

String get deviceName {
    return device == Device.WIN ? 'Windows' : 'Mac';
}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.0, top: 10.0, right: 24.0, bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: Constants.DividerWidth, color: Color(AppColors.DividerColor))
        ),
        color: Color(AppColors.DeviceInfoItemBg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(IconData(iconName, fontFamily: Constants.IconFontFamily
          ),
          size: 24.0,)
          ,
          SizedBox(width: 16.0,),
          Text('$deviceName 微信已登录，手机通知已关闭。',style: AppStyles.DeviceInfoItemTextStyle,)
        ],
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  const ConversationPage();
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  final ConversationPageData  data = ConversationPageData.mock();
  @override
  Widget build(BuildContext context) {
    var mockConversations = data.conversations;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if(data.device != null) {
           if(index == 0) {
          return _DeviceInfoItem(device: data.device,);
        }
        return _ConversationItem(mockConversations[index-1 ] );
        } else{
          return _ConversationItem(mockConversations[index]);
        }
      },
      itemCount: data.device != null ? mockConversations.length + 1 : mockConversations.length,
    );
  }
}
