import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_learning/ui/favourite_screen.dart';
import 'package:flutter_bloc_learning/ui/tabs/favourite/favourite_screen.dart';
import 'package:flutter_bloc_learning/ui/tabs/product/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'tabs/cart/cart_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  List<Widget> _buildScreen() {
    return [
      const HomeScreen(),
     const FavouriteProductScreen(),
      const CartScreen(),
      Container(
        color: Colors.orange,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Badge(
          isLabelVisible: context.watch<CartBloc>().state.cartItems.isNotEmpty ? true : false,
          padding: EdgeInsets.zero,
          alignment: const Alignment(1, -0.8),
          backgroundColor: Colors.red,
          label: Text('${context.watch<CartBloc>().state.cartItems.length}'),
          child: Padding(
            padding: EdgeInsets.only(top: context.watch<CartBloc>().state.cartItems.isNotEmpty ? 15.0 : 0),
            child: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarStyle: NavBarStyle.style12,
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
    );
  }
}
