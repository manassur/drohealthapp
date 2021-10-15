import 'dart:async';
import 'package:drohealthapp/bloc/cart/product_bloc.dart';
import 'package:drohealthapp/model/store_model.dart';
import 'package:drohealthapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'store_state.dart';
import 'store_event.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState>{
  Repository? repository;

  StoreBloc({ @required this.repository});

  @override
  StoreState get initialState => StoreItemsInitialState();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is FetchStoreItemsEvent) {
      yield StoreItemsLoadingState();
      try{
        StoreModel?  storeItems = await repository!.fetchStoreItems();
        if(storeItems.categories!.length>0){
          yield StoreItemsLoadedState(storeItems:storeItems, message: "Store Items Loaded");
        }


        else{
          yield StoreItemsEmptyState(message: "No item to display ");
        }
      }catch(e){
        yield StoreItemsFailureState(error: e.toString());
      }
    }
  }

}