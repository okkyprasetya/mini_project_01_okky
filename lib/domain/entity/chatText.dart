class chatText{
  String id;
  String username;
  String text;

  chatText({required this.id,required this.username,required this.text});

  Map<String, dynamic> toJson() {
    return {
      'id':this.id,
      'username':this.username,
      'text':this.text,
    };
  }
}



