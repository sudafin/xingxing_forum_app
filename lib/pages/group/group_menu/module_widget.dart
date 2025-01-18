import 'package:flutter/material.dart';


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
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/module_detail');
            },
            child: CircleAvatar(
              backgroundImage: widget.image,
              backgroundColor: Colors.transparent,
              radius: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          // 标题和描述还有收藏按钮,需要设置一个容器,设置宽度
          SizedBox(
            width: 280,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            // 标题和描述
             GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/module_detail');
              },
              child: Column(
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
              ),
              // 收藏按钮
              IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: Icon(isFavorite
                    ? Icons.star
                    : Icons.star_border),
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
