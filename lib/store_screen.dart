
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/cart/cart_bloc.dart';
import 'bloc/cart/product_bloc.dart';
import 'bloc/store/store_state.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'model/store_model.dart';
import 'repository/repository.dart';
import 'search_screen.dart';
import 'bloc/store/store_bloc.dart';
import 'bloc/store/store_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view_product_screen.dart';

class StoreScreen extends StatefulWidget {
   StoreScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  StoreBloc? storeItemsBloc;

  @override
  void initState() {
    storeItemsBloc = BlocProvider.of<StoreBloc>(context);
    storeItemsBloc!.add(FetchStoreItemsEvent());
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
        preferredSize: queryData.size.height>800? Size.fromHeight(queryData.size.height * 0.15):Size.fromHeight(queryData.size.height * 0.17),
        child: AppBar(
          backgroundColor: Colors.grey.shade50,
          leading: Container(),
          elevation: 0,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height:queryData.size.height>800?  queryData.size.height * 0.08:queryData.size.height * 0.04),
                    Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Pharmarcy',style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                        Spacer(),
                        Stack(
                          children: [
                            IconButton(icon: Icon(Icons.favorite_border,color: Colors.white,size: 25,),
                              onPressed: () {

                              },),
                            Container(
                              margin: const EdgeInsets.only(left:30.0,top: 13),
                              child: CircleAvatar(radius: 4,backgroundColor: Colors.yellow,),
                            )
                          ],
                        ),
                        Stack(
                          children: [
                            Image.asset('assets/express-delivery.png',height: 30,width: 30,color: Colors.white,),
                            Container(
                              margin: const EdgeInsets.only(left:15.0,top: 2),
                              child: CircleAvatar(radius: 4,backgroundColor: Colors.yellow,),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> SearchScreen()));
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 20,color: Colors.white,),
                            Text(" Search", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:Visibility(
        visible: cart.isNotEmpty,

        child: Container(
          child: Align(
            alignment: Alignment.bottomRight,
            child: InkResponse(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));

              },
              child: Container(
                height: 50.0,
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    gradient: LinearGradient(
                      colors: <Color>[Color(0XFFFE806F), Color(0XFFE5366A)],
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0XFFFE806F).withOpacity(0.2),
                        offset: Offset(2, 4),
                        blurRadius: 1.5,
                        spreadRadius: 3
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 15),),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8.0),
                      child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 16,),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                          child: Text(cart.length.toString(),
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Container(
                    color:  Colors.grey.shade50,
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.black87,size: 20, ),
                        Text("Delivery in ",style: TextStyle(fontSize: 14, color: Colors.black), ),
                        Text("Lagos, NG",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text( "CATEGORIES", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1, color: Colors.grey )),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                BlocProvider<StoreBloc>(
                                  create: (context) => StoreBloc(repository: Repository()),
                                  child: CategoriesScreen(),
                            ),
                            ),
                            );
                          },
                            child: Text( "VIEW ALL", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0XFF9F5DE2) ))),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),

                  BlocListener <StoreBloc, StoreState>(
                    listener: (context, state){
                      if ( state is StoreItemsLoadedState && state.message != null ) {
                      } else if (state is StoreItemsEmptyState){

                      }
                      else if ( state is StoreItemsFailureState ) {
                        Scaffold.of ( context ).showSnackBar ( SnackBar (
                          content: Text ( "Could not load category items at this time" ),
                        ) );
                      }
                    },

                     child: BlocBuilder<StoreBloc, StoreState>(
                      builder: (context, state) {
                        if ( state is StoreItemsInitialState ) {
                          return buildCategoriesShimmer ( );
                        } else if ( state is StoreItemsLoadingState ) {
                          return buildCategoriesShimmer ();
                        } else if ( state is StoreItemsLoadedState ) {
                          return buildCategoriesList (state.storeItems!);
                        } else if ( state is StoreItemsFailureState ) {
                          return buildErrorUi ( state.error! );
                        } else if (state is StoreItemsEmptyState){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Center(child: Text(state.message!, style: TextStyle(color:Colors.black, fontSize: 18.0, fontStyle: FontStyle.italic),)),
                          );
                        }
                        else {
                          return buildErrorUi ( "Something went wrong!" );
                        }
                      },
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text( "SUGGESTIONS", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  BlocListener <StoreBloc, StoreState>(
                    listener: (context, state){
                      if ( state is StoreItemsLoadedState && state.message != null ) {
                      } else if (state is StoreItemsEmptyState){

                      }
                      else if ( state is StoreItemsFailureState ) {
                        Scaffold.of ( context ).showSnackBar ( SnackBar (
                          content: Text ( "Could not load category items at this time" ),
                        ) );
                      }
                    },

                    child: BlocBuilder<StoreBloc, StoreState>(
                      builder: (context, state) {
                        if ( state is StoreItemsInitialState ) {
                          return buildProductListShimmer ( );
                        } else if ( state is StoreItemsLoadingState ) {
                          return buildProductListShimmer ( );
                        } else if ( state is StoreItemsLoadedState ) {
                          // initialize the mock cache
                          Provider.of<ProductBloc>(context).initialize(state.storeItems!.products!);
                          return buildProductList (state.storeItems!);

                        } else if ( state is StoreItemsFailureState ) {
                          return buildErrorUi ( state.error! );
                        } else if (state is StoreItemsEmptyState){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Center(child: Text(state.message!, style: TextStyle(color:Colors.black, fontSize: 18.0, fontStyle: FontStyle.italic),)),
                          );
                        }
                        else {
                          return buildErrorUi ( "Something went wrong!" );
                        }
                      },
                    ),
                  ),


                ],
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget buildCategoriesList(StoreModel categoriesModel){
    return Container(
      height: 130,
      padding: EdgeInsets.only(left: 15.0),
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesModel.categories!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.0),
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage (
                            '${categoriesModel.categories![index].image}'
                              // 'https://images.pexels.com/photos/3771115/pexels-photo-3771115.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'
                          ),
                        )
                    ),
                  ),

                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:Colors.black38,
                    ),
                    child: Center(child: Text("${categoriesModel.categories![index].name}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCategoriesShimmer(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Container(
        height: 130,
        padding: EdgeInsets.only(left: 15.0),
        child: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0),
                        
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildProductList(StoreModel categoriesModel){
    return GridView.builder (
      padding: EdgeInsets.symmetric ( horizontal: 25 ) ,
      scrollDirection: Axis.vertical ,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 25.0,
          mainAxisSpacing: 25.0
      ),
      itemCount: categoriesModel.products!.length,
      shrinkWrap: true ,
      itemBuilder: (ctx, index) {
        return InkWell(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> ViewProductScreen(productItems: categoriesModel.products![index],)));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade50,
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
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
                          image: NetworkImage (
                            '${categoriesModel.products![index].image}',
                          ),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${categoriesModel.products![index].name}",
                          style: TextStyle( fontSize: 16,color: Colors.black87,),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:7.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Text(
                                "${categoriesModel.products![index].type}",
                                style: TextStyle( fontSize: 14,color: Colors.grey,),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                height: 4,width:4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30.0)), ),

                              Row(
                                children: [
                                  Text(
                                    "${categoriesModel.products![index].mg!+"mg"}",
                                    style: TextStyle( fontSize: 14,color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Text("\u{20A6}",style: TextStyle( fontSize: 17,color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text("${categoriesModel.products![index].price}" ,style: TextStyle( fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                            Text(".00",style: TextStyle( fontSize: 17,color: Colors.black, fontWeight: FontWeight.bold),),

                              ],
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      } ,
    );
  }
  Widget buildProductListShimmer(){
    return GridView.builder (
      padding: EdgeInsets.symmetric ( horizontal: 25 ) ,
      scrollDirection: Axis.vertical ,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 25.0,
          mainAxisSpacing: 25.0
      ),
      itemCount: 6,
      shrinkWrap: true ,
      itemBuilder: (ctx, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade50,
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade50,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),

                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade50,
                        child: Container(
                          color: Colors.grey.shade200,
                          height: 15,
                          width: 50,

                        ),
                      ),
                      SizedBox(height: 10,),

                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade50,
                        child: Container(
                          color: Colors.grey.shade200,
                          height: 15,
                          width: 100,

                        ),
                      ),

                      SizedBox(height: 10,),

                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade50,
                        child: Container(
                          color: Colors.grey.shade200,
                          height: 15,
                          width: 50,

                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      } ,
    );
  }

  Widget buildLoading ( ) {
    return Container(
      margin: EdgeInsets.only(top:50),
      child: Center (
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent)) ,
      ),
    );
  }

  Widget buildErrorUi ( String message ) {
    return Center (
      child: Text ( message , style: TextStyle ( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );
  }
}
