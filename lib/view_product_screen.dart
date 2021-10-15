import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'bloc/cart/cart_bloc.dart';
import 'cart_screen.dart';
import 'package:flutter/material.dart';
import 'model/store_model.dart';
import 'widget/button_widget.dart';

class ViewProductScreen extends StatefulWidget {
  Categories? categoriesItem;
  Products? productItems;
  StoreModel? storeItems;
   ViewProductScreen({Key? key, this.categoriesItem, this.productItems, this.storeItems}) : super(key: key);

  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}



class _ViewProductScreenState extends State<ViewProductScreen> {
  bool isSaved = false;
  int _counter = 0;


  void _incrementCounter() {
    setState(() {
      _counter++;

    });
  }
  void _decrementCounter() {
    if(_counter!=0){
    setState(() {
      _counter--;
    });
    }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cartItems;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: queryData.size.height>800? Size.fromHeight(queryData.size.height * 0.11):Size.fromHeight(queryData.size.height * 0.12),
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
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              Text('Pharmacy',style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
          actions: [
            InkResponse(
              onTap:(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> CartScreen()));

              },
              child: Container(
                margin: const EdgeInsets.only(right:15.0,top: 10),
                child: Stack(
                  children: [
                    Icon(Icons.shopping_cart_outlined,size: 30,color: Colors.white,),
                    Visibility(
                      visible: cart.isNotEmpty==true,
                      child: Container(
                        margin: const EdgeInsets.only(left:20.0,top: 2),
                        child: CircleAvatar(radius: 4,backgroundColor: Colors.yellow,),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
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
      body: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                       height: 150,
                       width: 150,
                       decoration: BoxDecoration(
                           color: Colors.grey.shade200,
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(10),
                             topRight: Radius.circular(10),
                           ),
                           image: new DecorationImage(
                             fit: BoxFit.cover,
                             image: NetworkImage (
                                 widget.productItems!.image!

                               // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3QoI87hUDuMMiH9e7-BfXJpE3-kaVXI0oDg&usqp=CAU'
                             ),
                           )
                         ),
                       ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                        child: Text(widget.productItems!.name!, style: TextStyle(color: Colors.black,  fontSize: 18, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.productItems!.type!,
                          style: TextStyle( fontSize: 16,color: Colors.grey,),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          height: 4,width:4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30.0)), ),

                        Text(
                          widget.productItems!.mg!+"mg",
                          style: TextStyle( fontSize: 16,color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          width: 50,
                          height:50,
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.grey),
                              image: new DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage (
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSs2px2lI6JSjTp7NfFJz1uSkAQ3_3P0AFAhA&usqp=CAU'
                                ),
                              )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SOLD BY",style: TextStyle( fontSize: 14,color: Colors.grey) ),
                            Text(widget.productItems!.soldBy!,style: TextStyle( fontSize: 14,color: Colors.blue.shade900) ),
                          ],
                        ),
                       Spacer(),
                       Container(
                         height: 30,
                         width: 30,
                         decoration: BoxDecoration(
                             color: Color(0XFF9F5DE2).withOpacity(0.1),
                             borderRadius: BorderRadius.circular(5.0)
                         ),

                        child: Center(
                          child: InkWell(
                            onTap: ()async  {
                              if ( isSaved == true ) {
                                setState ( () {
                                  isSaved = false;
                                } );
                              } else {
                                setState ( () {
                                  isSaved = true;
                                } );
                              }
                            },
                            child: Icon (
                                 isSaved == true
                                     ? Icons.favorite : Icons.favorite_border ,
                                 color: isSaved == true
                                     ? Color(0XFF9F5DE2)
                                     : Color(0XFF9F5DE2) ,
                             ),
                          ),
                        ) ,
                       ) ,
                      ],
                    ),

                    SizedBox(height: 20 ,),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height:40,
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey.shade500),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: (){
                                      _decrementCounter();
                                    },
                                    child: Icon(Icons.remove, size: 18, color: Colors.black,)),
                                Text( '$_counter',
                                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                                InkWell(
                                  onTap: (){
                                   _incrementCounter();
                                  },
                                    child: Icon(Icons.add, size: 18, color: Colors.black,)),
                              ],
                            ),
                          ),
                        ),
                        Text("Pack(s)", style: TextStyle(color: Colors.grey.shade500, fontSize: 17),),
                        Spacer(),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "\u{20A6}",
                                  style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold ),
                                  children: [
                                  ]),
                            ),
                          ],
                        ),
                        Text(widget.productItems!.price!,
                          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),

                        Text(".00",
                         style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:20.0, bottom: 15.0),
                      child: Text("PRODUCT DETAILS",style: TextStyle(color: Color(0XFF5C86CE).withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.bold) ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/tablets.svg', color: Color(0XFF9F5DE2),),
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("PACK SIZE",
                                      style: TextStyle( fontSize: 12,color:Color(0XFF5C86CE).withOpacity(0.8)),
                                    ),
                                    Text(widget.productItems!.packSize!,
                                      style: TextStyle( fontSize: 15,color:Color(0XFF5C86CE).withOpacity(0.9), fontWeight: FontWeight.w700),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                SvgPicture.asset('assets/tablet.svg', color: Color(0XFF9F5DE2),),
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("CONSTITUENTS",
                                      style: TextStyle( fontSize: 12,color:Color(0XFF5C86CE).withOpacity(0.8)),
                                    ),
                                    Text(widget.productItems!.constituents!,
                                      style: TextStyle( fontSize: 15,color:Color(0XFF5C86CE).withOpacity(0.9), fontWeight: FontWeight.w700),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/barcode.svg', color: Color(0XFF9F5DE2),),
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("PRODUCT ID",
                                      style: TextStyle( fontSize: 12,color:Color(0XFF5C86CE).withOpacity(0.8)),

                                    ),
                                    Text(widget.productItems!.productId!,
                                      style: TextStyle( fontSize: 15,color:Color(0XFF5C86CE).withOpacity(0.9), fontWeight: FontWeight.w700),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                SvgPicture.asset('assets/dispense.svg', color: Color(0XFF9F5DE2),),
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("DISPENSED IN",
                                      style: TextStyle( fontSize: 12,color:Color(0XFF5C86CE).withOpacity(0.8)),
                                    ),
                                    Text(widget.productItems!.dispensation!,
                                      style: TextStyle( fontSize: 15,color:Color(0XFF5C86CE).withOpacity(0.9), fontWeight: FontWeight.w700),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 30 ,),

                    Text(widget.productItems!.description!,
                    style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(height: 30 ,),

                    Text("Similar Products",
                      style: TextStyle(color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 170,
                            margin: EdgeInsets.only(right: 15,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  offset: Offset(2, 4), //(x,y)
                                  blurRadius: 6.0,
                                  spreadRadius: 1
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage (
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnh1s_yw7RjGl_pkEYvb3hN634Hg9-GNuu_w&usqp=CAU'
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 10,bottom:15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Paracetamol",
                                        style: TextStyle( fontSize: 17,color: Colors.black87,),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only( bottom: 10.0),
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
                                              height: 4,width:4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30.0)), ),

                                            Text(
                                              "500mg",
                                              style: TextStyle( fontSize: 16,color: Colors.grey),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Text("\u{20A6}",style: TextStyle( fontSize: 17,color: Colors.black, fontWeight: FontWeight.bold),
                                          ),
                                          Text("350.00",style: TextStyle( fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40 ,),
                  ],
                ),
              ),
            ),
          ),

          Container(
            color: Colors.white,
            child: InkResponse(
              onTap: (){
                if(_counter < 1){
                  Fluttertoast.showToast(msg: 'Please indicate quantity');

                }else{
                  widget.productItems!.quantity=_counter;
                  bloc.addToCart(widget.productItems!);
                  showModal();
                }

              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: RaisedGradientButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 25,),
                        Text("  Add to cart", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[Color(0XFF7A08FA), Color(0XFFAD3BFC)],
                    ),
                  onPressed: (){}, // a bug causing this to run on it's own

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showModal(){
     showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)
            )
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left:40.0, right: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(widget.productItems!.name! +" has been successfully added to cart!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 17),),
                  ),
                  InkResponse(
                    onTap: (){
                      Navigator.pop(context);

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:50.0, bottom: 20.0),
                      child: RaisedGradientButton(
                        child: Text("VIEW CART", style: TextStyle(color: Colors.white),),
                        gradient: LinearGradient(
                          colors: <Color>[Color(0XFF7A08FA), Color(0XFFAD3BFC)],
                        ),
                        onPressed: (){
                        },
                      ),
                    ),
                  ),

                  InkResponse(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0XFF7A08FA),
                          ),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Center(
                        child: Text("CONTINUE SHOPPING",
                          style: TextStyle(color:Color(0XFF7A08FA) ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }


}
