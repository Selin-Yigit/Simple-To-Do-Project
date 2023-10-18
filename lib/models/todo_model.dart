class ToDo {
  int? id;
  final String title;
  DateTime creationDate;
  bool isChecked;

  // constructor oluştur.
  ToDo({
    this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
  });

  // datayı database de saklayabilmek için map e dönüştürdük
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'creationDate': creationDate
          .toString(), // sqflite datetime veri tipini desteklemediği için stringe dönüştürdük.
      'isChecked': isChecked
          ? 1
          : 0, // sqflite boolean veri tipinide desteklemediğinden integer olarak saklıyoruz.
    };
  }

  //şimdi yazacağımız fonksiyon sadece debug için kullanılacak

  @override
  String toString() {
    return 'ToDo(id: $id, title: $title,creationDate : $creationDate, ischecked : $creationDate )';
  }
}
