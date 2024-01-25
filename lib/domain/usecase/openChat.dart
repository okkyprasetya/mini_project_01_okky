import 'package:chat_app_mini_project/data/repository/openChat.dart';
import 'package:chat_app_mini_project/data/repository/roomChat.dart';

class openRoomChat{
  var repository = openChatRepository();

  Future<Map<String,dynamic>> execute(id){
    return repository.getOpenChat(id);
  }
}