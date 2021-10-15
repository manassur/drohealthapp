import 'package:drohealthapp/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/store/store_bloc.dart';
import 'repository/repository.dart';
import 'utility/colors.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  List<Widget> fragments = [
    Container(),
    Container(),
    BlocProvider<StoreBloc>(
      create: (context) => StoreBloc(repository: Repository()),
      child: StoreScreen(),
    ),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: fragments[_cIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFFEEEBF1),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                 _cIndex == 0 ?'assets/bottom_bar_icons/009-home-1.png':'assets/bottom_bar_icons/001-home.png',
                color: _cIndex == 0 ? AppColors.primaryColor : Colors.grey,
                width: 25,height: 25,
              ),
              title: new Text('Home')),
          BottomNavigationBarItem(
              icon: Image.asset(
                _cIndex == 1?'assets/bottom_bar_icons/008-add-friend-1.png':'assets/bottom_bar_icons/002-add-friend.png',
                color: _cIndex == 1 ? AppColors.primaryColor : Colors.grey,
                width: 25,height: 25,
              ),
              title: new Text('Doctors')),
          BottomNavigationBarItem(
              icon: Image.asset(
                _cIndex == 2?'assets/bottom_bar_icons/003-add-to-cart.png':'assets/bottom_bar_icons/010-add-to-cart-1.png',
                color: _cIndex == 2 ? AppColors.primaryColor : Colors.grey,
                width: 27,height: 27,
              ),
              title: new Text('Pharmacy')),
          BottomNavigationBarItem(
              icon: Image.asset(
                _cIndex == 3?'assets/bottom_bar_icons/007-chat-bubbles-with-ellipsis-1.png':'assets/bottom_bar_icons/006-chat-bubbles-with-ellipsis.png',
                color: _cIndex == 3 ? AppColors.primaryColor : Colors.grey,
                width: 27,height: 27,
              ),
              title: new Text('Community')),
          BottomNavigationBarItem(
              icon: Image.asset(
                _cIndex == 4?'assets/bottom_bar_icons/005-user-1.png':'assets/bottom_bar_icons/004-user.png',
                color: _cIndex == 4 ? AppColors.primaryColor : Colors.grey,
                width: 25,height: 25,
              ),
              title: new Text('Profile'))
        ],
        onTap: (index) {
          _incrementTab(index);
        },
      ),
    );
  }
}
