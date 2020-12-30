import 'package:flutter/material.dart';
import 'package:proj_dec/bloc/bloc.dart';
import '../bloc/BlocBase.dart';

class LoginComp extends StatefulWidget {
  @override
  _LoginCompState createState() => _LoginCompState();
}

class _LoginCompState extends State<LoginComp> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<Log>(context);

    var streamBuilder = StreamBuilder(
        initialData: LoginState(login: false, loading: false, closed: false),
        stream: bloc.stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                Center(
                  child: Text("${snapshot.data.login}"),
                ),
                TextButton(
                  child:
                      Text(snapshot.data.login == false ? "Login" : "Logout"),
                  onPressed: () {
                    if (snapshot.data.login == true) {
                      bloc.add(LoginOut());
                    } else {
                      bloc.add(Login());
                    }
                  },
                ),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text("${snapshot.data.login}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: Text("Active connection"),
            );
          }
          return Center(
            child: Text("Connecting"),
          );
        });
    return streamBuilder;
  }
}
