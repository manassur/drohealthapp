import 'package:drohealthapp/model/store_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


abstract class StoreState extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreItemsInitialState extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreItemsLoadingState extends StoreState {
  @override
  List<Object> get props => [];
}


class StoreItemsRefreshingState extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreItemsLoadedState extends StoreState {
  final StoreModel? storeItems;

  final String? message;
  StoreItemsLoadedState({@required this.storeItems, this.message});

  @override
  List<Object> get props => [];
}

class StoreItemsEmptyState extends StoreState{
  final String? message;
  StoreItemsEmptyState({@required this.message});

  @override
  List<Object> get props => [];
}

class StoreItemsFailureState extends StoreState {
  final String? error;

  StoreItemsFailureState({@required this.error});

  @override
  List<Object> get props => [error!];
}
