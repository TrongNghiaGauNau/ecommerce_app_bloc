import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/store/store_bloc.dart';

class TabBarProducts extends StatelessWidget {
  const TabBarProducts({super.key});

  @override
  Widget build(BuildContext context) {

    void tabItemSelected(int index){
      context.read<StoreBloc>().add(StoreTabProductClicked(index:index));
    }

    return DefaultTabController(
      length: 5,
      child: TabBar(
        onTap: (selectedTabIndex) {
          tabItemSelected(selectedTabIndex);
        },
        isScrollable: true,
        tabs: const [
          Tab(child: Text('All', style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),),
          Tab(child: Text('Men\'s clothing', style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),),
          Tab(child: Text('Women\'s clothing', style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),),
          Tab(child: Text('Jewelry', style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),),
          Tab(child: Text('Electronics', style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),),
        ],
      ),
    );
  }
}