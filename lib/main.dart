import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CalculatorPage(),
    QuizPage(),
    ProfilePage(),
    WeatherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "";
  String result = "";
  bool useRadians = true; // Initialize to radians

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "";
        result = "";
      } else if (buttonText == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(equation);
          ContextModel cm = ContextModel();
          result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          result = "Error";
        }
      } else if (buttonText == "√") {
        equation += "sqrt(";
      } else if (buttonText == "^") {
        equation += "^";
      } else if (buttonText == "!") {
        equation += "!";
      } else if (buttonText == "sin") {
        if (useRadians) {
          equation += "sin(";
        } else {
          equation += "sinD(";
        }
      } else if (buttonText == "cos") {
        if (useRadians) {
          equation += "cos(";
        } else {
          equation += "cosD(";
        }
      } else if (buttonText == "tan") {
        if (useRadians) {
          equation += "tan(";
        } else {
          equation += "tanD(";
        }
      } else if (buttonText == "asin") {
        if (useRadians) {
          equation += "asin(";
        } else {
          equation += "asinD(";
        }
      } else if (buttonText == "acos") {
        if (useRadians) {
          equation += "acos(";
        } else {
          equation += "acosD(";
        }
      } else if (buttonText == "atan") {
        if (useRadians) {
          equation += "atan(";
        } else {
          equation += "atanD(";
        }
      } else if (buttonText == "(") {
        equation += "(";
      } else if (buttonText == ")") {
        equation += ")";
      } else if (buttonText == "π") {
        equation += "π";
      } else if (buttonText == "-") {
        equation += "-";
      } else if (buttonText == "°") {
        useRadians = !useRadians;
      } else if (buttonText == "%") {
        equation += "/100";
      } else {
        equation += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    equation,
                    style: TextStyle(fontSize: 24.0, color: Colors.blue),
                  ),
                  Text(
                    result,
                    style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final buttonLabels = [
                    "C",
                    "(",
                    ")",
                    "-",
                    "7",
                    "8",
                    "9",
                    "/",
                    "4",
                    "5",
                    "6",
                    "*",
                    "1",
                    "2",
                    "3",
                    "+",
                    "log",
                    "0",
                    ".",
                    "=",
                    "√",
                    "^",
                    "!",
                    "%",
                    "asin",
                    "acos",
                    "atan",
                    "°",
                    "sin",
                    "cos",
                    "tan",
                    "π",
                  ];

                  if (index < buttonLabels.length) {
                    return CalculatorButton(
                      buttonText: buttonLabels[index],
                      callback: buttonPressed,
                    );
                  } else {
                    return null;
                  }
                },
                itemCount: 33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final Function(String) callback;

  CalculatorButton({required this.buttonText, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(buttonText),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<Question> questions = [
    Question(
      text: 'What should conversations primarily focus on, according to the first point?',
      choices: ['A) People', 'B) Events', 'C) Negative aspects', 'D) Ideas'],
      correctChoice: 'A) People',
    ),
    Question(
      text: 'What is the key to real self-love, as mentioned in the second point?',
      choices: [
        'A) Ignoring imperfections',
        'B) Accepting what needs improvement',
        'C) Seeking perfection',
        'D) Focusing on external validation'
      ],
      correctChoice: 'B) Accepting what needs improvement',
    ),
    // Add more questions here
  ];

  List<Color> optionColors = List.filled(4, Colors.black);
  bool isAnswered = false;

  void checkAnswer(String selectedAnswer) {
    if (isAnswered) return; // Prevent multiple answers for the same question
    isAnswered = true;

    String correctAnswer = questions[currentQuestionIndex].correctChoice;

    if (selectedAnswer == correctAnswer) {
      setState(() {
        score++;
        optionColors[currentQuestionIndex] = Colors.green;
      });
    } else {
      setState(() {
        optionColors[currentQuestionIndex] = Colors.red;
      });
    }
  }

  void nextQuestion() {
    isAnswered = false; // Reset for the next question
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      }
    });
  }

  void previousQuestion() {
    isAnswered = false; // Reset for the previous question
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          child: Text(
            'Question ${currentQuestionIndex + 1}',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          child: Text(
            questions[currentQuestionIndex].text,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: questions[currentQuestionIndex].choices.asMap().entries.map((entry) {
            int index = entry.key;
            String choice = entry.value;

            return ElevatedButton(
              onPressed: () {
                checkAnswer(choice);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(optionColors[index]),
              ),
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  choice,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.all(8.0),
          child: Text(
            'Score: $score/${questions.length}',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        if (isAnswered && currentQuestionIndex < questions.length - 1)
          ElevatedButton(
            onPressed: nextQuestion,
            child: Text('Next Question'),
          ),
        if (currentQuestionIndex > 0)
          ElevatedButton(
            onPressed: previousQuestion,
            child: Text('Previous Question'),
          ),
      ],
    );
  }
}

class Question {
  final String text;
  final List<String> choices;
  final String correctChoice;

  Question({
    required this.text,
    required this.choices,
    required this.correctChoice,
  });
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: 'Role',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: contactController,
                decoration: InputDecoration(
                  labelText: 'Contact',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                ),
              ),
            ),
            PortfolioItem(
              title: 'Project 1',
              description: 'Description of Project 1.',
            ),
            PortfolioItem(
              title: 'Project 2',
              description: 'Description of Project 2.',
              certificateImageURL:
              'https://ibb.co/6Pc65X4', // Certificate image URL
            ),
            // Add more portfolio items as needed.
          ],
        ),
      ),
    );
  }
}

class PortfolioItem extends StatelessWidget {
  final String title;
  final String description;
  final String? certificateImageURL;

  PortfolioItem({
    required this.title,
    required this.description,
    this.certificateImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Text(description),
          ),
          if (certificateImageURL != null)
            Image.network(
              certificateImageURL!,
              fit: BoxFit.cover,
              height: 200, // Adjust the height as needed
            ),
          // Add more details or links to the project as needed.
        ],
      ),
    );
  }
}
class WeatherModel {
  final String description;
  final double temperature;

  WeatherModel({required this.description, required this.temperature});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController _cityController = TextEditingController();
  String _weatherData = '';
  bool _isCelsius = true;

  Future<void> _getWeather(String city) async {
    final apiKey = '132c929b5c279877ea91d7c8a1d30e16'; // Replace with your OpenWeatherMap API key
    final Uri uri = Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=${_isCelsius ? 'metric' : 'imperial'}');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _weatherData = 'Weather Forecast:\n';
          for (var forecast in data['list']) {
            _weatherData +=
            '${forecast['dt_txt']} - Temperature: ${forecast['main']['temp']}${_isCelsius ? '°C' : '°F'}, Weather: ${forecast['weather'][0]['description']}\n';
          }
        });
      } else {
        setState(() {
          _weatherData = 'Failed to get weather data';
        });
      }
    } catch (e) {
      setState(() {
        _weatherData = 'Failed to get weather data';
      });
    }
  }

  void _toggleTemperatureUnit() {
    setState(() {
      _isCelsius = !_isCelsius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Temperature Unit: ',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: _isCelsius,
                  onChanged: (value) {
                    _toggleTemperatureUnit();
                  },
                ),
                Text(
                  _isCelsius ? 'Celsius' : 'Fahrenheit',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
              child: Text('Open Map'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getWeather(_cityController.text);
              },
              child: Text('Get Weather Forecast'),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Weather Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _weatherData,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Map will be displayed here'),
      ),
    );
  }
}

var lat = 23.8041;
var long = 90.4152;
var api_key = "YOUR_API_KEY"; // Replace with your OpenWeatherMap API key

Future<dynamic> getReq() async {
  final http.Response response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$api_key'));

  debugPrint(response.body);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    // Assuming you have a WeatherModel class
    WeatherModel weatherModel = WeatherModel.fromJson(responseData);
    return responseData;
  } else {
    print("Something went wrong");
    return null; // or handle the error case accordingly
  }
}
