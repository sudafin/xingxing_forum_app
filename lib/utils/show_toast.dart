import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';

class ShowToast {
  static void showToast(String message) {
    Fluttertoast.showToast(msg: message,textColor: Colors.white,backgroundColor: Color(0xFF555555));
  }

  static void showCustomDialog(
    BuildContext context,
    String title,
    String message,
    String cancelText,
    String confirmText,
    VoidCallback onCancel,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetAnimationDuration: Duration(milliseconds: 300),
          insetAnimationCurve: Curves.linear,
          child: Container(
            padding: EdgeInsets.all(20),
            height: SizeFit.screenHeight * 0.21,
            width: SizeFit.screenWidth * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        onCancel();
                        Navigator.of(context).pop(); // 关闭弹窗
                      },
                      child: Text(cancelText),
                    ),
                    TextButton(
                      onPressed: () {
                        onConfirm();
                        Navigator.of(context).pop(); // 关闭弹窗
                      },
                      child: Text(confirmText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

