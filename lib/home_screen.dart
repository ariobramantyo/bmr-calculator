import 'package:bmr_calculator/result_screen.dart';
import 'package:bmr_calculator/user_data.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int userAge;
  int userHeight;
  int userWeight;
  double valExercise;
  double genderNum;

  bool boyIsSelected = false;
  bool girlIsSelected = false;
  final List<String> exercisesIntensity = [
    'Little/no exercise',
    'Light exercise',
    'Moderate exercise (3-5 days/wk)',
    'Very active (6-7 days/wk)',
    'Extra active (very active & physical job)'
  ];
  String selectedExercise;
  UserData userData;
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "BMR",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Calculator",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //man button
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              if (girlIsSelected) {
                                boyIsSelected = !boyIsSelected;
                                girlIsSelected = !girlIsSelected;
                              } else {
                                boyIsSelected = true;
                                girlIsSelected = false;
                              }
                            });
                          },
                          child: genderButton(context, boyIsSelected,
                              'images/man.png', 'Male')),
                      SizedBox(
                        width: 20,
                      ),
                      //woman button
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              if (boyIsSelected) {
                                boyIsSelected = !boyIsSelected;
                                girlIsSelected = !girlIsSelected;
                              } else {
                                girlIsSelected = true;
                                boyIsSelected = false;
                              }
                            });
                          },
                          child: genderButton(context, girlIsSelected,
                              'images/woman.png', 'Female')),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //text form field weight
                  inputForm(
                      context, weightController, 'input your weight in kg'),
                  SizedBox(
                    height: 20,
                  ),
                  //text form field height
                  inputForm(
                      context, heightController, 'input your height in cm'),
                  SizedBox(
                    height: 20,
                  ),
                  //text form field age
                  inputForm(context, ageController, 'input your age'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4, 4),
                              color: Colors.grey[300],
                              blurRadius: 15,
                              spreadRadius: 1)
                        ]),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(border: InputBorder.none),
                      dropdownColor: Theme.of(context).primaryColor,
                      hint: Text(
                        "Choose your excercise intensity",
                      ),
                      items: exercisesIntensity
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            child: Text(value), value: value);
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedExercise = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "This field Can\'t be empty";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => selectedExercise = value,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlatButton(
                      height: 40,
                      minWidth: 300,
                      child: Text(
                        "Calculate",
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Colors.amber,
                      focusColor: Colors.yellow,
                      splashColor: Colors.yellow,
                      textColor: Colors.black,
                      onPressed: () {
                        setState(() {
                          if (_key.currentState.validate()) {
                            userAge = int.parse(ageController.text);
                            userHeight = int.parse(heightController.text);
                            userWeight = int.parse(weightController.text);
                            if (selectedExercise == exercisesIntensity[0]) {
                              valExercise = 1.2;
                            } else if (selectedExercise ==
                                exercisesIntensity[1]) {
                              valExercise = 1.375;
                            } else if (selectedExercise ==
                                exercisesIntensity[2]) {
                              valExercise = 1.55;
                            } else if (selectedExercise ==
                                exercisesIntensity[3]) {
                              valExercise = 1.725;
                            } else if (selectedExercise ==
                                exercisesIntensity[4]) {
                              valExercise = 1.9;
                            }
                          }
                          if (!boyIsSelected && !girlIsSelected) {
                            showFlash(
                                context: context,
                                duration: Duration(seconds: 2),
                                builder: (context, controller) {
                                  return Flash.dialog(
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.only(bottom: 40),
                                    controller: controller,
                                    backgroundColor: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(30),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Text(
                                        "You must choose gender",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            if (boyIsSelected) {
                              genderNum = 66.47;
                            } else {
                              genderNum = 655.1;
                            }
                          }
                          if (_key.currentState.validate() &&
                              (boyIsSelected || girlIsSelected)) {
                            userData = UserData(
                                age: userAge,
                                weight: userWeight,
                                height: userHeight,
                                exerciseIntensity: valExercise,
                                gender: genderNum);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          userData: userData,
                                        )));
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget genderButton(
    BuildContext context, bool status, String imageAsset, String comment) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    height: (MediaQuery.of(context).size.width / 2) - 40 + 30,
    width: MediaQuery.of(context).size.width / 2 - 40,
    decoration: BoxDecoration(
        color: status ? Colors.amber : Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1),
        boxShadow: [
          BoxShadow(
              offset: Offset(4, 4),
              color: Colors.grey[300],
              blurRadius: 15,
              spreadRadius: 1)
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  color: status ? Colors.amber[900] : Colors.grey[300],
                  blurRadius: 10,
                  spreadRadius: 1),
              BoxShadow(
                  offset: Offset(-2, -2),
                  color: status ? Colors.amber[100] : Colors.grey[100],
                  blurRadius: 10,
                  spreadRadius: 1)
            ],
          ),
          child: Image(
            image: AssetImage(imageAsset),
            fit: BoxFit.contain,
          ),
        ),
        Text(
          comment,
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget inputForm(BuildContext context, TextEditingController textController,
    String hintText) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          offset: Offset(4, 4),
          color: Colors.grey[300],
          blurRadius: 15,
          spreadRadius: 1)
    ]),
    child: TextFormField(
      controller: textController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).accentColor,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                  color: Colors.amber[800], style: BorderStyle.solid))),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value.isEmpty) {
          return "This field can\'t be empty";
        } else {
          return null;
        }
      },
    ),
  );
}
