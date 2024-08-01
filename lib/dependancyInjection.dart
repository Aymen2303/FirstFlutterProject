
import 'package:get/get.dart';
import 'package:userdetailsapp/controller/network_controller.dart';

class Dependancyinjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}