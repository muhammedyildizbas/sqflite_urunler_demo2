import 'dart:async';
import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_urunler_demo2/models/product.dart';

class DbHelper{

  Database _db;

  Future<Database> get db async{ // asenkron ve Future düzeneği  program içerisinde sıralı işlem grublarının bir arada çalışmasını sağlar yani biri diğerinin bitmesini beklemez iki işlem aynı anda ilerler.
    if(_db==null){
      _db = await  initializeDb(); // buradaki kısım uygulama çalıştığı zaman ilk database oluşturur. Burada bulunan await işlemi ise _db database oluşturduktan sonra aşağıdaki Future oluşmasını bekle demektir.
    }
    return _db; // eğer uygulama çalışmaya devam ediyorsa yeni bir veri eklenildiğinde initializeDb() kısmı değil bu satır çalışır
  
  }

 Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),"etrade.db"); //Join yapısını çalıştırma amacımız: her cihazın örneğin android veya ios cihazlarında veri tabanı yolu farklıdır. eklediğimiz path kütüphanesi ile join birlikte çalışarak cihazlardaki veri tabanı yolunu bulur.
  var eTradeDb = await openDatabase(dbPath,version: 1,onCreate: createDb); // veri tabanı açıkmı açık değilse  onCreate ile createDb metodu ile oluştur.
  return eTradeDb;
  }


  FutureOr<void> createDb(Database db, int version) async {
    await db.execute("Create table products(id integer primary key , name text , description text , unitPrice integer)"); // execute oluştur
  }
  Future<List<Product>> getProducts() async { // veri tabanından product listesini getiriyoruz
    Database db = await this.db;
    var result = await db.query("products");
  return List.generate(result.length, (i) { //product dosyasında bulunan result objesi için index değerine göre sürekli listeyi gezer eklenir ve yeni ürün oluşturur.
    return Product.fromObject(result[i]);
    });
  }
  Future<int> instert(Product product) async{
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());  // veri tabanı işlemlerinde Map değerleri istenir. Örneğin ürün ismini uygulamada nereye yazacağım vd. bilgileri nereye yazacağım gibi işlemler için product.dart da her yerden erişilebilmesi için toMap() fonksiyonu oluşturuldu.

  }
  Future<int> delete(int id) async{ // silme işlemi
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id= $id"); // $ bu sembol + işareti ile aynı anlamı temsil etmektedir.
    return result;
  }
  Future<int> update(Product product) async{ // update işlemi
    Database db = await this.db;
    var result = await db.update("products",product.toMap(), where: "id=?", whereArgs: /* where Args burada istediği listeyi veriyoruz = */ [product.id]);
    return result;
   }

}