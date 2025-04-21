import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
class ListNote extends StatelessWidget{
  List<Note> items;
  Function deleteData;
  Function editData;
  ListNote(this.items,this.deleteData,this.editData, {super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context,index){
        return GestureDetector(
          onLongPress: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text('Delete task'),
                    content: const Text('Are you sure ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteData(items[index].id);
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          },
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:(index % 2 ==0) ?  Colors.blue : Colors.pink,
              ),
              margin: const EdgeInsets.only(top: 10,left: 10,right: 10),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            items[index].task,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                            onTap: (){
                              _controller.text = items[index].task;
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Padding(
                                      padding: MediaQuery.of(context).viewInsets,
                                      child: SingleChildScrollView(
                                        child: SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: _controller,
                                                  onChanged: (text){
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:  OutlineInputBorder(),
                                                      labelText: "Your Note"
                                                  ),
                                                ),
                                                const SizedBox(height: 20,),
                                                SizedBox(
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.blue,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10)
                                                          )
                                                      ),
                                                      onPressed: (){
                                                        Note note = items[index];
                                                        note.task = _controller.text;
                                                        editData(note);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Edit note",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Icon(Icons.edit)),
                      ],
                    ),

                  ],
                ),
              )),
        );
      },
    );
  }
}