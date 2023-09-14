import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';
import 'package:moolah/helper/repo/singleKidRepo.dart';

import '../helper/endpoints.dart';
import '../helper/models/response_model.dart';
import '../helper/network.dart';

class SingleKidController extends BaseController {

  Future<void> enableWallet({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.enableWallet(kidId: kidId);
   isLoading = false;
  }
 Future<void> getAppUsage({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.getAppUsage(kidId: kidId);
   isLoading = false;
  }
 Future<void> blacklistApp({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.blacklistApp(kidId: kidId);
   isLoading = false;
  }
 Future<void> deleteApp({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.deleteApp(kidId: kidId);
   isLoading = false;
  }
 Future<void> getBlacklistedApps({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.getBlacklistedApps(kidId: kidId);
   isLoading = false;
  }
 Future<void> getNetworkHistory({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.getNetworkHistory(kidId: kidId);
   isLoading = false;
  }
 Future<void> getBlacklistUrls({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.getBlacklistUrls(kidId: kidId);
   isLoading = false;
  }
Future <void> blacklistUrl({int? kidId}) async {
    if(isLoading) return;
    isLoading = true;
   // ResponseModel responseModel = await SingleKidRepo.blacklistUrl(kidId: kidId);
   isLoading = false;
  }
}