import 'dart:math';

import 'package:bmigoodui/screens/result_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmigoodui/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

const int minWeightKgs = 0;
const int maxWeightKgs = 150;
const int minWeightLbs = 0;
const int maxWeightLbs = 330;

class WeightPage extends StatefulWidget {
  final double height;
  WeightPage({this.height});
  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  List<bool> selections = [true, false];
  String weightUnits = 'Kgs';
  int weightKgs = 50;
  int weightLbs = 110;
  double weightAngle = ((50 - minWeightKgs) * pi / maxWeightKgs);
//  double weightAngle = pi / 2;
  List<Text> heightTextKgs = [];
  List<Text> heightTextLbs = [];
  double heightSquare = 0;
  double bmi;

  pickerChildrenKgs() {
    for (int i = minWeightKgs; i <= maxWeightKgs; i++) {
      heightTextKgs.add(Text(
        '$i Kg',
        style: TextStyle(
          fontSize: 15.0,
          color: kPickerColor,
        ),
      ));
    }
  }

  pickerChildrenLbs() {
    for (int i = minWeightLbs; i <= maxWeightLbs; i++) {
      heightTextLbs.add(Text(
        '$i Lb',
        style: TextStyle(
          fontSize: 15.0,
          color: kPickerColor,
        ),
      ));
    }
  }

  Color getArrowColor() {
    //function
    bmi = (weightKgs / heightSquare);
    if (bmi < 11) {
      return Color.lerp(Color(0xFF050A30), Color(0xFF000C66), bmi / 11);
    } else if (bmi >= 11 && bmi < 18) {
      return Color.lerp(
          Color(0xFF000C66), Colors.blue[400], (bmi - 11) / (18 - 11));
    } else if (bmi >= 18 && bmi < 22) {
      return Color.lerp(
          Colors.blue[400], Color(0xFF00FF00), (bmi - 18) / (22 - 18));
    } else if (bmi >= 22 && bmi < 25) {
      return Color.lerp(
          Color(0xFF00FF00), Color(0xFFFFFF00), (bmi - 22) / (25 - 22));
    } else if (bmi >= 25 && bmi < 30) {
      return Color.lerp(
          Color(0xFFFFFF00), Color(0xFFFF0000), (bmi - 25) / (30 - 25));
    } else
      return Color.lerp(Color(0xFFFF0000), Color(0xFF420D09), (bmi - 30) / 30);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickerChildrenKgs();
    pickerChildrenLbs();
    heightSquare = widget.height * widget.height / 10000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
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
            children: <Widget>[
              SizedBox(
                width: double.infinity,
              ),
              Text(
                'Weight',
                style: TextStyle(
                  color: kGreyTextColor,
                  fontSize: 20.0,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ToggleButtons(
                    constraints:
                        BoxConstraints(minWidth: 100.0, minHeight: 30.0),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    fillColor: kToggleColor,
                    selectedBorderColor: kToggleColor,
                    selectedColor: Colors.white,
                    children: <Widget>[
                      Text('KGs'),
                      Text('LBs'),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < selections.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            selections[buttonIndex] = true;
                            weightUnits = 'Lbs';
                          } else {
                            selections[buttonIndex] = false;
                            weightUnits = 'Kgs';
                          }
                        }
                      });
                    },
                    isSelected: selections,
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: kToggleColor,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        SizedBox(
                          width: 300,
                          height: 170.0,
                        ),
                        WeightLine(
                          rotateAngle: 1 / 2,
                          transformHeight: 125.0,
                          transformWidth: 25.0,
                        ),
                        WeightLine(
                          rotateAngle: 3 / 4,
                          transformHeight: 40.0,
                          transformWidth: 62.0,
                        ),
                        WeightLine(
                          rotateAngle: 0,
                          transformHeight: 0.0,
                          transformWidth: 149.0,
                        ),
                        WeightLine(
                          rotateAngle: 1 / 4,
                          transformHeight: 40.0,
                          transformWidth: 238.0,
                        ),
                        WeightLine(
                          rotateAngle: 1 / 2,
                          transformHeight: 125.0,
                          transformWidth: 275.0,
                        ),
                        Transform.rotate(
                          origin: Offset(0, 25),
                          angle: weightAngle,
                          child: Transform.translate(
                            offset: Offset(-50, 25),
                            child: Transform.rotate(
                              angle: 3 * pi / 2,
                              child: SvgPicture.asset(
                                'assets/images/weight_arrow.svg',
                                color: getArrowColor(),
                                height: 100.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Visibility(
                            visible: (weightUnits == 'Kgs'),
                            child: CupertinoPicker(
                              useMagnifier: true,
                              magnification: 1.5,
                              scrollController:
                                  FixedExtentScrollController(initialItem: 50),
                              itemExtent: 50,
                              onSelectedItemChanged: (index) {
                                if (weightUnits == 'Kgs') {
                                  setState(() {
                                    weightKgs = minWeightKgs + index;
                                    weightAngle = (index * pi / maxWeightKgs);
                                  });
                                } else
                                  index = 0;
                              },
                              children: heightTextKgs,
                            ),
                          ),
                          Visibility(
                            visible: (weightUnits == 'Lbs'),
                            child: CupertinoPicker(
                              useMagnifier: true,
                              magnification: 1.5,
                              scrollController:
                                  FixedExtentScrollController(initialItem: 110),
                              itemExtent: 50,
                              onSelectedItemChanged: (index) {
                                if (weightUnits == 'Lbs') {
                                  weightKgs = index ~/ 2.205;
                                  print(weightKgs);
                                  setState(() {
                                    weightLbs = minWeightLbs + index;
                                    weightAngle = (index * pi / maxWeightLbs);
                                  });
                                } else
                                  index = 0;
                              },
                              children: heightTextLbs,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultPage(
                                bmi: bmi,
                              )),
                    );
                  },
                  child: Center(
                    child: Text(
                      'CALCULATE BMI',
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

class WeightLine extends StatelessWidget {
  final double rotateAngle;
  final double transformHeight;
  final double transformWidth;

  WeightLine({this.rotateAngle, this.transformHeight, this.transformWidth});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: transformWidth,
      top: transformHeight,
      child: Transform.rotate(
        angle: pi * rotateAngle,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 6.0,
            top: 8.0,
          ),
          child: Container(
            height: 30.0,
            width: 3.0,
            color: kToggleColor,
          ),
        ),
      ),
    );
  }
}
