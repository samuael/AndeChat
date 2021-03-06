import 'dart:io';

import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final String filesPath;
  SearchResult({Key key, this.filesPath}) : super(key: key);

  HttpCallHandler _httpHandler;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: ListView.builder(
            itemCount: StaticDataStore.searchResultUsers.length,
            itemBuilder: (context, index) {
              final alie = StaticDataStore.searchResultUsers[index];
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, ChatScreen.Route, arguments: {
                  'user': alie,
                }),
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 3,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: alie.unreadMessages > 0
                        ? Color(0XFFffeeee)
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: alie.imageUrl == ""
                                    ? Image.asset(alie.imageUrl == ""
                                        ? "assets/images/avatar.png"
                                        : alie.imageUrl)
                                    : Image.network(
                                        StaticDataStore.HOST + alie.imageUrl ,
                                        height: 150,
                                        width: 180,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  alie.username,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    alie.messages != null &&
                                            alie.messages.length > 0
                                        ? (alie.messages[0]).text
                                        : "Say Hi! to ${alie.username} ",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${Time.fromString(alie.lastSeen).showFullTime()}",
                              overflow: TextOverflow.clip,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 5.0,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            alie.unreadMessages > 0
                                ? Container(
                                    width: 40,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        )),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "New",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(""),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
