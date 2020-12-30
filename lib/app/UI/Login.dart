import 'package:flutter/material.dart';
import 'package:proj_dec/bloc/bloc.dart';
import '../bloc/logBloc.dart';

class LoginUI extends StatelessWidget {
  LoginUI({this.isLogined});

  final bool isLogined;
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<Log>(context);
    return Center(
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.green,
            title: Text(
              "Press Login",
              style: TextStyle(fontSize: 20.0),
            ),
            leading: Icon(Icons.supervised_user_circle),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              elevation: 1.0,
              child: Text(isLogined ? "Logined" : "not logined",
                  style: TextStyle(
                    fontSize: 20.0,
                  )),
            ),
          ),
          Icon(isLogined ? Icons.done : Icons.lock),
          Divider(),
          FlatButton(
            color: isLogined ? Colors.red : Colors.green,
            padding: EdgeInsets.all(5.0),
            child: isLogined
                ? Icon(Icons.logout, color: Colors.white)
                : Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
            onPressed: () {
              if (isLogined == true) {
                bloc.add(LoginOut());
              } else {
                bloc.add(Login());
              }
            },
          )
        ],
      ),
    );
  }
}

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
            return LoginUI(
              isLogined: snapshot.data.login,
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

          return Center(
            child: Text(
              "",
              style: TextStyle(color: Colors.primaries[1]),
            ),
          );
        });
    return streamBuilder;
  }
}
