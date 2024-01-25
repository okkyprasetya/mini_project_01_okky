import 'package:chat_app_mini_project/data/datasource/dataSource.dart';
import 'dart:convert';
import 'package:chat_app_mini_project/domain/entity/roomChat.dart';

class openChatRepository{
  var openChatDataSource = UserDataSource();

  Future<Map<String, dynamic>> getOpenChat(String id) async{
    var Chat = jsonDecode(await openChatDataSource.getChat(id))['data'];

    return Chat;
  }

}
