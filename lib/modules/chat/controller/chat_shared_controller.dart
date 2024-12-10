import 'package:get/get.dart';

/**
 * Created by Abdullah on 20/10/24.
 */

class ChatSharedController extends GetxController{
  String? currentUserId;
  String? chatPartnerId;
  String? chatSessionId;
  String? customer_id;


  setCustomerID(String? customer){
    customer_id = customer;
  }


  setChatSessionId(String? id){
    chatSessionId = id;
  }

  setCurrentUserId(String? id){
    currentUserId = id;
  }

  setChatPartnerId(String? id){
    chatPartnerId = id;
  }



}