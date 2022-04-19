import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:keranjang_belanja/models/boxes.dart';
import 'package:keranjang_belanja/models/cart.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print('Form validated');
    } else {
      print('Form not validated');
      return;
    }
  }

  late List<List<String>> items = [];
  late String buah;
  late String harga;
  bool? _isFirstItemSelected = false;
  bool? _isSecondItemSelected = false;
  bool? _isThirdItemSelected = false;
  bool? _isFourthItemSelected = false;
  String buah1 = "Apel";
  String buah2 = "Jeruk";
  String buah3 = "Mangga";
  String buah4 = "Alpukat";
  String harga1 = "Rp 15000,-";
  String harga2 = "Rp 7000,-";
  String harga3 = "Rp 10000,-";
  String harga4 = "Rp 8000,-";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Item'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: Text(buah1),
                  subtitle: Text(harga1),
                  value: _isFirstItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFirstItemSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Jeruk'),
                  subtitle: Text('Rp 7000,-'),
                  value: _isSecondItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSecondItemSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Mangga'),
                  subtitle: Text('Rp 10000,-'),
                  value: _isThirdItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isThirdItemSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Alpukat'),
                  subtitle: Text('Rp 8000,-'),
                  value: _isFourthItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFourthItemSelected = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(60.0),
                        textStyle: TextStyle(fontSize: 20)
                    ),
                    onPressed: () {
                      validated();
                    },
                    child: Text('Masukkan ke Keranjang'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Item> todobox = Hive.box<Item>(HiveBoxes.cart);
    if (_isFirstItemSelected == true) {
      items.add([buah1, harga1]);
      _isFirstItemSelected = false;
    }
    if (_isSecondItemSelected == true) {
      items.add([buah2, harga2]);
      _isSecondItemSelected = false;
    }
    if (_isThirdItemSelected == true) {
      items.add([buah3, harga3]);
      _isThirdItemSelected = false;
    }
    if (_isFourthItemSelected == true) {
      items.add([buah4, harga4]);
      _isFourthItemSelected = false;
    }
    items.forEach((item) {
      todobox.add(Item(buah: item[0], harga: item[1]));
    });
    SnackBar snackBar = SnackBar(content: Text("Item ditambahkan ke keranjang"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(todobox);
  }
}
