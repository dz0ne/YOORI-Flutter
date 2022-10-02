class MyDownloadModel {
  bool? success;
  String? message;
  List<DownloadUrls>? downloadUrl;
  bool? nextPageUrl;

  MyDownloadModel(
      {this.success, this.message, this.downloadUrl, this.nextPageUrl});

  MyDownloadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['download_urls'] != null) {
      downloadUrl = <DownloadUrls>[];
      json['download_urls'].forEach((v) {
        downloadUrl!.add(DownloadUrls.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (downloadUrl != null) {
      data['download_urls'] =
          downloadUrl!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    return data;
  }
}

class DownloadUrls {
  int? id;
  String? url;
  String? productName;
  String? date;
  int? total;

  DownloadUrls({this.id, this.url, this.productName, this.date, this.total});

  DownloadUrls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    productName = json['product_name'];
    date = json['date'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['product_name'] = productName;
    data['date'] = date;
    data['total'] = total;
    return data;
  }
}
