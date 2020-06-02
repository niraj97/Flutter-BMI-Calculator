import 'package:bmigoodui/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightCard extends StatefulWidget {
  final String genderImageSrc;
  final String unit;
  final Function getHeight;
  HeightCard({Key key, this.genderImageSrc, this.unit, this.getHeight})
      : super(key: key);
  @override
  _HeightCardState createState() => _HeightCardState();
}

class _HeightCardState extends State<HeightCard> {
  double imageHeight = 180.0;
  double heightMark = 175.0;
  List<Text> heightTextMeter = [];
  List<Text> heightTextFeet = [];
  int height = 120;

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
            child: Stack(
              children: <Widget>[
                Visibility(
                  visible: (widget.unit == 'meters'),
                  child: CupertinoPicker(
                      useMagnifier: true,
                      magnification: 1.5,
                      scrollController:
                          FixedExtentScrollController(initialItem: 40),
                      itemExtent: 50,
                      onSelectedItemChanged: (index) {
                        if (widget.unit == 'meters') {
                          height = 120 + index;
                          widget.getHeight(height);
                          setState(() {
                            imageHeight = 140.0 + index.toDouble();
                            heightMark = 135.0 + index.toDouble();
                          });
                        } else
                          index = 0;
                      },
                      children: heightTextMeter),
                ),
                Visibility(
                  visible: (widget.unit == 'feet'),
                  child: CupertinoPicker(
                    useMagnifier: true,
                    magnification: 1.5,
                    scrollController:
                        FixedExtentScrollController(initialItem: 17),
                    itemExtent: 50,
                    onSelectedItemChanged: (index) {
                      if (widget.unit == 'feet') {
                        height = (120.0 + 2.54 * index).toInt();
                        widget.getHeight(height);
                        setState(() {
                          imageHeight = 140.0 + 2.5 * index.toDouble();
                          heightMark = 135.0 + 2.5 * index.toDouble();
                        });
                      } else
                        index = 0;
                    },
                    children: heightTextFeet,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
