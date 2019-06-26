import 'package:flutter_web/material.dart';
import 'package:myfoodrestaurant/provider/provider.dart';
import 'package:myfoodrestaurant/models/cart.dart';
import 'package:myfoodrestaurant/models/datamodel.dart';
import 'shared/custom.style.dart';
import 'shared/custom.components.dart';
import 'dart:convert';
//import 'services/datamodel.dart';

import 'setmenu.dart';
import 'shopcart.dart';
import 'orders.dart';
import 'shoppinglistitem.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => CartModel(),
      child: MyFoodCourtApp(),
    ),
  );
}

class MyFoodCourtApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/': (context) => FoodHome(), - can not set if home: FoodHome() is setup, only works with initiated route
        //'/orders': (context) => Orders(),
        Orders.routeName: (context) => Orders(),
        ShopCart.routeName: (context) => ShopCart(),
        '/setmenu': (context) => SetMenu(),
        //SubMenuList.routeName: (context) => SubMenuList(),
      },
      theme: cThemeData,
      title: cAppTitle,
      debugShowCheckedModeBanner: false,
      //home: FoodHome(title: cAppTitle),
      home: Center(
        child: FoodHome(title: cAppTitle),
      ),
    );
  }
}

class FoodHome extends StatefulWidget {
  final String title;
  FoodHome({Key key, this.title}) : super(key: key);

  @override
  _FoodHomeState createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
  String Menu_ID = "abc1";
  String Menu_Header_Title = "Food Court";
  List<FoodMenu> foodMenuItems = [];
  List<Item> subMenuItems = [];
  List<Item> _subMenuItems = [];

  Future fetchFoodMenu() async {
    var data = await rootBundle.loadString('mockdata/mock-data-menu.json');
    Iterable l = json.decode(data);
    setState(() {
      foodMenuItems = l.map((i) => FoodMenu.fromJson(i)).toList();
    });
  }

  Future fetchSubMenu() async {
    var data = await rootBundle.loadString('mockdata/mock-data-submenu.json');
    Iterable l = json.decode(data);
    setState(() {
      subMenuItems = l.map((i) => Item.fromJson(i)).toList();
      _subMenuItems =
          List.from(subMenuItems.where((item) => item.menu_id == Menu_ID));
    });
  }

  void changeMenu(String menu) {
    setState(() {
      _subMenuItems =
          List.from(subMenuItems.where((item) => item.menu_id == menu));
      var menuTitle = _subMenuItems.firstWhere(
          (item) => item.menu_id.startsWith(menu),
          orElse: () => null);
      if (menuTitle != null) {
        Menu_Header_Title = menuTitle.menu_type;
      } else {
        Menu_Header_Title = "Food Court";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFoodMenu();
    fetchSubMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(Menu_Header_Title, style: cHeaderText),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30.0),
              tooltip: 'Shopping Cart',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/shopcart',
                );
              },
            ),
            IconButton(
              icon:
                  Icon(Icons.restaurant_menu, color: Colors.white, size: 30.0),
              tooltip: 'Orders',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/orders',
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white, size: 30.0),
              tooltip: 'Setup',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/setmenu',
                );
              },
            ),
          ],
        ),
        body: ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: _subMenuItems.map((Item item) {
              return ShoppingListItem(item: item);
            }).toList()),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.only(top: 30.0),
            children: _buildDrawer(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomFloatingActionButton(),
        bottomNavigationBar: CustomBottomAppBar());
  }

  List<Widget> _buildDrawer(BuildContext context) {
    return foodMenuItems.map(_buildDrawerList).toList();
  }

  Widget _buildDrawerList(foodMenu) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(foodMenu.image),
        backgroundColor: Colors.brown.shade300,
        child: Text(foodMenu.menu_type.substring(0, 2)),
      ),
      title: Text(
        foodMenu.menu_type,
        style: cHeaderDarkText,
      ),
      onTap: () {
        changeMenu(foodMenu.menu_id.toString());
        Navigator.pop(context);
      },
    );
  }
}
