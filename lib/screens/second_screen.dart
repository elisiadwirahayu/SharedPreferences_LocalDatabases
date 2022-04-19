import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keranjang_belanja/models/boxes.dart';
import 'package:keranjang_belanja/models/cart.dart';
import 'package:keranjang_belanja/screens/third_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TokoKu',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Keranjang Belanja"),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Item>(HiveBoxes.cart).listenable(),
          builder: (context, Box<Item> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text('Keranjang belanja masih kosong'),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Item? res = box.getAt(index);
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    res!.delete();
                  },
                  child: ListTile(
                    title: Text(res!.buah),
                    subtitle: Text(res!.harga),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                tooltip: 'Tambahkan sesuatu ke keranjang',
                child: Icon(
                    Icons.add
                ),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItem(),
                      )
                  )
                }
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                tooltip: 'Logout',
                child: Icon(
                    Icons.logout
                ),
                onPressed: () {
                  logindata.setBool('login', true);
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => MyLoginPage()));
                },
              )
            ]
        )
    );
  }
}
