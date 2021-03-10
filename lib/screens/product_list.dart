import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_urunler_demo2/data/dbHelper.dart';
import 'package:sqflite_urunler_demo2/models/product.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  List<Product> products;
  int productCount = 0;
  @override
  void initState() {
    // sayfanın açılırken bu sayfada çalışan kodu başlat
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      this.products =
          data; // sayfa da ilk başda boş bir ekran gelir sonra veriler gelmeye başlar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("P"),
              ),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {},
            ),
          );
        });
  }
}
