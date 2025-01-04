import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePageBody();
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => HomePageBodyState();
}
class HomePageBodyState extends State<HomePageBody> {  
  @override
  Widget build(BuildContext context) {
    return Text("wenben");
  }
}
