import 'dart:io';
import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNavigation extends StatefulWidget {
  final Alie user;
  final String filesPath;

  MyNavigation({this.user, this.filesPath});

  @override
  _MyNavigationState createState() {
    return _MyNavigationState(filesPath: filesPath);
  }
}

class _MyNavigationState extends State<MyNavigation> {
  String profileDir = '';
  // final Alie user;
  final String filesPath;
  bool loading = false;
  _MyNavigationState({Key key, this.filesPath}) {
    // this.profileDir =
    //     "${this.filesPath}${user.imageUrl.split('/')[user.imageUrl.split('/').length - 1]}";
  }

  List<String> categories = [
    "Setting",
    "Theme",
    "About Us",
    "New Group",
    "New Account",
  ];
  Map<String, IconData> categoryList = {
    "Profile": Icons.person,
    "New Group": Icons.new_releases_rounded,
    "Theme": Icons.theater_comedy,
    "Setting": Icons.settings,
    "Add Contact": Icons.person_add,
    "About Us": Icons.group_work_sharp,
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: Container(
          color: Theme.of(context).primaryColorDark,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<UserState, Alie>(
                      builder: (context, user) {
                        return ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: user.imageUrl == ""
                              ? () {
                                  print(
                                      "The File To Be shown is : ${this.profileDir} ");
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File('${this.profileDir}'),
                                      height: 150,
                                      width: 180,
                                    ),
                                  );
                                }()
                              : Image.asset(
                                  "assets/images/greg.jpg",
                                ),
                        );
                      },
                    ),
                    BlocBuilder<UserState, Alie>(
                      builder: (_, me) {
                        Text(
                          me.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).primaryColorLight,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    key: UniqueKey(),
                    itemCount: categories.length,
                    padding: EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(categoryList[categories[index]]),
                        title: Text(categories[index]),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
