class roomChat{
    String id;
    List username;
    List text;

    roomChat(
        {
          required this.id,required this.username,required this.text
        }
    );

    // factory roomChat.fromJson(Map<String, dynamic> json){
    //   return switch(json){
    //   {
    //     'id': String id,
    //     'username': List username,
    //     'text': List text,
    //   } => roomChat(id:id,username: username, text: text),
    //   _ => throw const FormatException('Gagal membuat ChatRoom')
    //   };
    // }
    //
    //
    // Map<String, dynamic> toJson() {
    //   return {
    //       'id':this.id,
    //       'nama':this.username,
    //       'text':this.text,
    //   };
    // }
}