import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/token_role_preferences.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/widgets/header_widget.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:http/http.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<Map> _loadData(BuildContext context) async {
    final String _userRole = TokenRolePreferences.getUserRole();
    String? _url;
    if (_userRole == "Technical Officer") {
      _url = toProfileURL;
    } else if (_userRole == "Lecturer") {
      _url = lecProfileURL;
    } else if (_userRole == "Student") {
      _url = stuProfileURL;
    }
    Map resBody = await getReq(context, Client(), _url!);
    return resBody["msg"]["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Profile Page"),
      body: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              Map _data = snapshot.data as Map;
              print(_data);
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      child: HeaderWidget(100, false, Icons.house_rounded),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            _data["first_name"] + " " + _data["last_name"],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 4.0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "User Information",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Card(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            ...ListTile.divideTiles(
                                              color: Colors.grey,
                                              tiles: [
                                                ListTile(
                                                  leading: IconButton(
                                                    icon: Icon(Icons.person),
                                                    onPressed: () {},
                                                  ),
                                                  title: Text(_data["user_id"]),
                                                  subtitle: Text("User ID"),
                                                ),
                                                ListTile(
                                                  leading: IconButton(
                                                    icon: Icon(Icons.email),
                                                    onPressed: () {},
                                                  ),
                                                  title: Text(_data["email"]),
                                                  subtitle: Text("Email"),
                                                ),
                                                ListTile(
                                                  leading: IconButton(
                                                    icon: Icon(Icons.phone),
                                                    onPressed: () {},
                                                  ),
                                                  title:
                                                      Text(_data["contact_no"]),
                                                  subtitle:
                                                      Text("Contact Number"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
