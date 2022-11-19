import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(
      MaterialApp(
    title: "weather",
    home: home(),
  )
  );
}
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _homeState();
}
class _homeState extends State<home> {
  var temp,description,currently,humidity,windspeed;
  Future getwheather() async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=India&appid=50340cacb746c6cc97631f4211611991"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.humidity = results['main']['humidity'];
      this.windspeed = results['wind']['speed'];
    });
  }
  @override
  void initState()
  {
    super.initState();
    this.getwheather();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(

            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "weather now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    ),
                  ),
                ),
                Text(
                  temp.toString()+"\u00B0 C",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "summer",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14
                    ),
                  ),
                ),
              ]
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(CupertinoIcons.thermometer),
                      title: Text("temperature"),
                      trailing: Text("32\u00B0 C"),

                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.cloud),
                      title: Text("climate"),
                      trailing: Text("32\u00B0 C"),

                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.settings),
                      title: Text("humidity"),
                      trailing: Text(
                       humidity.toString(),
                      ),

                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.wind),
                      title: Text("wind-speed"),
                      trailing: Text(
                        windspeed.toString(),
                      ),
                    ),
                  ],
                ),
          ),
          )
        ]
      )
    );
  }
}