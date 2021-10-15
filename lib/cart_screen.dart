import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'bloc/cart/cart_bloc.dart';
import 'model/store_model.dart';


class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cartItems;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: queryData.size.height>800? Size.fromHeight(queryData.size.height * 0.09):Size.fromHeight(queryData.size.height * 0.11),
        child: AppBar(
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
          titleSpacing: 0,
          automaticallyImplyLeading: false,

          centerTitle: false,
          title:  Row(
            children: [
              SizedBox(width: 5,),
              IconButton(
                onPressed: () { Navigator.pop(context);},
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              Icon(Icons.shopping_cart_outlined,size: 20,color: Colors.white,),
              SizedBox(width: 10,),
              Text('Cart',style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),

          flexibleSpace: Stack(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('assets/appbar_bg.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child:cart.isEmpty? Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/empty_cart.svg',width: 150,height: 150,),
                    SizedBox(height: 20,),
                    Text('No items in your cart yet')
                  ],
                ),
              ): ListView.separated(
                itemCount: cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Container(
                    height: 110,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage (
                                  cart[index].image!
                                ),
                              )
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cart[index].name!,
                              style: TextStyle( fontSize: 17,color: Colors.black87,),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Padding(
                              padding: const EdgeInsets.only( bottom: 10.0, top: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Tablet",
                                    style: TextStyle( fontSize: 16,color: Colors.grey,),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 8, right: 8),
                                    height: 3,width:3, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30.0)), ),

                                  Text(
                                    cart[index].mg!,
                                    style: TextStyle( fontSize: 16,color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                Text("\u{20A6}",style: TextStyle( fontSize: 16,color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                                Text((double.parse(cart[index].price!) *  cart[index].quantity!).toString(),style: TextStyle( fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),)
                              ],
                            )
                          ],
                        ),
                        Spacer(),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkResponse(
                              onTap:(){
                                showNumberPicker(cart[index]);
                              },
                              child: Container(
                                width: 60,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(cart[index].quantity!.toString(), style: TextStyle(color: Colors.black87, fontSize: 16),),
                                      Spacer(),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            InkResponse(
                              onTap:(){
                               bloc.removeFromCart(cart[index].id!);
                             },
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline_rounded, color: Color(0XFF9F5DE2),),
                                  Text("Remove", style: TextStyle(color: Color(0XFF9F5DE2)),)
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },

                separatorBuilder: (context, builder){
                  return Divider(color: Colors.grey,);
                },

              ),
            ),

            Visibility(
              visible: cart.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Total:", style: TextStyle(color: Colors.black87, fontSize: 14),),
                    Text("\u{20A6} ${bloc.getTotal()}", style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),),

                    Container(
                      width: 190,
                      height: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            colors: <Color>[Color(0XFF7A08FA), Color(0XFFAD3BFC)],
                          ),
                          boxShadow: [
                        BoxShadow(
                          color: Color(0XFF7A08FA).withOpacity(0.5),
                          offset: Offset(2, 4),
                          blurRadius: 6,
                          spreadRadius: 1
                        ),
                      ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap:(){},
                          child: Center(child: Text("CHECKOUT", style: TextStyle(color: Colors.white),)),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showNumberPicker(Products product){
    var bloc = Provider.of<CartBloc>(context,listen: false);
    showDialog(context: context, builder: (BuildContext context)
    {
      return new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        title: new Text("Choose quantity"),
        content: Container(
          width: 20,
          child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text((index+1).toString()),
                  onTap: (){
                    product.quantity=index+1; // update the product quantity
                    bloc.addToCart(product);// update that item in the cart repo
                    Navigator.pop(context);
                  },
                );
              }),
        ),
      );
    });}




}
