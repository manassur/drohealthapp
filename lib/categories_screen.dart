
import 'package:drohealthapp/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/store/store_bloc.dart';
import 'bloc/store/store_event.dart';
import 'bloc/store/store_state.dart';
import 'model/store_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  StoreBloc? storeItemsBloc;

  @override
  void initState() {
    storeItemsBloc = BlocProvider.of<StoreBloc>(context);
    storeItemsBloc!.add(FetchStoreItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: queryData.size.height>800? Size.fromHeight(queryData.size.height * 0.09):Size.fromHeight(queryData.size.height * 0.12),
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
              Text('Categories',style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
          actions: [
            InkResponse(
              onTap: (){

              },
              child: Container(
                margin: const EdgeInsets.only(right:15.0,top: 10),
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
            ],
          ),
        ),
      ),
      body:Container(
        margin: EdgeInsets.all(20.0),
        child: BlocListener <StoreBloc, StoreState>(
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
                return buildLoading ( );
              } else if ( state is StoreItemsLoadingState ) {
                return buildLoading ( );
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
      ),
    );
  }
  Widget buildCategoriesList(StoreModel categoriesModel){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0
      ),
      itemCount: categoriesModel.categories!.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Stack(
            children: [
              Container(
                height: 120,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage (
                          '${categoriesModel.categories![index].image}'
                      ),
                    )
                ),
              ),

              Container(
                height: 120,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color:Colors.black54,
                ),
                child: Center(child: Text("${categoriesModel.categories![index].name}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildLoading ( ) {
    return Container(
      margin: EdgeInsets.only(top:50),
      child: Center (
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)) ,
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
