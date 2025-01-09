import 'package:flutter/material.dart';

class EmojiPage extends StatelessWidget {
  static List<Map<String, String>> emojis = [
      {'[smile]': '😊'}, 
      {'[album]': '🎉'},
       {'[video]': '😣'}
    ];
  final Function(String) onEmojiSelected;

  const EmojiPage({super.key, required this.onEmojiSelected});

  @override
  Widget build(BuildContext context) {
   
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: emojis.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onEmojiSelected(emojis[index].values.first),
            child: Center(
              child: Text(emojis[index].values.first),
            ),
          );
        },
      ),
    );
  }
}
