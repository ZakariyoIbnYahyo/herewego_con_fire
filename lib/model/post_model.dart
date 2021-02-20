class Post{
  String userId;
  String firstName;
  String lastName;
  String content;
  String date;

  Post(String userId, String firstName, String lastName, String content, String date){
    this.userId = userId;
    this.firstName = firstName;
    this.lastName = lastName;
    this.content = content;
    this.date = date;

  }

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    "userId" : userId,
    "firstName" : firstName,
    "lastName" : lastName,
    "content" : content,
    "date" : date
  };

}