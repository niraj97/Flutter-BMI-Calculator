import 'package:flutter/material.dart';
import 'package:bmigoodui/constants.dart';

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
              blurRadius: 8,
              spreadRadius: -2,
              color: kShadowColor,
            ),
          ],
        ),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
