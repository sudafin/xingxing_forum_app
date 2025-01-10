import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/store_viewmodel.dart';

class GroupNav {
  static List<NavigationRailDestination> groupNavList = [];
  static BuildContext? context;
  static void initialize(BuildContext context) {
    GroupNav.context = context;
    groupNavList = [
      NavigationRailDestination(
        icon: _navItem(Icons.star, '推荐\n精华', false),
        selectedIcon: _navItem(Icons.star, '推荐\n精华', true),
        label: Text(''),
      ),
      NavigationRailDestination(
        icon: _navItem(Icons.group, '网事\n杂谈', false),
        selectedIcon: _navItem(Icons.group, '网事\n杂谈', true),
        label: Text(''),
      ),
      NavigationRailDestination(
        icon: _navItem(Icons.mobile_friendly, '网络\n游戏', false),
        selectedIcon: _navItem(Icons.mobile_friendly, '网络\n游戏', true),
        label: Text(''),
      ),
      NavigationRailDestination(
        icon: _navItem(Icons.gamepad, '单机\n游戏', false),
        selectedIcon: _navItem(Icons.gamepad, '单机\n游戏', true),
        label: Text(''),
      ),
      NavigationRailDestination(
        icon: _navItem(Icons.manage_accounts, '社区\n事务', false),
        selectedIcon: _navItem(Icons.manage_accounts, '社区\n事务', true),
        label: Text(''),
      ),
      NavigationRailDestination(
        icon: _navItem(Icons.store, '游戏\n周边', false),
        selectedIcon: _navItem(Icons.store, '游戏\n周边', true),
        label: Text(''),
      ),
    ];
  }

  static Widget _navItem(IconData icon, String text, bool isSelected) {
    return Container(
        padding: isSelected ? EdgeInsets.fromLTRB(1, 0, 10, 0) : EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: GroupNav.context != null
              ? GroupNav.context!.watch<StoreViewModel>().theme == Brightness.light
                  ? isSelected ? Colors.white : Colors.white54
                  : isSelected ? Colors.black : Colors.black54
              : Colors.white,
        ),
        width: 60,
        child: Row(
          mainAxisAlignment: isSelected ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            isSelected ? Container(
              width: 3,
              height: 90,
              color: Colors.blue,
            ): SizedBox.shrink(),
            Column(
              children: [
                isSelected
                    ? Icon(
                        icon,
                        size: 25,
                        color: Colors.blue,
                      )
                    : SizedBox.shrink(),
                isSelected ? SizedBox(height: 10) : SizedBox.shrink(),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
