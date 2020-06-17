import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:faker/faker.dart';
import 'dart:math';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task7",
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.red),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black38,
        accentColor: Color(0xFF343435),
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: [
              Text("Flute Music Player", style: TextStyle(fontSize: 20)),
              SizedBox(
                width: 80,
              ),
              Text(
                "Now Playing",
                style: TextStyle(fontSize: 12),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(Icons.shuffle),
        onPressed: () {},
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return ListTile(
                    leading: Icon(
                      Icons.android,
                      size: 50,
                      color:
                          RandomColor().randomColor(colorHue: ColorHue.random),
                    ),
                    title: Text(
                        "${Random().nextInt(20)}  ${Faker().lorem.sentence().padLeft(10)}"),
                    subtitle: Text("by ${Faker().person.name()}"),
                  );
                  break;
                case 1:
                  return ListTile(
                    leading: Icon(
                      Icons.add_shopping_cart,
                      size: 50,
                      color:
                          RandomColor().randomColor(colorHue: ColorHue.random),
                    ),
                    title: Text(
                        "${Random().nextInt(20)}  ${Faker().lorem.sentence().padLeft(10)}"),
                    subtitle: Text("by ${Faker().person.name()}"),
                  );

                  break;
                default:
                  return ListTile(
                    leading: Icon(
                      Icons.play_circle_filled,
                      size: 50,
                      color:
                          RandomColor().randomColor(colorHue: ColorHue.random),
                    ),
                    title: Text(
                        "${Random().nextInt(20)}  ${Faker().lorem.sentence().padLeft(10)}"),
                    subtitle: Text("by ${Faker().person.name()}"),
                  );
              }
            }),
      ),
    );
  }
}
