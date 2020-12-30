import 'package:flutter/material.dart';
import 'package:proj_dec/bloc/bloc.dart';
import './app/bloc/BlocBase.dart';
import './app/UI/Login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: BlocProvider(
          blocBuilder: () => Log(),
          blocDispose: (Log bloc) => bloc.dispose(),
          child: LoginComp(),
        ),
      ),
    );
  }
}
