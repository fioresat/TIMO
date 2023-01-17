import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'dart:ui' as ui;

class QuoteWidget extends StatefulWidget {
  final String author;
  final String content;
  final double? height;

  const QuoteWidget(
      {required this.content,
      super.key,
      required this.author,
      required this.height});

  @override
  State<QuoteWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showDialog,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.author,
            style: const TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 0.008 * widget.height!,
          ),
          Text(
            widget.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future _showDialog() => showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        double widthScreen = MediaQuery.of(context).size.width;
        double heightScreen = MediaQuery.of(context).size.height;
        return BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Container(
              padding: EdgeInsets.only(
                top: 0.03 * heightScreen,
              ),
              width: widthScreen,
              height: heightScreen,
              color: Colors.white.withOpacity(0.7),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            top: 0.03 * heightScreen,
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        'assets/icons/close_icon.png',
                        scale: 3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.03 * heightScreen),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.author,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'CeraPro'),
                          ),
                        ),
                        SizedBox(
                          height: heightScreen * 0.03,
                        ),
                        Text(
                          widget.content,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'CeraPro'),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        );
      });
}
