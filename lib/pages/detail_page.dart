import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = "detail_page";
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  _addPost() async {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();

    if(firstName.isEmpty || lastName.isEmpty || content.isEmpty || date.isEmpty) return;

    _apiAddPost(firstName, lastName, content, date);
  }

  _apiAddPost(String firstName, String lastName, String content, String date) async{
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id, firstName, lastName, content, date)).then((response) => {
      print(response),
      _respAddPost(),
    });
  }

  _respAddPost(){
    Navigator.of(context).pop({"data":"done"});
    // Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 15,),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                    hintText: "Firstname"
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                    hintText: "Lastname"
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                    hintText: "Content"
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                    hintText: "Date"
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  color: Colors.deepOrange,
                  child: Text("Add", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    _addPost();
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
