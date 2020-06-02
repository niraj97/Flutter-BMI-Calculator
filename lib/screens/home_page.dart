import 'package:bmigoodui/screens/weight_page.dart';
import 'package:flutter/material.dart';
import 'package:bmigoodui/constants.dart';
import 'package:bmigoodui/height/height_card.dart';
import 'package:bmigoodui/Gender/gender_card.dart';
import 'weight_page.dart';

const int inActiveFlex = 2;
const int activeFlex = 3;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> selections = [true, false];
  int maleFlex = inActiveFlex;
  int femaleFlex = activeFlex;
  int otherFlex = inActiveFlex;
  String genderClicked = 'female';
  String genderImgSrc = 'assets/images/female_shad.png';
  String heightUnits = 'meters';
  int height = 120;

  updateFlex() {
    if (genderClicked == 'male') {
      if (maleFlex == inActiveFlex) {
        maleFlex = activeFlex;
        femaleFlex = inActiveFlex;
        otherFlex = inActiveFlex;
      }
    } else if (genderClicked == 'female') {
      if (femaleFlex == inActiveFlex) {
        maleFlex = inActiveFlex;
        femaleFlex = activeFlex;
        otherFlex = inActiveFlex;
      }
    } else {
      if (otherFlex == inActiveFlex) {
        maleFlex = inActiveFlex;
        femaleFlex = inActiveFlex;
        otherFlex = activeFlex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Text(
                'Gender',
                style: TextStyle(
                  color: kGreyTextColor,
                  fontSize: 20.0,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: maleFlex,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          //do
                          genderClicked = 'male';
                          genderImgSrc = 'assets/images/male_shad.png';
                          updateFlex();
                        });
                      },
                      child: GenderCard(
                        gender: 'Male',
                        imgSrc: 'assets/images/male_grad.png',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: femaleFlex,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          //do
                          genderClicked = 'female';
                          genderImgSrc = 'assets/images/female_shad.png';
                          updateFlex();
                        });
                      },
                      child: GenderCard(
                        gender: 'Female',
                        imgSrc: 'assets/images/female_grad.png',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: otherFlex,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          //do
                          genderClicked = 'other';
                          genderImgSrc = 'assets/images/others_shad.png';
                          updateFlex();
                        });
                      },
                      child: GenderCard(
                        gender: 'Others',
                        imgSrc: 'assets/images/others_grad.png',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Height',
                  style: TextStyle(
                    color: kGreyTextColor,
                    fontSize: 20.0,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
//                borderColor: kToggleColor,
                    selectedColor: Colors.white,
                    children: <Widget>[
                      Text('Meters'),
                      Text('Feet'),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < selections.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            selections[buttonIndex] = true;
                            heightUnits = 'feet';
                          } else {
                            selections[buttonIndex] = false;
                            heightUnits = 'meters';
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
                height: 27.0,
              ),
              HeightCard(
                genderImageSrc: genderImgSrc,
                unit: heightUnits,
                getHeight: (value) {
                  height = value;
                },
              ),
              SizedBox(
                height: 20.0,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeightPage(
                                height: height.toDouble(),
                              )),
                    );
                  },
                  child: Center(
                    child: Text(
                      'CONTINUE',
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
