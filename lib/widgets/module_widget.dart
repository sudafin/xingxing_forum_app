import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';

class ModuleWidget extends StatefulWidget {
  final String title;
  final ImageProvider image;
  final String description;
  const ModuleWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.description});

  @override
  ModuleWidgetState createState() => ModuleWidgetState();
}

class ModuleWidgetState extends State<ModuleWidget> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          // 头像
          CircleAvatar(
            backgroundImage: widget.image,
            backgroundColor: Colors.transparent,
            radius: 30,
          ),
          SizedBox(
            width: 10,
          ),
          // 标题和描述还有收藏按钮,需要设置一个容器,设置宽度
          SizedBox(
            width: SizeFit.screenWidth - 190,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            // 标题和描述
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
             
              // 收藏按钮
              IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: Icon(isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
                color:isFavorite ? Colors.orange : Colors.grey,
              ),
              ],
            ),
          ),
          // 标题和描述
        ],
      ),
    );
  }
}
