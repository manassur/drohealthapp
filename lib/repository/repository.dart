import 'dart:convert';
import 'package:drohealthapp/model/store_model.dart';
import 'package:drohealthapp/utility/constants.dart' as Constants;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

abstract class UserService {}

class Repository extends UserService {
  ApiClient? _apiClient = ApiClient();
  SharedPreferences? prefs = null;

  Repository? repository ;

  void openCache() async {
    prefs = await SharedPreferences.getInstance();
  }

  /*
   * caches any string and key
   */
  void saveAnyStringToCache(String value,String key) async {
     openCache();
    // check if the key even exists
    prefs!.setString(key,value);
  }




  //FOR DRO HEALTH
  Future<StoreModel>fetchStoreItems() async {
    openCache();
    final response = await _apiClient!.get(Constants.FETCH_STORE_ITEMS);
    final data = json.decode(response);
    print("this is store items response  " + response.toString());
    return StoreModel.fromJson(data);
  }

}

