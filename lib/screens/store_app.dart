import 'package:ecommerce_app_bloc/screens/favorites_screen.dart';
import 'package:ecommerce_app_bloc/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/store/store_bloc.dart';
import '../widgets/bottom_appbar_store.dart';
import '../widgets/log_in_out_appbar.dart';
import '../widgets/view_cart_button.dart';
import 'categories_screen.dart';

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StoreAppView();
  }
}

class _StoreAppView extends StatefulWidget {
  const _StoreAppView({super.key});


  @override
  State createState() {
    return _StoreAppViewState();
  }
}

class _StoreAppViewState extends State<_StoreAppView> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(const StoreProductRequest());
    context.read<StoreBloc>().add(const StoreTabProductClicked(index: 0));
  }

  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const CategoriesScreen(), 'title': 'Categories'},
    {'pageName': const ProfileScreen(), 'title': 'Profile'},
    {'pageName': const FavoritesScreen(), 'title': 'Favorites'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: const [
          LogInOutAppBar(),
        ],
      ),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: const ViewCartButton(),
      bottomNavigationBar: BottomAppBarStore(
        selectedPageIndex: _selectedPageIndex,
        onPageSelected: (index) {
          setState(() {
            _selectedPageIndex =index;
          });
        },
      ),
    );
  }
}
