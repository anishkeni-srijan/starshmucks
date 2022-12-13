import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/wishlist.dart';
import '/db/menu_db.dart';
import '/home/home_screen.dart';

import 'common_things.dart';
import 'db/cart_db.dart';
import 'db/wishlist_db.dart';
import 'model/cart_model.dart';
import 'model/wishlist_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

var product;

getpdata(item) {
  product = item;
}

class _ProductDetailState extends State<ProductDetail> {
  addToCart(prod) async {
    CartDB cdb = CartDB();
    MenuDB db = MenuDB();
    var ttl = await cdb.getDataCart();
    ttl.isEmpty
        ? cdb.insertDataCart(CartModel(id: prod.id, qty: 1))
        : cdb.insertDataCart(CartModel(id: prod.id, qty: 1));
  }

  late List<int> ids = [];

  getIds() async {
    ids.clear();
    late List<WishlistModel> datalist = [];
    datalist = await wdb.getDataWishlist();
    for (var i = 0; i < datalist.length; i++) {
      ids.add(datalist[i].id);
    }
    setState(() {});
  }

  addToWishlist(context, id) async {
    wdb.insertDataWishlist(WishlistModel(id: id));

    getIds();
    // setState(() {});
  }

  removefromwishlist(sendid) {
    wdb.deleteitemFromWishlist(sendid);
    getIds();
  }

  late FToast fToast;
  late WishlistDB wdb;

  @override
  void initState() {
    wdb = WishlistDB();
    wdb.initDBWishlist();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    bool status = false;
    for (var i = 0; i < ids.length; i++) {
      if (ids[i] == product.id) status = true;
    }
    return Scaffold(
        // persistentFooterButtons: cartinit ? [viewincart()] : null,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              addToCart(product);
              cartinit = true;
              setState(() {});
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(HexColor("#036635"))),
            child: const Text("Add To Cart"),
            //   ),
            // ],
          ),
        ),
        appBar: gethomeappbar("Starschmucks", [Container()], false, 10.0),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://picsum.photos/id/1060/536/354.jpg?blur=5",
                        scale: 4),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(
                          0, MediaQuery.of(context).size.height * 0.30, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        product.image,
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.45,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: product.category == 'cake'
                    ? EdgeInsets.only(top: 0)
                    : EdgeInsets.only(top: 60),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2,
                ),
                transform: Matrix4.translationValues(
                    0, MediaQuery.of(context).size.height * -0.15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(product.category),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Quantity",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(product.quantity),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2,
                ),
                transform: Matrix4.translationValues(
                    0, MediaQuery.of(context).size.height * -0.12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Calories",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("40cals / 100gms", maxLines: 2),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Ratings",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(product.rating),
                            Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                              size: 20,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                    transform: Matrix4.translationValues(
                        0, MediaQuery.of(context).size.height * -0.07, 0),
                    child: Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              Container(
                transform: Matrix4.translationValues(
                    0, MediaQuery.of(context).size.height * -0.05, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$" + product.price,
                        style: TextStyle(fontSize: 30),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        transform: Matrix4.translationValues(
                            MediaQuery.of(context).size.width * 0.42, 0, 0),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurStyle: BlurStyle.solid,
                                blurRadius: 20,
                                color: Colors.grey, //New
                                offset: Offset(0, 0))
                          ],
                          color: HexColor("#175244"),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            //int id = odata[index].id;
                            status
                                ? removefromwishlist(
                                    WishlistModel(id: product.id))
                                : addToWishlist(context, product.id);
                            // getIds();
                          },
                          icon: status
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          margin: EdgeInsets.only(right: 20),
                          transform: Matrix4.translationValues(
                              MediaQuery.of(context).size.width * 0.07, 0, 0),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 20,
                                  color: Colors.grey, //New
                                  offset: Offset(0, 0))
                            ],
                            color: HexColor("#175244"),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ))
                    ]),
              ),
              Container(
                transform: Matrix4.translationValues(
                    20, MediaQuery.of(context).size.height * -0.03, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    Container(
                        child: Text(
                      product.description,
                      style: TextStyle(fontSize: 15),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
