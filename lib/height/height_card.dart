import 'package:bmigoodui/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightCard extends StatefulWidget {
  String genderImageSrc;
  HeightCard({
    Key key,
    this.genderImageSrc,
  }) : super(key: key);
  @override
  _HeightCardState createState() => _HeightCardState(genderImageSrc);
}

class _HeightCardState extends State<HeightCard> {
  double imageHeight = 140.0;
  double heightMark = 135.0;
  List<Text> heightTexts = [];
  String genderImageSrc;

  _HeightCardState(this.genderImageSrc);

  pickerChildren() {
    for (int i = 120; i <= 230; i++) {
      heightTexts.add(Text(
        '$i cm',
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
    pickerChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage(genderImageSrc),
                    height: imageHeight,
                  ),
                ),
                Positioned(
                  bottom: heightMark,
                  left: 70.0,
                  width: 160.0,
                  height: 4.0,
                  child: Image(
                    image: AssetImage('assets/images/height_mark.png'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage('assets/images/Scale.png'),
                    height: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: CupertinoPicker(
              useMagnifier: true,
              itemExtent: 50,
              onSelectedItemChanged: (value) {
                setState(() {
                  imageHeight = 140.0 + value.toDouble();
                  heightMark = 135.0 + value.toDouble();
                });
              },
              children: heightTexts,
            ),
          ),
        ],
      ),
    );
  }
}
