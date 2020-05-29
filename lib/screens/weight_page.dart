import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmigoodui/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

const int minWeight = 0;
const int maxWeight = 150;

class WeightPage extends StatefulWidget {
  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  List<bool> selections = [true, false];
  String weightUnits = 'KGs';
  int weightKgs = 50;
  double weightAngle = ((50 - minWeight) * pi / maxWeight);
//  double weightAngle = pi / 2;
  List<Text> heightTextKgs = [];

  pickerChildrenKgs() {
    for (int i = minWeight; i <= maxWeight; i++) {
      heightTextKgs.add(Text(
        '$i Kg',
        style: TextStyle(
          fontSize: 15.0,
          color: kPickerColor,
        ),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickerChildrenKgs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
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
                            weightUnits = 'KGs';
                          } else {
                            selections[buttonIndex] = false;
                            weightUnits = 'LBs';
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
                          transformWidth: 20.0,
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
                          transformWidth: 280.0,
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
                                color: kToggleColor,
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
                      child: CupertinoPicker(
                        useMagnifier: true,
                        magnification: 1.5,
                        itemExtent: 50,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            weightKgs = minWeight + index;
                            weightAngle = (index * pi / maxWeight);
                          });
                        },
                        children: heightTextKgs,
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
                    Navigator.pop(context);
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
              )
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
