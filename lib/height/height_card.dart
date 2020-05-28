import 'package:bmigoodui/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightCard extends StatefulWidget {
  final String genderImageSrc;
  final String unit;
  HeightCard({Key key, this.genderImageSrc, this.unit}) : super(key: key);
  @override
  _HeightCardState createState() => _HeightCardState();
}

class _HeightCardState extends State<HeightCard> {
  double imageHeight = 140.0;
  double heightMark = 135.0;
  List<Text> heightTextMeter = [];
  List<Text> heightTextFeet = [];

  pickerChildrenMeters() {
    for (int i = 120; i <= 230; i++) {
      String x = (i / 100).toStringAsFixed(2);
      heightTextMeter.add(Text(
        '$x m',
        style: TextStyle(
          fontSize: 15.0,
          color: kPickerColor,
        ),
      ));
    }
  }

  pickerChildrenFeet() {
    for (int i = 3; i < 8; i++) {
      for (int j = 0; j < 12; j++) {
        if (i == 7 && j == 8) break;
        if (i == 3 && j < 10) continue;
        heightTextFeet.add(Text(
          '$i.$j ft',
          style: TextStyle(
            fontSize: 15.0,
            color: kPickerColor,
          ),
        ));
      }
    }

    for (int i = 120; i <= 230; i++) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickerChildrenMeters();
    pickerChildrenFeet();
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
                    image: AssetImage(widget.genderImageSrc),
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
                  if (widget.unit == 'meters') {
                    imageHeight = 140.0 + value.toDouble();
                    heightMark = 135.0 + value.toDouble();
                  } else {
                    imageHeight = 140.0 + 2.5 * value.toDouble();
                    heightMark = 135.0 + 2.5 * value.toDouble();
                  }
                });
              },
              children:
                  (widget.unit == 'meters') ? heightTextMeter : heightTextFeet,
            ),
          ),
        ],
      ),
    );
  }
}
