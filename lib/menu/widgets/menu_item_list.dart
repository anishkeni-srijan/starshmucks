import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:starshmucks/common_things.dart';

import '../../home/home_screen.dart';
import '../../model/wishlist_model.dart';
import '../../productdetail.dart';

class MenuItemList extends StatelessWidget {
  const MenuItemList({Key? key, this.data, required this.fToast})
      : super(key: key);
  final data;
  final FToast fToast;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        bool status = false;
        for (var i = 0; i < ids.length; i++) {
          if (ids[i] == data[index].id) status = true;
        }
        return GestureDetector(
          onTap: () {
            getItem(data[index]);
            Get.to(() => const ProductDetail(),
                transition: Transition.downToUp);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: HexColor("#175244"), width: 0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Image.asset(
                    data[index].image,
                    width: 120,
                    height: 120,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 150,
                        child: AutoSizeText(
                          data[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        " \$ ${data[index].price}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Row(
                        children: <Widget>[
                          AutoSizeText(
                            data[index].rating,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                            minFontSize: 12,
                            maxFontSize: 18,
                          ),
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amberAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            //int id = odata[index].id;
                            status
                                ? removefromwishlist(
                                    WishlistModel(id: data[index].id))
                                : addToWishlist(data[index].id);
                            getIds();
                          },
                          icon: Icon(
                            status ? Icons.favorite : Icons.favorite_border,
                            color: HexColor("#036635"),
                          )),
                      TextButton(
                        onPressed: () {
                          addToCart(data[index].id);
                          String toastMessage = "ITEM ADDED TO CART";
                          fToast.showToast(
                            child: CustomToast(toastMessage),
                            positionedToastBuilder: (context, child) =>
                                Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.14,
                              left: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.1,
                              child: child,
                            ),
                          );
                          cartinit = true;
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              index % 2 == 0
                                  ? Colors.teal
                                  : Colors.deepOrangeAccent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}