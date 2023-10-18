import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_project/models/todo_model.dart';

class DatabaseConnect {
  Database? _database;

  // getter oluştur ve database e bağlantı oluştur.
  Future<Database> get database async {
    //burası database in bilgisayardaki konumu
    final dbPath = await getDatabasesPath();
    //database in ismi
    const dbName = 'ToDo.db';
    // dbPath ve dbName i birleştirerek database için full bir path oluşturur.
    final path = join(dbPath, dbName);

    //bağlantıytı açacağız.
    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  // bu fonksiyon database deki tabloları oluşturacak.
  Future<void> _createDB(Database db, int version) async {
    // burada oluşturacağımız sütunların todo_model dekiler ile uyuşmasına dikkat et.
    await db.execute('''
      CREATE TABLE ToDo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
 ''');
  }

  //verileri database e eklemek için olan fonksiyon
  Future<void> insertTodo(ToDo toDo) async {
    //database e bağlantı aç
    final db = await database;
    //ekleme işlemini yap
    await db.insert(
      'ToDo', //tablonun adı
      toDo.toMap(), //ToDo_model de oluşturulan map fonksiyonu
      conflictAlgorithm:
          ConflictAlgorithm.replace, //duplicate girişleri değiştirecek
    );
  }

  // database den silmek için olan fonksiyon
  Future<void> deleteTodo(ToDo toDo) async {
    final db = await database;
    //id ye göre todo yu database den silme işlemi
    await db.delete(
      'ToDo',
      where: 'id==?', // bu kısım todo lidtesindeki id yi kontrol edecek
      whereArgs: [toDo.id],
    );
  }

  //veritabanından tüm verileri almamızı sağlayan fonksiyon
  Future<List<ToDo>> getToDo() async {
    final db = await database;
    //database için query oluşturmak ve to do ları map listesi olarak kaydetmek için
    List<Map<String, dynamic>> items = await db.query(
      'ToDO',
      orderBy: 'id DESC',
    );
    // map listelerindeki itemleri todo listelerinde dönüştüreceğiz
    return List.generate(
      items.length,
      (i) => ToDo(
        id: items[i]['id'],
        title: items[i]['title'],
        creationDate: DateTime.parse(items[i]
            ['creationDate']), // string den DateTime fomatına dönüştürmeliyiz.
        isChecked: items[i]['isChecked'] == 1
            ? true
            : false, // integer ı boolean a çevirmek için yaptık. 1= true, 0 = false.
      ),
    );
  }
}
