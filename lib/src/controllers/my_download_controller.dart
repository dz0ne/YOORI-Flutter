import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/my_download_model.dart';
import '../servers/repository.dart';

class MyDownloadController extends GetxController {
  late Rx<MyDownloadModel> myDownloadModel = MyDownloadModel().obs;

  Future getMyDownload() async {
    await Repository().getMyDownload().then((value) {
      myDownloadModel.value = value!;
    });
    update();
  }

  @override
  void onInit() {
    getMyDownload();
    super.onInit();
  }
}
