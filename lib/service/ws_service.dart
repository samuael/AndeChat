import 'dart:convert';
import 'dart:io';

import 'package:ChatUI/libs.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  static WebSocketChannel _channel;
  static WebSocketService _service;
  static const String WSHOST = 'ws://10.0.3.2:8080/chat/';

  //  List Of Blocs will be listed here .
  static UserState userState;
  static FriendsState firendsState;
  static InteractiveUser activeUser;
  static OnlineFriends onlineFriendsStates;
  static MessagingDataProvider messagingDataProvider;

  // WebSocketService();
  WebSocketChannel get channel {
    return _channel;
  }

  static Map<String, String> headers;
  static SessionHandler _sessionHandler;
  static Future<WebSocketService> getInstance() async {
    // instanciating web socket used blocs will be listed here.
    if (_sessionHandler == null) {
      _sessionHandler = await HttpCallHandler.sessionHandler;
    }
    if (userState == null) {
      userState = UserState.instance;
    }
    if (firendsState == null) {
      firendsState = FriendsState.getInstance();
    }
    if (activeUser == null) {
      activeUser = InteractiveUser.instance;
    }
    if (onlineFriendsStates == null) {
      onlineFriendsStates = OnlineFriends.instance;
    }
    if (messagingDataProvider == null) {
      MessagingDataProvider.getInstance().then((mdp) {
        messagingDataProvider = mdp;
      });
    }

    if (_channel == null ||
        _channel.closeCode == 1008 ||
        _channel.closeCode == 1006 ||
        _channel.closeCode == WebSocketStatus.ABNORMAL_CLOSURE
        ) {
      headers = await _sessionHandler.getHeader();
      _channel = new IOWebSocketChannel.connect(WSHOST, headers: headers);
      print(headers);
      _channel.stream.listen((data) {
        print("In data ... .................................................");
        final jsonMessage = json.decode(data.toString());
        print(jsonMessage.runtimeType);
        // print(jsonMessage.runtimeType);
        // switch (jsonMessage['status']) {
        //   case WS_STATUS_CODE.EEMESSAGE:
        //     {
        //       print("----------------------------");
        //       break;
        //     }
        //   case WS_STATUS_CODE.ACTIVE_FRIENDS:
        //     {
        //       print("messsss");
        //       break;
        //     }
        //   case WS_STATUS_CODE.ALIE_PROFILE_CHANGE:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.DELETE_USER:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.GMESSAGE:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.ALIE_PROFILE_CHANGE:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.SEEN:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.SEEN:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.TYPING:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.GROUP_JOIN:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.GROUP_LEAVE:
        //     {
        //       print("----------------------------");

        //       break;
        //     }
        //   case WS_STATUS_CODE.UNKNOWN:
        //     // TODO: Handle this case.
        //     print("----------------------------");

        //     break;
        //   case WS_STATUS_CODE.STOP_TYPING:
        //     // TODO: Handle this case.
        //     print("----------------------------");

        //     break;
        //   case WS_STATUS_CODE.NEW_ALIE:
        //     // TODO: Handle this case.
        //     print("----------------------------");

        //     break;
        //   case WS_STATUS_CODE.GROUP_PROFILE_CHANGE:
        //     // TODO: Handle this case.
        //     print("----------------------------");

        //     break;
        // }
      }, onError: (mess) {}, cancelOnError: true);
    }
    if (_service == null) {
      _service = WebSocketService();
    }
    return _service;
  }

  static WS_CONNECTION_STATUS status = WS_CONNECTION_STATUS.not_connected;
  WS_CONNECTION_STATUS getStatus() {
    if (_channel == null) {
      status = WS_CONNECTION_STATUS.closed;
    }
    return status;
  }

  // sendEEMessage
  bool sendEEMessage(EEMessage message) {
    print("message written to the websocket");

    final xeemess = XEEMessage(status: 4, body: message);
    print(jsonEncode(xeemess.toJson()));
    _channel.sink.add(jsonEncode(xeemess.toJson()));
  }

  // sendEEMessage
  bool sendSeenMessage(SeenMessage seenmes) {
    _channel.sink.add(jsonEncode(seenmes));
  }

  bool sendTypingMessage(TypingMessage message) {
    _channel.sink.add(jsonEncode(message));
  }

  bool sendGroupMessage(GroupMessage message) {
    _channel.sink.add(jsonEncode(message));
  }

  bool sendJoinLeavMessage(JoinLeaveMessage message) {
    _channel.sink.add(jsonEncode(message));
  }
  // bool
}
