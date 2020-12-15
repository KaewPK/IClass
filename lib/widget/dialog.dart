import 'package:flutter/material.dart';
import 'package:iclass/shared.dart/color.dart';

class CustomDialog extends StatelessWidget {
  final String text, textButton;
  final Color colorButton, colorTextButton;
  final double fontSizeTextButton, fontSizeText;
  final Function onPressed;

  CustomDialog(
      {this.text,
      this.textButton,
      this.colorButton,
      this.colorTextButton,
      this.fontSizeTextButton,
      this.fontSizeText,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.height * 0.05),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: size.width * 0.8,
              padding: EdgeInsets.only(
                  top: size.height * 0.016,
                  bottom: size.height * 0.016,
                  left: size.width * 0.01,
                  right: size.width * 0.01),
              margin: EdgeInsets.only(top: size.height * 0.025),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(size.height * 0.017),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: size.height * 0.02),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'K2D',
                      fontWeight: FontWeight.w500,
                      color: ColorTheme.orange,
                      fontSize: fontSizeText,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        size.width * 0.08,
                        size.height * 0.03,
                        size.width * 0.08,
                        size.height * 0.01),
                    child: RaisedButton(
                      color: colorButton,
                      onPressed: onPressed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              textButton,
                              style: TextStyle(
                                fontFamily: 'K2D',
                                color: colorTextButton,
                                fontSize: fontSizeTextButton,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialogAvatar extends StatelessWidget {
  double padding = 16.0;
  double avatarRadius = 66.0;
  final String title, description, buttonText;
  final Function onPressed;

  CustomDialogAvatar({
    this.title,
    this.description,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: avatarRadius + padding,
              bottom: padding,
              left: padding,
              right: padding,
            ),
            margin: EdgeInsets.only(top: avatarRadius),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(padding),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: padding,
            right: padding,
            child: CircleAvatar(
              backgroundColor: (title == "สำเร็จ") ? Colors.green : Colors.red,
              radius: avatarRadius,
              child: (title == "สำเร็จ")
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    )
                  : Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 50,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
