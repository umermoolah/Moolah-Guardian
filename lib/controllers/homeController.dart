import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/endpoints.dart';
import 'package:moolah/helper/models/kids_model.dart';
import 'package:moolah/helper/models/response_model.dart';
import 'package:moolah/helper/network.dart';

class HomeController extends BaseController {

  List<Kid> connectedKids = [];


  Future<void> getSyncedKidDevices() async {
    ResponseModel responseModel = await Network.get(EndPoints.getSyncedKidDevicesUrl);

    List temp = responseModel.data["kid"];
    for(int i=0;i<temp.length;i++){
      connectedKids.add(Kid.fromJson(temp[i]));
    }
    //{"kidID": "String", "name": "String", "deviceType": "String", "batteryStatus": "String", "connectID": "String", "dataUsageStatus": "String", "lastActive": "String", "kidPic": "String", "walletEnabled": false}
  }


}