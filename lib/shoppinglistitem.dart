import 'package:flutter_web/material.dart';
import 'package:myfoodrestaurant/provider/provider.dart';
import 'package:myfoodrestaurant/models/cart.dart';
import 'package:myfoodrestaurant/models/datamodel.dart';
import 'package:myfoodrestaurant/shared/custom.style.dart';

typedef void CartChangedCallback(Item item);

class ShoppingListItem extends StatelessWidget {
  
  final Item item;
  const ShoppingListItem({Key key, this.item}) : super(key: key);
      

  Color _getColor(BuildContext context, inCart) {
    return inCart ? Colors.black45 : Theme.of(context).primaryColorLight;
  }

  TextStyle _getTextStyle(BuildContext context, inCart) {
    if (!inCart) {
        return TextStyle(
        color: Colors.redAccent,
        decoration: TextDecoration.none,
    );
    } else {
      return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return ListTile(
      contentPadding: EdgeInsets.only(left: 80.0),
      onTap: () {
        cart.items.contains(item) ? cart.remove(item) : cart.add(item);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context, cart.items.contains(item)),
        child: Text(item.submenu_name.substring(0,2), style: _getTextStyle(context, cart.items.contains(item)),
      ),
      ),
      title: Row(
        children: <Widget>[
          Image.asset(item.image, width: 80.0, height: 80.0,),
          Text(item.submenu_name, style: cHeaderDarkText),
          SizedBox(width: 20.0, height: 20.0,),
          Text('USD \$', style: _getTextStyle(context, cart.items.contains(item))),
          Text(item.price.toString(), style: _getTextStyle(context, cart.items.contains(item))),
        ],
      ),
      subtitle: Text(item.description, style: cHeaderDarkText)
    );
  }
}
