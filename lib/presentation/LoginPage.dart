
import 'package:chat_app_mini_project/main.dart';
import 'package:chat_app_mini_project/presentation/HomePage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Login Page',style:TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            ),
            Container(
              margin: EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 10),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(username: usernameController.text )),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.only(left: 80,right: 80)
                ),
                child: Text('Login',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )

                ),
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}