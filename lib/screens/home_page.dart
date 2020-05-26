import 'package:flutter/material.dart';
import 'package:bmigoodui/constants.dart';
import 'package:bmigoodui/height/height_card.dart';

const int inActiveFlex = 2;
const int activeFlex = 3;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> selections = List.generate(2, (_) => false);
  double photoHeight = 220.0;
  int maleFlex = inActiveFlex;
  int femaleFlex = activeFlex;
  int otherFlex = inActiveFlex;
  String genderClicked = 'female';
  String genderImgSrc = 'assets/images/female_shad.png';

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
                textAlign: TextAlign.left,
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
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
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
              ToggleButtons(
                constraints: BoxConstraints(minWidth: 100.0, minHeight: 30.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                fillColor: kToggleColor,
                selectedBorderColor: kToggleColor,
                disabledBorderColor: kToggleColor,
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
                      } else {
                        selections[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: selections,
              ),
              SizedBox(
                height: 27.0,
              ),
              HeightCard(
                genderImageSrc: genderImgSrc,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 150.0,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: RawMaterialButton(
                  onPressed: () {
                    //continue action
                    print('button Clicked');
                  },
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
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

class GenderCard extends StatefulWidget {
  final String gender;
  final String imgSrc;
  const GenderCard({
    Key key,
    @required this.gender,
    @required this.imgSrc,
  }) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 15,
              spreadRadius: 2,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(widget.imgSrc),
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                widget.gender,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: (widget.gender == 'Male')
                      ? kMaleColor
                      : (widget.gender == 'Female')
                          ? kFemaleColor
                          : kOtherColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
