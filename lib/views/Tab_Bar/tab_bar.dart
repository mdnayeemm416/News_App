import 'package:flutter/material.dart';
import 'package:news_app/AppConstant/app_constant.dart';
import 'package:news_app/views/Home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "images/newsWatch1.png",
            height: 30,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: blueColor,
              ),
            )
          ],
        ),
        body: const Column(
          children: [
            TabBar(
                isScrollable: true,
                automaticIndicatorColorAdjustment: true,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: blueColor,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                indicatorColor: blueColor,
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Business"),
                  Tab(text: "Entertainment"),
                  Tab(text: "General"),
                  Tab(text: "Health"),
                  Tab(text: "Sports"),
                ]),
            Expanded(
              child: TabBarView(children: [
                Home(),
                Home(),
                Home(),
                Home(),
                Home(),
                Home(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
