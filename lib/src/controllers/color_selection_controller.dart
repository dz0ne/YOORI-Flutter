import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yoori_ecommerce/src/models/product_details_model.dart';

class ColorSelectionController extends GetxController {
  RxInt selectedIndex = 50000.obs;
  late int _attrSize = 0;
  var selectedArray = [].obs;
  RxString selectedAttrName = "".obs;
  RxString selectedAttrId = "".obs;
  late final List<String> _selectedAttrNameList = [];
  late final List<String> _selectedAttrIdList = [];
  late String _selectedColorName = "";
  late String _selectedColorId = "";

  _generateAttrNames() {
    String names = "";
    for (var i = 0; i < _selectedAttrNameList.length; i++) {
      names = "$names-${_selectedAttrNameList[i]}";
    }
    selectedAttrName.value = _selectedColorName + names;
  }

  _generateAttrIds() {
    String ids = "";
    for (var i = 0; i < _selectedAttrIdList.length; i++) {
      ids = "$ids-${_selectedAttrIdList[i]}";
    }
    selectedAttrId.value = _selectedColorId + ids;
  }

  insertAttrNameToList({required String name, required int index}) {
    _selectedAttrNameList.removeAt(index);
    _selectedAttrNameList.insert(index, name);
    _generateAttrNames();
  }

  insertAttrIdToList({required String id, required int index}) {
    _selectedAttrIdList.removeAt(index);
    _selectedAttrIdList.insert(index, id);
    _generateAttrIds();
  }

  changeAttrSelection({required int attrIndex, required int value}) {
    selectedArray[attrIndex] = value;
  }

  changeColorSelection(
      {required int index,
      required String colorName,
      required String colorId}) {
    selectedIndex.value = index;
    _selectedColorName = colorName;
    _selectedColorId = colorId;
    _generateAttrNames();
    _generateAttrIds();
  }

  setAttrData(int attrSize, List<Attributes> data, List<ColorsData> colorList) {
    _attrSize = attrSize;
    _generateArray();
  }

  _generateArray() {
    selectedArray = RxList<int>.filled(_attrSize, 500);
    for (var i = 0; i < _attrSize; i++) {
      _selectedAttrNameList.insert(i, "**");
      _selectedAttrIdList.insert(i, "**");
    }
  }
}
