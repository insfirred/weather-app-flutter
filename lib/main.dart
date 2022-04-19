import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: weatherApp(),
  ));
}

class weatherApp extends StatefulWidget {
  const weatherApp({Key? key}) : super(key: key);

  @override
  State<weatherApp> createState() => _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {
  String apiKey = 'f6565cb6e4c23f90a1ca7844cff23a33';
  TextEditingController myController = TextEditingController();
  var city='Noida';
  var temp;
  var humidity;
  var climate;

  Future fetchData(city) async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=' + city +'&units=metric&appid=f6565cb6e4c23f90a1ca7844cff23a33'));
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        temp = data['main']['temp'];
        humidity = data['main']['humidity'];
        climate = data['weather'][0]['main'];
      });
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    fetchData(city);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              alignment: Alignment.center,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                border: Border.all(
                  color: Colors.black,
                  width: 2.0
                ),
                borderRadius: BorderRadius.circular(20)
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'T =>' + temp.toString(),
                    //   style: TextStyle(fontSize: 25),
                    // ),
                    // Text(
                    //   'Humidity: ' + humidity.toString() +'%',
                    //   style: TextStyle(fontSize: 25),
                    // ),
                    // Text(
                    //   'Climate: ' + climate.toString(),
                    //   style: TextStyle(fontSize: 25),
                    // ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    // Text(
                    //   '$city',
                    //   style: TextStyle(fontSize: 25),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          fillColor: Colors.pink,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black , width: 1.0),
                          ),
                          hintText: 'Enter Your City'
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          city = myController.text;
                          fetchData(city);
                          print(temp);
                        });
                      },
                      child: Text('Search'),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      city.toUpperCase(),
                      style: TextStyle(
                        fontSize: 35
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          climate.toString(),
                          style: TextStyle(
                          fontSize: 40
                          ),
                        ),
                        Text(
                          temp.toString() + '\u2103',
                          style: TextStyle(
                          fontSize: 50
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Text(
                      'Humidity: ' + humidity.toString() +'%',
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
