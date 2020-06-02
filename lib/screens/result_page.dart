import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  ResultPage({this.bmi});

  String getBmiToString() {
    return bmi.toStringAsFixed(2);
  }

  Color getBmiTextBackground() {
    //function
    if (bmi < 18) {
      return Colors.blue;
    } else if (bmi >= 18 && bmi < 25) {
      return Colors.green;
    } else if (bmi >= 25 && bmi < 35) {
      return Colors.red;
    } else
      return Color(0xFF420D09);
  }

  String getBmiText() {
    //function
    if (bmi < 18) {
      return 'You are Underweight !';
    } else if (bmi >= 18 && bmi < 25) {
      return 'You are Normal';
    } else if (bmi >= 25 && bmi < 35) {
      return 'You are Overweight';
    } else
      return 'You are Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Container(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Your BMI Result',
                style: TextStyle(
                  color: kGreyTextColor,
                  fontSize: 20.0,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                decoration: BoxDecoration(
                    color: getBmiTextBackground(),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                child: Center(
                    child: Text(
                  getBmiText(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                )),
              ),
              Text(
                getBmiToString(),
                style: TextStyle(color: Color(0xFF5F5D5E), fontSize: 80.0),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        BmiInfoText(
                          textString: 'Underweight',
                        ),
                        BmiInfoText(
                          textString: 'Normal',
                        ),
                        BmiInfoText(
                          textString: 'Overweight',
                        ),
                        BmiInfoText(
                          textString: 'Obesity',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        BmiInfoColor(color: Colors.blue),
                        BmiInfoColor(color: Colors.green),
                        BmiInfoColor(color: Colors.red),
                        BmiInfoColor(color: Color(0xFF420D09)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '0',
                          style: TextStyle(color: kToggleColor),
                        ),
                        Text(
                          '18.5',
                          style: TextStyle(color: kToggleColor),
                        ),
                        Text(
                          '25',
                          style: TextStyle(color: kToggleColor),
                        ),
                        Text(
                          '35',
                          style: TextStyle(color: kToggleColor),
                        ),
                        Text(
                          '50',
                          style: TextStyle(color: kToggleColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
              ),
              Container(
                width: 180.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: InkWell(
                  onTap: () {
                    //continue action
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => ResultPage()));
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      'Check Again.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BmiInfoColor extends StatelessWidget {
  final Color color;
  const BmiInfoColor({
    this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 10.0,
        width: double.infinity,
        color: color,
      ),
    );
  }
}

class BmiInfoText extends StatelessWidget {
  final String textString;
  const BmiInfoText({
    this.textString,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Text(
        textString,
        style: TextStyle(fontSize: 12.0),
      ),
    ));
  }
}
