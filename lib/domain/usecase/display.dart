import 'package:chat_app_mini_project/data/repository/roomChat.dart';
import 'package:chat_app_mini_project/data/repository/userData.dart';

class GetUser{
  var repository = UserDataRepository();

  Future<List> execute(username){
    return repository.getUser(username);
  }
}

class GetRoomChat{
  var repository = roomChatRepository();

  Future<List> execute(username){
    return repository.getRoomChat(username);
  }
}