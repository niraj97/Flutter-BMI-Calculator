import 'package:flutter/material.dart';
import 'package:bmigoodui/constants.dart';
import 'package:bmigoodui/util/my_painter.dart';

class WeightPage extends StatefulWidget {
  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  List<bool> selections = [true, false];
  String weightUnits = 'KGs';

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
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    CustomPaint(
                      painter: MyPainter(),
                      size: Size(300, 300),
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
