import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transitions;
import '../../common_things.dart';
import '../../menu/bloc/menu_bloc.dart';
import '../../menu/bloc/menu_events.dart';
import '../../model/wishlist_model.dart';
import '../../productdetail.dart';
import '../home_screen.dart';

class HomeItemList extends StatelessWidget {
  const HomeItemList({Key? key, this.data, required this.fToast})
      : super(key: key);
  final data;
  final FToast fToast;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        bool status = false;
        for (var i = 0; i < ids.length; i++) {
          if (ids[i] == data[index].id) status = true;
        }
        return Row(
          children: [
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                getItem(data[index]);
                // Get.to(() => const ProductDetail(),
                //     transition: Transition.downToUp);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.deepOrangeAccent : Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.76,
                child: Stack(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(-10, 20, 0),
                      child: Image.asset(
                        data[index].image,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 130,
                      ),
                      child: Text(
                        data[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                        left: 130,
                      ),
                      child: Text(
                        data[index].tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      // transform: Matrix4.translationValues(-320, 40, 0),
                      margin: const EdgeInsets.only(
                        top: 85,
                        left: 190,
                      ),
                      child: TextButton(
                        onPressed: () {
                          BlocProvider.of<MenuBloc>(context).add(
                              OnAddToCartEvent(data[index].id, fToast)
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              HexColor('#175244')),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: const Text('Add'),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        status
                            ? removefromwishlist(
                                WishlistModel(id: data[index].id),context)
                            : addToWishlist(data[index].id);
                        getIds();
                      },
                      icon: Icon(
                        status ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
