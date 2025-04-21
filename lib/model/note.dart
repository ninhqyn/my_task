class Note {
 int id;
 String task;

 Note(this.id, this.task);

 Map<String, dynamic> toMap() {
  return {
   'id': id != 0 ? id : null,
   'task': task,
  };
 }

 factory Note.fromMap(Map<String, dynamic> map) {
  return Note(
   map['id'],
   map['task'],
  );
 }
}
