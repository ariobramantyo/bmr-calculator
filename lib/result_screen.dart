import 'package:bmr_calculator/user_data.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final UserData userData;
  @override
  const ResultScreen({Key key, this.userData}) : super(key: key);
  _ResultScreenState createState() => _ResultScreenState(userData);
}

class _ResultScreenState extends State<ResultScreen> {
  final UserData userData;

  _ResultScreenState(this.userData);

  String resultBMR(UserData userData) {
    double result;
    if (userData.gender == 66.47) {
      result = userData.exerciseIntensity *
          (userData.gender +
              (userData.height * 5.003) +
              (userData.weight * 13.75) -
              (userData.age * 6.755));
    } else {
      result = userData.exerciseIntensity *
          (userData.gender -
              (userData.age * 4.676) +
              (userData.height * 1.85) +
              (userData.weight * 9.563));
    }
    return result.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your BMR is",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Text(
              resultBMR(userData),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FlatButton(
                minWidth: 200,
                height: 40,
                color: Colors.yellow,
                child: Text("Recalculate"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
