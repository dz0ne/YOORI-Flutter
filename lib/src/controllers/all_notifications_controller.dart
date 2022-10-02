import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/models/all_notifications.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/constants.dart';

class AllNotificationsController extends GetxController {
  final _dataAvailable = false.obs;
  final noData = false.obs;
  final _isAllDeleted = false.obs;
  final _todaysNotifications = <Notifications>[].obs;
  final _othersNotifications = <Notifications>[].obs;
  final _allNotifications = <Notifications>[].obs;
  bool get dataAvailable => _dataAvailable.value;
  List<Notifications> get todaysNotification => _todaysNotifications;
  List<Notifications> get othersNotifications => _othersNotifications;
  List<Notifications> get allNotifications => _allNotifications;
  int page = 1;
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;
  var isMoreDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    paginateTask();
  }

  Future<void> fetchData() {
    return Repository().getAllNotifications(page).then((allNotifications) {
      if (allNotifications != null) {
        noData(allNotifications.data.notifications.isEmpty);
        _allNotifications.addAll(allNotifications.data.notifications);
        _dataAvailable(true);
      } else {
        noData(true);
      }
    }).catchError((error, stackTrace) {
      printLog("Error: $error");
    });
  }

  // For Pagination
  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isMoreDataAvailable.value) {
          page++;
          getMoreTask(page);
        }
      }
    });
  }

  Future<void> getMoreTask(int page) async {
    isMoreDataLoading(true);
    Repository().getAllNotifications(page).then((allNotifications) {
      if (allNotifications != null) {
        if (allNotifications.data.notifications.isNotEmpty) {
          isMoreDataAvailable(true);
          isMoreDataLoading(false);
        } else {
          isMoreDataAvailable(false);
          isMoreDataLoading(false);

          return;
        }
        //extract todays notifications
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        for (var item in allNotifications.data.notifications) {
          final dateToCheck = item.createdAt;
          final aDate =
              DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
          if (aDate == today) {
            _todaysNotifications.add(item);
          } else {
            _othersNotifications.add(item);
          }
        }
      }
    }).catchError((error, stackTrace) {
      isMoreDataAvailable(false);
    }).whenComplete(() => _othersNotifications);
  }

  Future<bool> deleteAllNotifications() async {
    return Repository()
        .deleteAllNotification()
        .then((value) {
          return value;
        })
        .onError(
            (error, stackTrace) => printLog("Error on notification delete."))
        .whenComplete(() {
          _isAllDeleted.value = true;
          _todaysNotifications.clear();
          _othersNotifications.clear();
          _allNotifications.clear();
          noData(true);
        });
  }

  void removeNotification(int id) {
    _othersNotifications.removeWhere((element) => element.id == id);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
