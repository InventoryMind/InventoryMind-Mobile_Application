import 'package:flutter/material.dart';
import 'package:inventory_mind/widgets/header_widget.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Profile Page"),
      body: SingleChildScrollView(
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
                    'Pasindu Udawatta',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
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
                                          title: Text("180652A"),
                                          subtitle: Text("User ID"),
                                        ),
                                        ListTile(
                                          leading: IconButton(
                                            icon: Icon(Icons.email),
                                            onPressed: () {},
                                          ),
                                          title:
                                              Text("pasinduu.18@cse.mrt.ac.lk"),
                                          subtitle: Text("Email"),
                                        ),
                                        ListTile(
                                          leading: IconButton(
                                            icon: Icon(Icons.phone),
                                            onPressed: () {},
                                          ),
                                          title: Text("0111234567"),
                                          subtitle: Text("Contact Number"),
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
      ),
    );
  }
}
