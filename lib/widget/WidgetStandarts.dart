import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/Strings.dart';
import 'package:flutter_github_demo/widget/Colors.dart';

class WidgetStandarts {
  static double height;
  static double width;

  static BoxDecoration getHeaderDecoration(){
    return BoxDecoration(
        gradient: LinearGradient(
          colors: UIColors.orangeGradients,
        )
    );
  }

  static getText(String text,
      [double _fontSize, FontStyle _fontStyle, FontWeight _fontWeight, Color color]) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Text(
        text,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: _fontWeight,
          color: color,
        ),
      ),
    );
  }

  static flatCancleButton(BuildContext context, String buttonName) {
    return FlatButton(
      color: UIColors.whiteColor,
      child: Text(
        buttonName,
        style: TextStyle(color: UIColors.blackColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  static cancleOkButton(context, btnName) {
    return Padding(
      padding: EdgeInsets.only(right: 27.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          WidgetStandarts.flatCancleButton(context, "CANCLE"),
          new ButtonTheme(
            minWidth: 60.0,
            height: 36.0,
            child: RaisedButton(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: UIColors.orangeGradients
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                child: Text(
                  btnName,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              padding: EdgeInsets.all(0.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              textColor: UIColors.whiteColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  static void getWidthAndHeight(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  static SizedBox getSizedBoxHeight(double h) {
    return SizedBox(height: height * (h));
  }

  static SizedBox getSizedBoxWidth(double w) {
    return SizedBox(width: width * (w));
  }

  static Widget loder() {
    return Center(child: CircularProgressIndicator());
  }

  static loderDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        // builder: (BuildContext context) {
        //   return AlertDialog(
        //     content:
        //     Container(
        //         width: 35.0,
        //         height: 70.0,
        //         child:
        //         new Center(child: new CircularProgressIndicator())),
        //   );
        // }
        builder: (BuildContext context) {
          return Center(child: new CircularProgressIndicator());
        });
  }
}