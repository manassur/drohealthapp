import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'bloc/cart/cart_bloc.dart';
import 'bloc/cart/product_bloc.dart';
import 'cart_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSaved = false;
  TextEditingController searchController = TextEditingController();
  bool showCancel=false;
  var productBloc;

  @override
  void initState() {
    productBloc = Provider.of<ProductBloc>(context,listen: false);
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        preferredSize: queryData.size.height>800? Size.fromHeight(queryData.size.height * 0.14):Size.fromHeight(queryData.size.height * 0.17),
        child: AppBar(
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
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
              child: Container(
                margin: const EdgeInsets.only(right:20.0,top: 10),
                child: Stack(
                  children: [
                    Image.asset('assets/express-delivery.png',height: 30,width: 30,color: Colors.white,),
                    Container(
                      margin: const EdgeInsets.only(left:15.0,top: 2),
                      child: CircleAvatar(radius: 4,backgroundColor: Colors.yellow,),
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
              Column(
                children: [
                  SizedBox(height:queryData.size.height>800?  queryData.size.height * 0.10:queryData.size.height * 0.08),

                  Container(
                    margin: EdgeInsets.only(top: 20,right: 20,left: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex:5,
                          child: Container(
                            height: 35,
                            child: TextField(
                              controller: searchController,
                              maxLines: 1,
                              style: TextStyle(fontSize: 17,color: Colors.white),
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                 showCancel = value.isNotEmpty;
                                });
                                productBloc.searchProduct(value);

                              },
                              decoration: InputDecoration(
                                filled: true,
                                prefixIcon:
                                Icon(Icons.search, color: Colors.white),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                fillColor: Colors.white.withOpacity(0.3),
                                contentPadding: EdgeInsets.zero,
                                hintStyle: TextStyle(color:Colors.white),
                                hintText: 'Search',
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible:searchController.text.isNotEmpty,
                          child: Expanded(
                            flex: 1,
                            child: InkResponse(
                              onTap: (){
                                searchController.clear();

                                setState(() {
                                  showCancel=false;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left:10),
                                  child: Text('Cancel',style: TextStyle(color: Colors.white),)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,

        child: Stack(
          children: [
            InkResponse(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> CartScreen()));

              },
              child: Container(
                width: 50,
                height: 50,
                child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 22,),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: <Color>[Color(0XFFFE806F), Color(0XFFE5366A)],
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0XFFFE806F),
                        offset: Offset(0.0, 1.5),
                        blurRadius: 1.5,
                      ),
                    ],
                ),

              ),
            ),
            Positioned(
              bottom: 30,
              left: 30,
              child: InkResponse(
                onTap: (){

                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                      child: Text(cart.length.toString(),
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),)),
                ),
              ),
            )
          ],
        ),
        onPressed: () {},
      ),

      body: Consumer<ProductBloc>(
          builder: (context, mockProducts, child) {
        return mockProducts.searchResult.isEmpty? Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/no_search_result.svg',width: 150,height: 150,),
              SizedBox(height: 20,),
              Text('No search result found for '+ searchController.text)
            ],
          ),
        ) : Container(
          // color: Colors.white,
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 20.0),
            itemCount: mockProducts.searchResult.length,
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(mockProducts.searchResult[index].image!),
                            )),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 15,left:15),
                      child: Text(
                        mockProducts.searchResult[index].name!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),


                    Padding(
                      padding: const EdgeInsets.only(right: 15,left:15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            mockProducts.searchResult[index].type!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 5, right: 5),
                            height: 4,
                            width: 4,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                BorderRadius.circular(30.0)),
                          ),
                          Row(
                            children: [
                              Text(
                                mockProducts.searchResult[index].mg! + "mg",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0,right: 15,left:15),
                      child: Row(
                        children: [
                          Text(
                            "\u{20A6}",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "400",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Color(0XFF9F5DE2).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  // if (isSaved == true) {
                                  //   setState(() {
                                  //     isSaved = false;
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     isSaved = true;
                                  //   });
                                  // }
                                },
                                child: Icon(
                                  isSaved == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isSaved == true
                                      ? Color(0XFF9F5DE2)
                                      : Color(0XFF9F5DE2),
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkResponse(
                      onTap: (){
                        mockProducts.searchResult[index].quantity=1;
                        bloc.addToCart(mockProducts.searchResult[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0XFF9F5DE2)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(
                                color: Color(0XFF9F5DE2),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );}
        ));

  }
}
