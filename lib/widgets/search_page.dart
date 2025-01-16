import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import '../stores/store_viewmodel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowHistory = true;
  bool isShowGuess = true;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        context.watch<StoreViewModel>().theme == Brightness.light
            ? Colors.white
            : Colors.black;

    Color textColor = context.watch<StoreViewModel>().theme == Brightness.light
        ? Colors.black
        : Colors.white;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: backgroundColor,
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            color: context.watch<StoreViewModel>().theme == Brightness.light
                ? Colors.grey[200]
                : Colors.grey[800],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: textColor,size: 18,),
              hintText: '搜索...',
              hintStyle: TextStyle(color: textColor, fontSize: 14),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 11.0),
            ),
            style: TextStyle(color: textColor),
            onSubmitted: (value) {
              // 处理搜索提交
              print('搜索: $value');
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: TextButton(
              child: Text('搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              onPressed: () {
                // 处理搜索按钮点击
                String searchText = _searchController.text;
                print('搜索: $searchText');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              // 历史搜索部分
              isShowHistory ? _buildHistorySearch(textColor) : SizedBox.shrink(),
              // "猜你想搜"部分
              _buildGuessYouLike(textColor),
              // 搜索发现部分 (排行榜)
              isShowGuess
                  ? _buildSearchDiscover(textColor)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySearch(Color textColor) {
    List<String> historyList = [    
      '历史搜索项 1', '历史搜索项 2', '历史搜索项 3', '历史搜索项 4',
      '历史搜索项 5', '历史搜索项 6',
    ];

    return Container(
      
      child: Column(
        //缩短与内容的距离
        // spacing: -10,
        mainAxisSize: MainAxisSize.min,
        children: [
         Container(
          height: SizeFit.screenHeight * 0.05,
          child:  ListTile(
            title: Text(
              '历史搜索',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever_rounded, color: textColor,size: 20),
              onPressed: () {
                // 处理清理历史搜索
                setState(() {
                  isShowHistory = false;
                });
              },
            ),
          ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 7.5,
              mainAxisSpacing: 5,
              crossAxisSpacing: 20,
            ),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(historyList[index], style: TextStyle(color: textColor)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGuessYouLike(Color textColor) {
    List<String> guessList = [
      '猜你想搜项 1', '猜你想搜项 2', '猜你想搜项 3', '猜你想搜项 4', 
      '猜你想搜项 5', '猜你想搜项 6', 
    ];

    return Container(
      margin: EdgeInsets.only(top: 10) ,
      child: Column(
        //缩短与内容的距离
        mainAxisSize: MainAxisSize.min,
        children: [
          //标题
          Container(
           height: SizeFit.screenHeight * 0.05,
           child:  ListTile(
            title: Text(
              '猜你想搜',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                      isShowGuess ? Icons.visibility_off : Icons.visibility,
                      color: textColor,size: 20),
                  onPressed: () {
                    // 处理隐藏"猜你想搜"
                    setState(() {
                      isShowGuess = !isShowGuess;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: textColor,size: 20),
                  onPressed: () {
                    // 处理刷新"猜你想搜"
                    print('刷新"猜你想搜"');
                  },
                ),
              ],
            ),
          ),
          ),
          //缩短距离
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: isShowGuess
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 7.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: guessList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(guessList[index], style: TextStyle(color: textColor)),
                      );
                    },
                  )
                : _buildSearchDiscover(textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchDiscover(Color textColor) {
    List<Map<String, dynamic>> rankingList = [
      {'title': '地震来临时感人瞬间', 'hotValue': '945.4w'},
      {'title': '从教科书上发现自己生病了', 'hotValue': '941.9w'},
      {'title': '国色芳华杨紫眼神戏变化', 'hotValue': '690w'},
      {'title': '李一桐 高智姐感的具象化', 'hotValue': '649.2w'},
      {'title': '西藏老奶奶拉着救援人员的手落泪', 'hotValue': '617.7w'},
      {'title': '军人的作战靴火不侵水不浸', 'hotValue': '611.1w'},
      {'title': '深圳人有自己的阿勒泰', 'hotValue': '606.6w'},
      {'title': '猫咪捏捏脸人事件', 'hotValue': '578.7w'},
      {'title': '猫:有本事打鼠我', 'hotValue': '535.7w'},
      {'title': '白鹿在放瑞鹏面前都内向了', 'hotValue': '485.2w'},
      {'title': '鸡窝头女士收拾漂亮去上班了', 'hotValue': '468.3w'},
      {'title': '宋佳:我其实挺想要成熟微信的', 'hotValue': '462.1w'},
      {'title': '胡润惊现李诞直播间被嘲羊毛', 'hotValue': '460.3w'},
      {'title': '12岁男孩站在板凳上自如控球', 'hotValue': '452w'},
      {'title': '过年新人没 时髦小媳', 'hotValue': '447.1w'},
      {'title': '白鹿素衣哭戏', 'hotValue': '447w'},
      {'title': '全承文打私生粉手机', 'hotValue': '441w'},
    ];

    Color getRankingColor(int index) {
      if (index == 0) {
        return Colors.red;
      } else if (index == 1) {
        return Colors.orange;
      } else if (index == 2) {
        return Colors.yellow;
      } else {
        return textColor;
      }
    }

    return Container(
      margin: isShowGuess ? EdgeInsets.only(top: 10) : EdgeInsets.zero,
      child: Column(
        //缩短与内容的距离
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeFit.screenHeight * 0.05,
            child: ListTile(
              title: Text(
                '搜索发现',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: rankingList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Text(
                      '${index + 1}. ',
                      style: TextStyle(color: getRankingColor(index), fontWeight: FontWeight.bold),
                    ),
                    Text(rankingList[index]['title'], style: TextStyle(color: textColor)),
                  ],
                ),
                trailing: Text(rankingList[index]['hotValue'], style: TextStyle(color: textColor)),
              );
            },
          ),
        ],
      ),
    );
  }
}
