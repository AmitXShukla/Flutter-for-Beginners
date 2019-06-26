import 'package:flutter_web/material.dart';
import 'package:myfoodrestaurant/provider/provider.dart';
import 'package:myfoodrestaurant/models/cart.dart';
import 'package:myfoodrestaurant/models/datamodel.dart';
//import 'package:myfoodrestaurant/shared/custom.style.dart';

// TODO SAMPLE CODE
// cart.items.isEmpty ? null : () => _updateCart(cart.items),
// _updateCart(order) async {
//       var x = await cart.addorders(order);
//       Navigator.pop(context);
//     }
class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.receipt,
                    color: cart.items.isNotEmpty
                        ? Colors.lightBlueAccent
                        : Colors.grey,
                    size: 30.0),
                //onPressed: null,
                onPressed: () {// TODO: ITEMS IS NOT EMPTY
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: new Text(cart.items.last.submenu_name.toString()),
                            content: new Text(cart.items.last.recipe.toString()),
                          ));
                }),
            IconButton(
                icon: Icon(Icons.sms,
                    color: cart.items.isNotEmpty
                        ? Colors.lightBlueAccent
                        : Colors.grey,
                    size: 30.0),
                // onPressed: () {})
                onPressed: () { // TODO: ITEMS IS NOT EMPTY
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: new Text(cart.items.last.submenu_name.toString()),
                            content: new Text(cart.items.last.review.toString()),
                          ));
                }),
          ]),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final Item item;
  const CustomFloatingActionButton({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart,
          color: cart.items.isNotEmpty ? Colors.redAccent : Colors.blueGrey,
          size: 30.0),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/shopcart',
        );
      },
      backgroundColor:
          cart.items.isNotEmpty ? Colors.lightBlueAccent : Colors.grey,
    );
  }
}
