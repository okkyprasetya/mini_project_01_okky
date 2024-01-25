
import 'dart:convert';

import 'package:chat_app_mini_project/data/datasource/dataSource.dart';

import '../../domain/entity/chatText.dart';
class sendMessagesRepo {
  Future<bool> createMessage(chatText message) async{
    var response = await UserDataSource().addNewMessages(message.toJson());

    return jsonDecode(response)['data'];
  }
}


