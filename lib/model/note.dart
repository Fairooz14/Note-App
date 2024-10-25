//model class
class Note {
  int? id;
  String? title;
  String? description;

  //constructor
  Note({this.id, this.title, this.description});

  //for saving data to db
  //name must be same as table name in db
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  //for retrieving data from db
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
